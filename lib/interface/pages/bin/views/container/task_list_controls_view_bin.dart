import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager_pro/configs/configs.dart';
import 'package:task_manager_pro/interface/pages/bin/logic/logic_bin.dart';
import 'package:task_manager_pro/interface/shared/shared.dart';

/// Renders the search bar for the task list in the bin.
/// Renderiza la barra de búsqueda para la lista de tareas en la papelera.
class TaskListControlsViewBin extends HookConsumerWidget {
  const TaskListControlsViewBin({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final InternationalizationLocalizations l10n =
        InternationalizationLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final controller = useTextEditingController();
    return SizedBox(
      width: context.width(100),
      child: SearchBar(
        controller: controller,
        leading: Icon(Icons.search),
        hintText: l10n.searchTask,
        hintStyle: WidgetStateProperty.all(
          textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: [
          if (controller.text.isNotEmpty)
            Semantics(
              button: true,
              label: l10n.clearSearch,
              child: IconButton(
                tooltip: l10n.clearSearch,
                onPressed: () {
                  controller.clear();
                  ref.read(listLogicBinProvider.notifier).clearFilters();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                icon: Icon(Icons.clear),
              ),
            ),
        ],
        textInputAction: TextInputAction.search,
        constraints: const BoxConstraints(minHeight: 45),
        onChanged: (value) {
          ref.read(listLogicBinProvider.notifier).search(value);
        },
        onSubmitted: (value) {
          ref.read(listLogicBinProvider.notifier).search(value);
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager_pro/configs/configs.dart';
import 'package:task_manager_pro/interface/pages/tasks/dialogs/dialogs_tasks.dart';
import 'package:task_manager_pro/interface/pages/tasks/logic/logic_tasks.dart';

/// Horizontal bar with search field and filter button for the tasks list.
/// Search updates list logic; filter opens [FilterDialogTasks] (fullscreen on iOS).
///
/// Barra horizontal con campo de búsqueda y botón de filtro para la lista de
/// tareas. La búsqueda actualiza la lógica de lista; el filtro abre
/// [FilterDialogTasks] (pantalla completa en iOS).
class TaskListControlsViewTasks extends HookConsumerWidget {
  const TaskListControlsViewTasks({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final InternationalizationLocalizations l10n =
        InternationalizationLocalizations.of(context)!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final controller = useTextEditingController();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
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
                      ref.read(listLogicTasksProvider.notifier).clearFilters();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
            ],
            textInputAction: TextInputAction.search,
            constraints: const BoxConstraints(minHeight: 45),
            onChanged: (value) {
              ref.read(listLogicTasksProvider.notifier).search(value);
            },
            onSubmitted: (value) {
              ref.read(listLogicTasksProvider.notifier).search(value);
            },
          ),
        ),
        SizedBox(width: 10),
        Semantics(
          button: true,
          label: l10n.filterTasks,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(0, 45),
              elevation: 5,
            ),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();

              final platform = Theme.of(context).platform;

              if (platform == TargetPlatform.iOS) {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const FilterDialogTasks(),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => const FilterDialogTasks(),
                );
              }
            },
            icon: Icon(Icons.filter_list_rounded),
            label: Text(l10n.filter),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager_pro/configs/configs.dart';
import 'package:task_manager_pro/core/core.dart';
import 'package:task_manager_pro/interface/pages/tasks/components/components_tasks.dart';
import 'package:task_manager_pro/interface/pages/tasks/logic/logic_tasks.dart';
import 'package:task_manager_pro/interface/shared/shared.dart'
    show
        CategoryLabelHelperShared,
        PriorityLabelLogicShared,
        categoryLogicSharedProvider,
        priorityLogicSharedProvider;

/// Modal dialog that allows filtering the task list by category, priority,
/// and completion status. Reads categories/priorities and current filters
/// from providers; applies filters via list logic and closes on apply.
///
/// Diálogo modal que permite filtrar la lista de tareas por categoría,
/// prioridad y estado de completado. Lee categorías/prioridades y filtros
/// actuales desde providers; aplica filtros mediante la lógica de lista y se cierra al aplicar.
class FilterDialogTasks extends ConsumerStatefulWidget {
  const FilterDialogTasks({super.key});

  @override
  ConsumerState<FilterDialogTasks> createState() => _FilterDialogTasksState();
}

/// State for [FilterDialogTasks]. Holds selected category, priority and
/// completion status and builds the filter options and apply action.
///
/// Estado de [FilterDialogTasks]. Mantiene categoría, prioridad y estado de
/// completado seleccionados y construye las opciones de filtro y la acción aplicar.
class _FilterDialogTasksState extends ConsumerState<FilterDialogTasks> {
  TaskCategoryDataRule? _selectedCategory;
  TaskPriorityDataRule? _selectedPriority;
  bool? _selectedIsCompleted;

  @override
  void initState() {
    super.initState();
    final listState = ref
        .read(listLogicTasksProvider)
        .when(
          data: (TaskListState d) => d,
          loading: () => null,
          error: (_, _) => null,
        );
    if (listState != null) {
      _selectedCategory = listState.category;
      _selectedPriority = listState.priority;
      _selectedIsCompleted = listState.isCompleted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final InternationalizationLocalizations l10n =
        InternationalizationLocalizations.of(context)!;
    final List<TaskCategoryDataRule> taskCategories =
        ref.watch(categoryLogicSharedProvider).value ?? [];
    final List<TaskPriorityDataRule> taskPriorities =
        ref.watch(priorityLogicSharedProvider).value ?? [];
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      elevation: 0.5,
      child: SafeArea(
        child: Column(
          children: [
            _headerView(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: _optionsView(
                  context,
                  l10n,
                  taskCategories,
                  taskPriorities,
                ),
              ),
            ),
            _actionView(context, l10n),
          ],
        ),
      ),
    );
  }

  Column _optionsView(
    BuildContext context,
    InternationalizationLocalizations l10n,
    List<TaskCategoryDataRule> taskCategories,
    List<TaskPriorityDataRule> taskPriorities,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: CustomRadioGroupComponentTasks(
            title: l10n.category,
            value: _selectedCategory,
            items: taskCategories
                .map(
                  (category) => CustomRadioItemModel(
                    value: category,
                    label: CategoryLabelHelperShared.getDisplayName(
                      l10n,
                      category.name,
                    ),
                  ),
                )
                .toList(),
            onChanged: (category) {
              setState(() => _selectedCategory = category);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: CustomRadioGroupComponentTasks(
            title: l10n.priority,
            value: _selectedPriority,
            items: taskPriorities
                .map(
                  (priority) => CustomRadioItemModel(
                    value: priority,
                    label: PriorityLabelLogicShared.getDisplayName(
                      l10n,
                      priority.name,
                    ),
                  ),
                )
                .toList(),
            onChanged: (priority) {
              setState(() => _selectedPriority = priority);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: CustomRadioGroupComponentTasks<bool?>(
            title: l10n.completionStatus,
            value: _selectedIsCompleted,
            items: [
              CustomRadioItemModel<bool?>(value: null, label: l10n.all),
              CustomRadioItemModel<bool?>(value: true, label: l10n.completed),
              CustomRadioItemModel<bool?>(
                value: false,
                label: l10n.notCompleted,
              ),
            ],
            onChanged: (isCompleted) {
              setState(() => _selectedIsCompleted = isCompleted);
            },
          ),
        ),
      ],
    );
  }

  Padding _actionView(
    BuildContext context,
    InternationalizationLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: FilledButton(
        onPressed: () {
          ref
              .read(listLogicTasksProvider.notifier)
              .filter(
                category: _selectedCategory,
                priority: _selectedPriority,
                isCompleted: _selectedIsCompleted,
              );
          Navigator.pop(context);
        },
        child: Text(l10n.filter),
      ),
    );
  }

  Padding _headerView(BuildContext context) {
    final InternationalizationLocalizations l10n =
        InternationalizationLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(l10n.filterTasks)),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

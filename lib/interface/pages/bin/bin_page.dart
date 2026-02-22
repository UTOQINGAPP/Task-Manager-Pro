import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_pro/configs/configs.dart';
import 'package:task_manager_pro/core/core.dart'
    show TaskDataRule, TaskCategoryDataRule, TaskPriorityDataRule;
import 'package:task_manager_pro/interface/pages/bin/logic/logic_bin.dart';
import 'package:task_manager_pro/interface/pages/bin/views/views_bin.dart';
import 'package:task_manager_pro/interface/shared/shared.dart';

class BinPage extends ConsumerStatefulWidget {
  static const String name = 'bin';
  static const String path = '/bin';

  /// Creates a BinPage widget.
  /// Crea un widget BinPage.
  const BinPage({super.key});

  @override
  ConsumerState<BinPage> createState() => _BinPageState();
}

class _BinPageState extends ConsumerState<BinPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(deleteAndRestoreTaskLogicBinProvider.notifier)
          .disableSelectionMode();
      ref
          .read(deleteAndRestoreTaskLogicBinProvider.notifier)
          .clearSelectedTasks();
    });
  }

  @override
  Widget build(BuildContext contextf) {
    // Single place that reads state: all data for the FAB comes from here.
    // Único lugar que lee estado: todos los datos del FAB salen de aquí.
    final InternationalizationLocalizations l10n =
        InternationalizationLocalizations.of(context)!;

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Papelera'),
        centerTitle: false,
        leading: IconButton(
          onPressed: () =>
              ref.read(deleteAndRestoreTaskLogicBinProvider).deletedCount > 0 ||
                  ref.read(deleteAndRestoreTaskLogicBinProvider).restoredCount >
                      0
              ? context.pop(true)
              : context.pop(false),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          Semantics(
            button: true,
            label: l10n.emptyTrash,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(0, 45),
                elevation: 5,
              ),
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                await ref.read(listLogicBinProvider.notifier).deleteAll();
              },
              icon: Icon(
                Icons.delete_sweep_rounded,
                color: Theme.of(context).colorScheme.error,
              ),
              label: Text(
                l10n.emptyTrash,
                style: textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: _bodyView(context, ref),

      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: _floatingActionButtonView(context, ref),
    );
  }

  /// Builds the main body: controls and task list (shared component).
  /// Construye el cuerpo principal: controles y lista de tareas (componente compartido).
  Widget _bodyView(BuildContext context, WidgetRef ref) {
    final InternationalizationLocalizations l10n =
        InternationalizationLocalizations.of(context)!;
    final List<TaskCategoryDataRule> taskCategories =
        ref.watch(categoryLogicSharedProvider).value ?? [];
    final List<TaskPriorityDataRule> taskPriorities =
        ref.watch(priorityLogicSharedProvider).value ?? [];
    final List<TaskDataRule> visibleTasks =
        ref.watch(listLogicBinProvider).value?.visibleTasks ?? <TaskDataRule>[];
    final List<ItemTaskListView> items = _mapTasksToSharedItemsBin(
      context: context,
      ref: ref,
      tasks: visibleTasks,
      taskCategories: taskCategories,
      taskPriorities: taskPriorities,
      l10n: l10n,
    );
    return SizedBox(
      width: context.width(100),
      height: context.height(100),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TaskListControlsViewBin(),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: TaskListViewComponentShared(
              items: items,
              isLoading: ref.watch(listLogicBinProvider).isLoading,
              error: ref.watch(listLogicBinProvider).error?.toString(),
              onRefresh: () =>
                  ref.read(listLogicBinProvider.notifier).refresh(),
              onRetry: () => ref.read(listLogicBinProvider.notifier).refresh(),
              config: ConfigTaskListView(
                skeletonGradientStartColor: taskCategories.isNotEmpty
                    ? Color(taskCategories.first.color)
                    : null,
                skeletonGradientEndColor: taskPriorities.isNotEmpty
                    ? Color(taskPriorities.first.color)
                    : null,
              ),
              copy: StringsTaskListView(
                emptyTitle: l10n.noTasks,
                emptySubtitle: l10n.createTaskToStart,
                errorTitle: l10n.errorLoadingTasks,
                reload: l10n.reload,
                pullToRefresh: l10n.pullToRefresh,
                placeholderSkeletonTitle: l10n.placeholderTaskTitle,
                placeholderSkeletonSubtitle: l10n.placeholderTaskDescription,
                skeletonChipLabels: [
                  taskCategories.isNotEmpty
                      ? CategoryLabelHelperShared.getDisplayName(
                          l10n,
                          taskCategories.first.name,
                        )
                      : '',
                  taskPriorities.isNotEmpty
                      ? PriorityLabelLogicShared.getDisplayName(
                          l10n,
                          taskPriorities.first.name,
                        )
                      : '',
                  '',
                ],
              ),
              emptyIcon: Icons.inbox_outlined,
              errorIcon: Icons.error_outline,
            ),
          ),
        ],
      ),
    );
  }

  /// Maps [TaskDataRule] list (bin) to [ItemTaskListView] for the shared list component.
  /// Mapea lista de [TaskDataRule] (papelera) a [ItemTaskListView] para el componente compartido.
  List<ItemTaskListView> _mapTasksToSharedItemsBin({
    required BuildContext context,
    required WidgetRef ref,
    required List<TaskDataRule> tasks,
    required List<TaskCategoryDataRule> taskCategories,
    required List<TaskPriorityDataRule> taskPriorities,
    required InternationalizationLocalizations l10n,
  }) {
    const TaskCategoryDataRule fallbackCategory = TaskCategoryDataRule(
      id: '',
      name: '',
      color: 0xFF9E9E9E,
      createdAt: 0,
    );
    const TaskPriorityDataRule fallbackPriority = TaskPriorityDataRule(
      id: '',
      name: '',
      color: 0xFF9E9E9E,
      sortOrder: 0,
      createdAt: 0,
    );
    return tasks.map((TaskDataRule task) {
      final TaskCategoryDataRule category =
          taskCategories
              .where((c) => c.id == task.taskCategoryId)
              .firstOrNull ??
          (taskCategories.isNotEmpty ? taskCategories.first : fallbackCategory);
      final TaskPriorityDataRule priority =
          taskPriorities
              .where((p) => p.id == task.taskPriorityId)
              .firstOrNull ??
          (taskPriorities.isNotEmpty ? taskPriorities.first : fallbackPriority);
      final bool isSelectionMode = ref
          .watch(deleteAndRestoreTaskLogicBinProvider)
          .isSelectionMode;
      final bool isSelected = ref
          .watch(deleteAndRestoreTaskLogicBinProvider)
          .selectedTaskIds
          .contains(task.id);
      final Color categoryColor = Color(category.color);
      final Color priorityColor = Color(priority.color);
      final Color tertiaryColor = Theme.of(
        context,
      ).colorScheme.onTertiaryContainer;
      return ItemTaskListView(
        id: task.id,
        title: task.title,
        subtitle: task.description,
        gradientStartColor: categoryColor,
        gradientEndColor: priorityColor,
        leading: isSelectionMode
            ? Checkbox(
                value: isSelected,
                semanticLabel: '${l10n.selectTask}: ${task.title}',
                onChanged: (bool? value) {
                  if (value == true) {
                    ref
                        .read(deleteAndRestoreTaskLogicBinProvider.notifier)
                        .addSelectedTask(task.id);
                  } else {
                    ref
                        .read(deleteAndRestoreTaskLogicBinProvider.notifier)
                        .removeSelectedTask(task.id);
                  }
                },
              )
            : null,
        chips: [
          ChipItemTaskListView(
            label: CategoryLabelHelperShared.getDisplayName(
              l10n,
              category.name,
            ),
            backgroundColor: categoryColor,
            borderColor: categoryColor,
            shadowColor: categoryColor,
          ),
          ChipItemTaskListView(
            label: PriorityLabelLogicShared.getDisplayName(l10n, priority.name),
            backgroundColor: priorityColor,
            borderColor: priorityColor,
            shadowColor: priorityColor,
          ),
          ChipItemTaskListView(
            label: DateFormat(
              'dd/MM/yyyy',
            ).format(DateTime.fromMillisecondsSinceEpoch(task.dueDate)),
            backgroundColor: tertiaryColor,
            borderColor: tertiaryColor,
            shadowColor: priorityColor,
          ),
        ],
        onTap: null,
        semanticsLabel: '${l10n.openTask}: ${task.title}',
      );
    }).toList();
  }

  /// Builds FAB: either delete-selection actions or create/select-all/create.
  /// Construye el FAB: acciones de borrado en selección o crear/seleccionar todo/crear.
  Widget _floatingActionButtonView(BuildContext context, WidgetRef ref) {
    final int selectedTasksCount = ref
        .watch(deleteAndRestoreTaskLogicBinProvider)
        .selectedTasksCount;
    if (selectedTasksCount >= 1) {
      return _deleteAndRestoreTaskFloatingActionButtonSubView(context, ref);
    }
    return _selectionTaskFloatingActionButtonSubView(context, ref);
  }

  /// FAB subview when selection mode is active (cancel / delete).
  /// Subvista FAB cuando el modo selección está activo (cancelar / eliminar).
  Column _deleteAndRestoreTaskFloatingActionButtonSubView(
    BuildContext context,
    WidgetRef ref,
  ) {
    final InternationalizationLocalizations l10n =
        InternationalizationLocalizations.of(context)!;
    return Column(
      //mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton.small(
          heroTag: 'fab4',
          tooltip: l10n.cancelSelection,
          onPressed: () {
            ref
                .read(deleteAndRestoreTaskLogicBinProvider.notifier)
                .disableSelectionMode();
            ref
                .read(deleteAndRestoreTaskLogicBinProvider.notifier)
                .clearSelectedTasks();
          },
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: Icon(Icons.remove_done_sharp),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: 'fab3',
          tooltip: l10n.delete,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          onPressed: () async {
            final result = await ref
                .read(deleteAndRestoreTaskLogicBinProvider.notifier)
                .executeRestore();
            if (result > 0) {
              ref.read(listLogicBinProvider.notifier).refresh();
            }
          },
          child: Icon(
            Icons.restore_from_trash_rounded,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 12),
        FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          heroTag: 'fab2',
          tooltip: l10n.delete,
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          onPressed: () async {
            final result = await ref
                .read(deleteAndRestoreTaskLogicBinProvider.notifier)
                .executeDeletion();
            ref
                .read(deleteAndRestoreTaskLogicBinProvider.notifier)
                .disableSelectionMode();
            ref
                .read(deleteAndRestoreTaskLogicBinProvider.notifier)
                .clearSelectedTasks();
            if (result > 0) {
              ref.read(listLogicBinProvider.notifier).refresh();
            }
          },
          label: Text(l10n.deleteTasksFromBin),
          icon: Icon(
            ref.watch(deleteAndRestoreTaskLogicBinProvider).isSelectionMode
                ? Icons.clear_all_outlined
                : Icons.done_all_rounded,
          ),
        ),
      ],
    );
  }

  /// FAB subview: clear filters, select all, add task.
  /// Subvista FAB: limpiar filtros, seleccionar todo, añadir tarea.
  Builder _selectionTaskFloatingActionButtonSubView(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Builder(
      builder: (builderContext) {
        final InternationalizationLocalizations l10n =
            InternationalizationLocalizations.of(builderContext)!;

        return FloatingActionButton(
          heroTag: 'fab1',
          tooltip: l10n.selectAllTasks,
          onPressed: () {
            if (ref
                .read(deleteAndRestoreTaskLogicBinProvider)
                .isSelectionMode) {
              ref
                  .read(deleteAndRestoreTaskLogicBinProvider.notifier)
                  .disableSelectionMode();
            } else {
              ref
                  .read(deleteAndRestoreTaskLogicBinProvider.notifier)
                  .enableSelectionMode();
            }
          },
          backgroundColor: Theme.of(
            builderContext,
          ).colorScheme.secondaryContainer,
          child: Icon(
            ref.watch(deleteAndRestoreTaskLogicBinProvider).isSelectionMode
                ? Icons.clear_all_outlined
                : Icons.done_all_rounded,
          ),
        );
      },
    );
  }
}

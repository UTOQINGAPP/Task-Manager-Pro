import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_pro/configs/configs.dart';
import 'package:task_manager_pro/core/core.dart'
    show TaskDataRule, TaskCategoryDataRule, TaskPriorityDataRule;
import 'package:task_manager_pro/interface/app/router/pages/pages_router.dart';
import 'package:task_manager_pro/interface/pages/tasks/dialogs/dialogs_tasks.dart';
import 'package:task_manager_pro/interface/pages/tasks/logic/logic_tasks.dart';
import 'package:task_manager_pro/interface/pages/tasks/views/views_tasks.dart';
import 'package:task_manager_pro/interface/shared/shared.dart';

class TasksPage extends ConsumerStatefulWidget {
  static const String name = 'tasks';
  static const String path = '/tasks';

  /// Creates a TasksPage widget.
  /// Crea un widget TasksPage.
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

/// Tasks page widget.
/// Widget de página de tareas.
class _TasksPageState extends ConsumerState<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        ref.read(binTaskLogicTasksProvider.notifier).disableSelectionMode();
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: _appBarView(context, ref),
        body: _bodyView(context, ref: ref),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: _floatingActionButtonView(context, ref),
      ),
    );
  }

  /// Builds the app bar with theme toggle and about action.
  /// Construye la barra de aplicación con cambio de tema y acción acerca de.
  AppBar _appBarView(BuildContext context, WidgetRef ref) {
    final ThemeState themeState = ref.watch(themeLogicSharedProvider);
    final InternationalizationLocalizations l10n =
        InternationalizationLocalizations.of(context)!;
    return AppBar(
      title: GestureDetector(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                AboutAppConstants.applicationIcon,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Text(l10n.appTitle),
            const SizedBox(width: 10),
          ],
        ),
        onTap: () {
          showAboutDialog(
            context: context,
            applicationName: AboutAppConstants.applicationName,
            applicationVersion: AboutAppConstants.applicationVersion,
            applicationIcon: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                AboutAppConstants.applicationIcon,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            applicationLegalese: AboutAppConstants.applicationLegales,
          );
        },
      ),
      centerTitle: false,

      shadowColor: themeState.themeMode == ThemeMode.light
          ? Colors.grey.withValues(alpha: 0.5)
          : Colors.black.withValues(alpha: 0.5),
      actions: [
        IconButton(
          onPressed: () async {
            final result = await BinRoute().push(context);
            if (result == true) {
              ref.read(listLogicTasksProvider.notifier).refresh();
              ref.read(statusLogicTasksProvider.notifier).refresh();
            }
          },
          icon: Icon(Icons.delete_sweep_rounded),
        ),
        IconButton(
          onPressed: () {
            ref.read(themeLogicSharedProvider.notifier).toggleBrightness();
          },
          icon: Icon(
            themeState.themeMode == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode,
          ),
        ),
      ],
    );
  }

  /// Builds the main body: summary, controls and task list.
  /// Construye el cuerpo principal: resumen, controles y lista de tareas.
  SizedBox _bodyView(BuildContext context, {required WidgetRef ref}) {
    final InternationalizationLocalizations l10n =
        InternationalizationLocalizations.of(context)!;
    final List<TaskCategoryDataRule> taskCategories =
        ref.watch(categoryLogicSharedProvider).value ?? [];
    final List<TaskPriorityDataRule> taskPriorities =
        ref.watch(priorityLogicSharedProvider).value ?? [];
    final List<TaskDataRule> visibleTasks =
        ref.watch(listLogicTasksProvider).value?.visibleTasks ??
        <TaskDataRule>[];
    final List<ItemTaskListView> items = _mapTasksToSharedItems(
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
          TaskSummaryViewTasks(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: TaskListControlsViewTasks(),
          ),
          Expanded(
            child: TaskListViewComponentShared(
              items: items,
              isLoading: ref.watch(listLogicTasksProvider).isLoading,
              error: ref.watch(listLogicTasksProvider).error?.toString(),
              onRefresh: () =>
                  ref.read(listLogicTasksProvider.notifier).refresh(),
              onRetry: () =>
                  ref.read(listLogicTasksProvider.notifier).refresh(),
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

  /// Maps [TaskDataRule] list to [ItemTaskListView] for the shared list component.
  /// Mapea lista de [TaskDataRule] a [ItemTaskListView] para el componente compartido.
  List<ItemTaskListView> _mapTasksToSharedItems({
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
          .watch(binTaskLogicTasksProvider)
          .isSelectionMode;
      final bool isSelected = ref
          .watch(binTaskLogicTasksProvider)
          .taskIdsToDelete
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
                        .read(binTaskLogicTasksProvider.notifier)
                        .addTaskToDelete(task.id);
                  } else {
                    ref
                        .read(binTaskLogicTasksProvider.notifier)
                        .removeTaskFromDelete(task.id);
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
            label: PriorityLabelLogicShared.getDisplayName(
              l10n,
              priority.name,
            ),
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
            shadowColor: tertiaryColor,
          ),
        ],
        onTap: () {
          final platform = Theme.of(context).platform;
          if (platform == TargetPlatform.iOS) {
            Navigator.of(context).push(
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (BuildContext ctx) => CreateAndEditTaskDialogTasks(
                  task: task,
                ),
              ),
            );
          } else {
            showDialog<void>(
              context: context,
              builder: (BuildContext ctx) => CreateAndEditTaskDialogTasks(
                task: task,
              ),
            );
          }
        },
        semanticsLabel: '${l10n.openTask}: ${task.title}',
      );
    }).toList();
  }

  /// Builds FAB: either delete-selection actions or create/select-all/create.
  /// Construye el FAB: acciones de borrado en selección o crear/seleccionar todo/crear.
  Widget _floatingActionButtonView(BuildContext context, WidgetRef ref) {
    final int totalTasksToDelete = ref
        .watch(binTaskLogicTasksProvider)
        .totalTasksToDelete;
    if (totalTasksToDelete >= 1) {
      return _deleteFloatingActionButtonSubView(context, ref);
    }
    return _createFloatingActionButtonSubView(context, ref);
  }

  /// FAB subview when selection mode is active (cancel / delete).
  /// Subvista FAB cuando el modo selección está activo (cancelar / eliminar).
  Column _deleteFloatingActionButtonSubView(
    BuildContext context,
    WidgetRef ref,
  ) {
    final InternationalizationLocalizations l10n =
        InternationalizationLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton.small(
          heroTag: 'fab1',
          tooltip: l10n.cancelSelection,
          onPressed: () {
            ref.read(binTaskLogicTasksProvider.notifier).disableSelectionMode();
            ref.read(binTaskLogicTasksProvider.notifier).clearTasksToDelete();
          },
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: Icon(Icons.remove_done_sharp),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: 'fab2',
          tooltip: l10n.delete,
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          onPressed: () async {
            final result = await ref
                .read(binTaskLogicTasksProvider.notifier)
                .executeDeletion();
            ref.read(binTaskLogicTasksProvider.notifier).disableSelectionMode();
            ref.read(binTaskLogicTasksProvider.notifier).clearTasksToDelete();
            if (result > 0) {
              ref.read(listLogicTasksProvider.notifier).refresh();
              ref.read(statusLogicTasksProvider.notifier).refresh();
            }
          },
          child: const Icon(Icons.delete_forever),
        ),
      ],
    );
  }

  /// FAB subview: clear filters, select all, add task.
  /// Subvista FAB: limpiar filtros, seleccionar todo, añadir tarea.
  Builder _createFloatingActionButtonSubView(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Builder(
      builder: (builderContext) {
        final InternationalizationLocalizations l10n =
            InternationalizationLocalizations.of(builderContext)!;
        final List<TaskDataRule> tasks =
            ref.watch(listLogicTasksProvider).value?.visibleTasks ??
            <TaskDataRule>[];

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (ref.watch(listLogicTasksProvider).value?.isFilterActive ??
                false)
              ref
                  .watch(listLogicTasksProvider)
                  .when(
                    data: (taskListState) => taskListState.isFilterActive
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FloatingActionButton.small(
                                heroTag: 'fab3',
                                tooltip: l10n.clearFilters,
                                onPressed: () {
                                  ref
                                      .read(listLogicTasksProvider.notifier)
                                      .clearFilters();
                                },
                                backgroundColor: Theme.of(
                                  builderContext,
                                ).colorScheme.secondaryContainer,
                                child: Icon(Icons.filter_list_off_rounded),
                              ),
                              SizedBox(height: 12),
                            ],
                          )
                        : const SizedBox.shrink(),
                    loading: () => const SizedBox.shrink(),
                    error: (_, _) => const SizedBox.shrink(),
                  ),
            if (tasks.isNotEmpty)
              FloatingActionButton.small(
                heroTag: 'fab4',
                tooltip: l10n.selectAllTasks,
                onPressed: () {
                  if (ref.read(binTaskLogicTasksProvider).isSelectionMode) {
                    ref
                        .read(binTaskLogicTasksProvider.notifier)
                        .disableSelectionMode();
                  } else {
                    ref
                        .read(binTaskLogicTasksProvider.notifier)
                        .enableSelectionMode();
                    /*    final List<String> taskIds = tasks
                        .map((task) => task.id)
                        .toList();
                    ref
                        .read(binTaskLogicTasksProvider.notifier)
                        .addTasksToDelete(taskIds); */
                  }
                },
                backgroundColor: Theme.of(
                  builderContext,
                ).colorScheme.secondaryContainer,
                child: Icon(
                  ref.watch(binTaskLogicTasksProvider).isSelectionMode
                      ? Icons.clear_all_outlined
                      : Icons.done_all_rounded,
                ),
              ),
            if (tasks.isNotEmpty) const SizedBox(height: 12),
            FloatingActionButton(
              heroTag: 'fab5',
              tooltip: l10n.addTask,
              onPressed: () {
                final platform = Theme.of(builderContext).platform;
                if (platform == TargetPlatform.iOS) {
                  Navigator.of(builderContext).push(
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (_) => const CreateAndEditTaskDialogTasks(
                        task: null,
                      ),
                    ),
                  );
                } else {
                  showDialog(
                    context: builderContext,
                    builder: (ctx) => const CreateAndEditTaskDialogTasks(
                      task: null,
                    ),
                  );
                }
              },
              child: const Icon(Icons.add),
            ),
          ],
        );
      },
    );
  }
}

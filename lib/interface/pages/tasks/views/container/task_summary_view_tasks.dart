import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:task_manager_pro/configs/configs.dart';
import 'package:task_manager_pro/interface/pages/tasks/components/components_tasks.dart';
import 'package:task_manager_pro/interface/pages/tasks/logic/logic_tasks.dart';

/// Horizontal summary of task counts (total, pending, completed, archived).
/// Cards are tappable to refresh or apply quick filters; shows loading/error states.
///
/// Resumen horizontal de conteos de tareas (total, pendientes, completadas,
/// archivadas). Las tarjetas son pulsables para refrescar o aplicar filtros
/// rápidos; muestra estados de carga y error.
class TaskSummaryViewTasks extends ConsumerWidget {
  const TaskSummaryViewTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final InternationalizationLocalizations l10n =
        InternationalizationLocalizations.of(context)!;
    final AsyncValue<TaskStatusState> statusAsync = ref.watch(
      statusLogicTasksProvider,
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0.0, 0.1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),
            child: child,
          ),
        );
      },
      child: statusAsync.when(
        data: (tasksStatus) => SingleChildScrollView(
          key: const ValueKey('data'),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              CustomStatusCardComponentTasks(
                title: l10n.total,
                value: tasksStatus.totalTasks.toString(),
                icon: Icons.list,
                onTap: () {
                  ref.read(listLogicTasksProvider.notifier).refresh();
                  ref.read(statusLogicTasksProvider.notifier).refresh();
                },
              ),
              CustomStatusCardComponentTasks(
                title: l10n.pending,
                value: tasksStatus.pendingTasks.toString(),
                icon: Icons.pending_actions,
                onTap: () {
                  ref.read(listLogicTasksProvider.notifier).clearFilters();
                  ref
                      .read(listLogicTasksProvider.notifier)
                      .filter(
                        category: null,
                        priority: null,
                        isCompleted: false,
                        isArchived: false,
                      );
                },
              ),
              CustomStatusCardComponentTasks(
                title: l10n.completed.toUpperCase(),
                value: tasksStatus.completedTasks.toString(),
                icon: Icons.task_alt_sharp,
                onTap: () {
                  ref.read(listLogicTasksProvider.notifier).clearFilters();
                  ref
                      .read(listLogicTasksProvider.notifier)
                      .filter(
                        category: null,
                        priority: null,
                        isCompleted: true,
                        isArchived: false,
                      );
                },
              ),
              CustomStatusCardComponentTasks(
                title: l10n.archived,
                value: tasksStatus.archivedTasks.toString(),
                icon: Icons.archive,
                onTap: () {
                  ref.read(listLogicTasksProvider.notifier).clearFilters();
                  ref
                      .read(listLogicTasksProvider.notifier)
                      .filter(isArchived: true);
                },
              ),
            ],
          ),
        ),
        error: (error, stackTrace) => SingleChildScrollView(
          key: const ValueKey('error'),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              CustomErrorStatusCardComponentTasks(
                errorLoadingText: l10n.errorLoading,
                retryText: l10n.tapToRetry,
                onRetry: () {
                  ref.read(statusLogicTasksProvider.notifier).refresh();
                },
              ),
            ],
          ),
        ),
        loading: () => SingleChildScrollView(
          key: const ValueKey('loading'),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Skeletonizer(
            enabled: true,
            child: Row(
              children: [
                CustomStatusCardComponentTasks(
                  title: l10n.total,
                  value: '0',
                  icon: Icons.list,
                  onTap: () {},
                ),
                CustomStatusCardComponentTasks(
                  title: l10n.pending,
                  value: '0',
                  icon: Icons.pending_actions,
                  onTap: () {},
                ),
                CustomStatusCardComponentTasks(
                  title: l10n.completed.toUpperCase(),
                  value: '0',
                  icon: Icons.task_alt_sharp,
                  onTap: () {},
                ),
                CustomStatusCardComponentTasks(
                  title: l10n.archived,
                  value: '0',
                  icon: Icons.archive,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

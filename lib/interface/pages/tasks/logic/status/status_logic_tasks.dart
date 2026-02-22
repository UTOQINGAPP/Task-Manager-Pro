import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager_pro/core/core.dart' show TaskDataRule;
import 'package:task_manager_pro/interface/shared/shared.dart'
    show tasksLogicSharedProvider;

part 'status_logic_tasks.g.dart';

// ═══════════════════════════════════════════════════════════════════════════
// TASK STATUS LOGIC (AsyncNotifier)
// ═══════════════════════════════════════════════════════════════════════════

/// State containing task statistics.
/// Estado que contiene las estadísticas de tareas.
class TaskStatusState {
  /// Total number of tasks.
  /// Número total de tareas.
  final int totalTasks;

  /// Number of completed tasks (isCompleted = true).
  /// Número de tareas completadas (isCompleted = true).
  final int completedTasks;

  /// Number of pending tasks (isCompleted = false).
  /// Número de tareas pendientes (isCompleted = false).
  final int pendingTasks;

  /// Number of archived tasks (isArchived = true).
  /// Número de tareas archivadas (isArchived = true).
  final int archivedTasks;

  const TaskStatusState({
    required this.totalTasks,
    required this.completedTasks,
    required this.pendingTasks,
    required this.archivedTasks,
  });

  /// Creates a [TaskStatusState] from a list of tasks.
  ///
  /// Crea un [TaskStatusState] desde una lista de tareas.
  factory TaskStatusState.fromTasks(List<TaskDataRule> tasks) {
    final int completed = tasks
        .where((task) => task.isCompleted && !task.isArchived)
        .length;

    final int archived = tasks.where((task) => task.isArchived).length;

    final int bin = tasks.where((task) => task.isBin).length;

    final int total = tasks.length - archived - bin;

    final int pending = total - completed;

    return TaskStatusState(
      totalTasks: total,
      completedTasks: completed,
      pendingTasks: pending,
      archivedTasks: archived,
    );
  }

  /// Returns true if there are no tasks.
  /// Retorna true si no hay tareas.
  bool get isEmpty => totalTasks == 0;

  /// Returns the completion percentage (0.0 to 1.0).
  /// Retorna el porcentaje de completado (0.0 a 1.0).
  double get completionPercentage {
    if (totalTasks == 0) return 0.0;
    return completedTasks / totalTasks;
  }

  TaskStatusState copyWith({
    int? totalTasks,
    int? completedTasks,
    int? pendingTasks,
    int? archivedTasks,
  }) {
    return TaskStatusState(
      totalTasks: totalTasks ?? this.totalTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      pendingTasks: pendingTasks ?? this.pendingTasks,
      archivedTasks: archivedTasks ?? this.archivedTasks,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TaskStatusState &&
            other.totalTasks == totalTasks &&
            other.completedTasks == completedTasks &&
            other.pendingTasks == pendingTasks &&
            other.archivedTasks == archivedTasks;
  }

  @override
  int get hashCode =>
      Object.hash(totalTasks, completedTasks, pendingTasks, archivedTasks);

  @override
  String toString() =>
      'TaskStatusState(total: $totalTasks, completed: $completedTasks, pending: $pendingTasks, archived: $archivedTasks)';
}

/// Notifier that loads tasks and calculates statistics (total, completed, pending).
///
/// Notifier que carga tareas y calcula estadísticas (total, completadas, pendientes).
@riverpod
class StatusLogicTasks extends _$StatusLogicTasks {
  @override
  Future<TaskStatusState> build() async {
    final List<TaskDataRule> tasks = await ref.read(
      tasksLogicSharedProvider.future,
    );
    return TaskStatusState.fromTasks(tasks);
  }

  /// Reloads tasks from [TasksLogicShared] and recalculates statistics.
  ///
  /// Recarga las tareas desde [TasksLogicShared] y recalcula las estadísticas.
  Future<void> refresh() async {
    state = const AsyncLoading<TaskStatusState>();
    await ref.read(tasksLogicSharedProvider.notifier).refresh();
    state = await AsyncValue.guard(() => build());
  }

  /// Updates statistics from a provided list of tasks.
  ///
  /// Actualiza las estadísticas desde una lista de tareas proporcionada.
  ///
  /// [tasks] List of tasks to calculate statistics from.
  /// Lista de tareas para calcular las estadísticas.
  void updateFromTasks(List<TaskDataRule> tasks) {
    if (!ref.mounted) return;
    final List<TaskDataRule> activeTasks = tasks
        .where((TaskDataRule task) => !task.isArchived)
        .toList();
    state = AsyncData<TaskStatusState>(TaskStatusState.fromTasks(activeTasks));
  }
}

/// Exception thrown when loading task status fails.
/// Excepción lanzada cuando falla la carga del estado de tareas.
class TaskStatusException implements Exception {
  const TaskStatusException({required this.message, this.errorCode});

  final String message;
  final String? errorCode;

  @override
  String toString() => 'TaskStatusException($message, $errorCode)';
}

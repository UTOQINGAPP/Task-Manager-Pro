import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager_pro/core/core.dart'
    show TaskDataRule, NotificationDataRule;
import 'package:task_manager_pro/interface/shared/shared.dart'
    show
        tasksLogicSharedProvider,
        notificationLogicSharedProvider,
        ListTasksLogicException;

part 'edit_task_logic_tasks.g.dart';

/// Handles task updates and reschedules related notifications.
/// Gestiona la actualización de tareas y reprograma notificaciones relacionadas.
@Riverpod(keepAlive: true)
class EditTaskLogicTasks extends _$EditTaskLogicTasks {
  @override
  void build() {}

  /// Updates an existing task after loading it and validating required fields.
  /// Actualiza una tarea existente tras cargarla y validar campos requeridos.
  Future<TaskDataRule> submit({
    required String taskId,
    required String title,
    String? description,
    required String taskCategoryId,
    required String taskPriorityId,
    int? dueDate,
    bool? isCompleted,
    bool? isArchived,
  }) async {
    final TaskDataRule? existingTask;
    try {
      existingTask = await ref
          .read(tasksLogicSharedProvider.notifier)
          .getTaskById(id: taskId);
    } on ListTasksLogicException catch (e) {
      throw EditTaskException(message: e.message, errorCode: e.errorCode);
    }

    if (existingTask == null) {
      throw const EditTaskException(
        message: 'Task not found',
        errorCode: 'NOT_FOUND',
      );
    }

    final TaskDataRule updatedTask = existingTask.copyWith(
      title: title,
      description: description,
      taskCategoryId: taskCategoryId,
      taskPriorityId: taskPriorityId,
      dueDate: dueDate,
      isCompleted: isCompleted,
      isArchived: isArchived,
    );

    if (!updatedTask.isValid) {
      throw const EditTaskException(
        message: 'Title, category and priority are required',
        errorCode: 'VALIDATION',
      );
    }

    final TaskDataRule editedTask;
    try {
      editedTask = await ref
          .read(tasksLogicSharedProvider.notifier)
          .updateTask(task: updatedTask);
    } on ListTasksLogicException catch (e) {
      throw EditTaskException(message: e.message, errorCode: e.errorCode);
    }

    await _rescheduleNotifications(editedTask);

    return editedTask;
  }

  /// Cancels previous notifications and schedules new ones for the updated task.
  /// Cancela notificaciones previas y programa nuevas para la tarea actualizada.
  Future<void> _rescheduleNotifications(TaskDataRule task) async {
    final notificationLogic = ref.read(
      notificationLogicSharedProvider.notifier,
    );

    await notificationLogic.cancel('${task.id}_due'.hashCode);
    await notificationLogic.cancel('${task.id}_reminder'.hashCode);

    final now = DateTime.now().millisecondsSinceEpoch;

    if (task.dueDate <= now) return;

    await notificationLogic.send(
      NotificationDataRule(
        id: '${task.id}_due'.hashCode,
        title: 'Tarea vencida',
        body: task.title,
        scheduledAt: task.dueDate,
      ),
    );

    const twentyFourHours = 24 * 60 * 60 * 1000;
    final reminderTime = task.dueDate - twentyFourHours;

    if (reminderTime > now) {
      await notificationLogic.send(
        NotificationDataRule(
          id: '${task.id}_reminder'.hashCode,
          title: 'Recordatorio de tarea',
          body: task.title,
          scheduledAt: reminderTime,
        ),
      );
    }
  }
}

class EditTaskException implements Exception {
  /// Exception thrown when task update fails.
  /// Excepción lanzada cuando falla la actualización de una tarea.
  const EditTaskException({required this.message, this.errorCode});

  final String message;
  final String? errorCode;

  @override
  String toString() => 'EditTaskException($message, $errorCode)';
}

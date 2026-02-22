import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager_pro/core/core.dart'
    show TaskDataRule, NotificationDataRule;
import 'package:task_manager_pro/interface/shared/shared.dart'
    show
        tasksLogicSharedProvider,
        notificationLogicSharedProvider,
        ListTasksLogicException;

part 'create_task_logic_tasks.g.dart';

/// Handles task creation and schedules related notifications.
/// Gestiona la creación de tareas y programa notificaciones relacionadas.
@Riverpod(keepAlive: true)
class CreateTaskLogicTasks extends _$CreateTaskLogicTasks {
  @override
  void build() {}

  /// Creates a new task after validating required business fields.
  /// Crea una nueva tarea tras validar los campos de negocio requeridos.
  Future<TaskDataRule> submit({
    required String title,
    String? description,
    required String taskCategoryId,
    required String taskPriorityId,
    required int dueDate,
  }) async {
    final TaskDataRule task = TaskDataRule.create(
      title: title,
      description: description,
      taskCategoryId: taskCategoryId,
      taskPriorityId: taskPriorityId,
      dueDate: dueDate,
    );

    if (!task.isValid) {
      throw const CreateTaskException(
        message: 'Title, category and priority are required',
        errorCode: 'VALIDATION',
      );
    }

    final TaskDataRule createdTask;
    try {
      createdTask = await ref
          .read(tasksLogicSharedProvider.notifier)
          .addTask(task: task);
    } on ListTasksLogicException catch (e) {
      throw CreateTaskException(message: e.message, errorCode: e.errorCode);
    }

    await _scheduleNotifications(createdTask);

    return createdTask;
  }

  /// Schedules due/reminder notifications when due date is in the future.
  /// Programa notificaciones de vencimiento/recordatorio cuando la fecha es futura.
  Future<void> _scheduleNotifications(TaskDataRule task) async {
    final int now = DateTime.now().millisecondsSinceEpoch;

    if (task.dueDate <= now) return;

    final notificationLogic = ref.read(
      notificationLogicSharedProvider.notifier,
    );

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

class CreateTaskException implements Exception {
  /// Exception thrown when task creation fails.
  /// Excepción lanzada cuando falla la creación de una tarea.
  const CreateTaskException({required this.message, this.errorCode});

  final String message;
  final String? errorCode;

  @override
  String toString() => 'CreateTaskException($message, $errorCode)';
}

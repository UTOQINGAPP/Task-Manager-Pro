import 'package:task_manager_pro/core/rules/rules_core.dart';

/// Task consumer implementation. Use cases for tasks (e.g. from UI).
/// Implementación del consumer de tareas. Casos de uso para tareas (ej. desde la UI).
class TaskConsumerUse implements TaskConsumerRule {
  final TaskServiceRule _taskService;

  TaskConsumerUse({required TaskServiceRule taskService})
    : _taskService = taskService;

  @override
  Future<ApiResponseRule<List<TaskDataRule>>> loadTasks() =>
      _taskService.getTasks();

  @override
  Future<ApiResponseRule<TaskDataRule?>> loadTaskById({required String id}) =>
      _taskService.getTaskById(id: id);

  @override
  Future<ApiResponseRule<TaskDataRule>> addTask({required TaskDataRule task}) =>
      _taskService.createTask(task: task);

  @override
  Future<ApiResponseRule<TaskDataRule>> updateTask({
    required TaskDataRule task,
  }) => _taskService.updateTask(task: task);

  @override
  Future<ApiResponseRule<Unit>> deleteTask({required String id}) =>
      _taskService.deleteTask(id: id);

  @override
  Future<ApiResponseRule<TaskDataRule>> setTaskCompleted({
    required String id,
    required bool isCompleted,
  }) async {
    final response = await _taskService.getTaskById(id: id);
    return await response.resolve(
      onSuccess: (data, _) async {
        if (data == null) {
          return FailureResponseRule<TaskDataRule>(
            message: 'Task not found',
            errorCode: 'NOT_FOUND',
          );
        }
        final updated = data.copyWith(isCompleted: isCompleted);
        return _taskService.updateTask(task: updated);
      },
      onFailure: (message, errorCode) => Future.value(
        FailureResponseRule<TaskDataRule>(
          message: message,
          errorCode: errorCode,
        ),
      ),
    );
  }
}

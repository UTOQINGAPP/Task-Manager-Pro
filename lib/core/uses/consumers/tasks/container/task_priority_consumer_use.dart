import 'package:task_manager_pro/core/rules/rules_core.dart';

/// Task priority consumer implementation. Use cases for task priorities (e.g. from UI).
/// Implementación del consumer de prioridades de tarea. Casos de uso (ej. desde la UI).
class TaskPriorityConsumerUse implements TaskPriorityConsumerRule {
  final TaskPriorityServiceRule _taskPriorityService;

  TaskPriorityConsumerUse({
    required TaskPriorityServiceRule taskPriorityService,
  }) : _taskPriorityService = taskPriorityService;

  @override
  Future<ApiResponseRule<List<TaskPriorityDataRule>>> loadTaskPriorities() =>
      _taskPriorityService.getTaskPriorities();

  @override
  Future<ApiResponseRule<TaskPriorityDataRule?>> loadTaskPriorityById({
    required String id,
  }) => _taskPriorityService.getTaskPriorityById(id: id);

  @override
  Future<ApiResponseRule<TaskPriorityDataRule>> addTaskPriority({
    required TaskPriorityDataRule taskPriority,
  }) => _taskPriorityService.createTaskPriority(taskPriority: taskPriority);

  @override
  Future<ApiResponseRule<TaskPriorityDataRule>> updateTaskPriority({
    required TaskPriorityDataRule taskPriority,
  }) => _taskPriorityService.updateTaskPriority(taskPriority: taskPriority);

  @override
  Future<ApiResponseRule<Unit>> deleteTaskPriority({required String id}) =>
      _taskPriorityService.deleteTaskPriority(id: id);
}

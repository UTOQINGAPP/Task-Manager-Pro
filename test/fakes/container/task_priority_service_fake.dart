import 'package:task_manager_pro/core/core.dart'
    show
        ApiResponseRule,
        SuccessResponseRule,
        unit,
        Unit,
        TaskPriorityDataRule,
        TaskPriorityServiceRule;

/// Fake implementation of [TaskPriorityServiceRule] for tests.
/// Implementación falsa de [TaskPriorityServiceRule] para pruebas.
class TaskPriorityServiceUseFakeTest implements TaskPriorityServiceRule {
  final List<TaskPriorityDataRule> taskPriorities;

  TaskPriorityServiceUseFakeTest({required this.taskPriorities});

  @override
  Future<ApiResponseRule<List<TaskPriorityDataRule>>>
  getTaskPriorities() async {
    return SuccessResponseRule(data: taskPriorities);
  }

  @override
  Future<ApiResponseRule<TaskPriorityDataRule?>> getTaskPriorityById({
    required String id,
  }) async {
    try {
      final found = taskPriorities.firstWhere((p) => p.id == id);
      return SuccessResponseRule<TaskPriorityDataRule?>(data: found);
    } catch (_) {
      return SuccessResponseRule<TaskPriorityDataRule?>(data: null);
    }
  }

  @override
  Future<ApiResponseRule<TaskPriorityDataRule>> createTaskPriority({
    required TaskPriorityDataRule taskPriority,
  }) async {
    return SuccessResponseRule(data: taskPriority);
  }

  @override
  Future<ApiResponseRule<TaskPriorityDataRule>> updateTaskPriority({
    required TaskPriorityDataRule taskPriority,
  }) async {
    return SuccessResponseRule(data: taskPriority);
  }

  @override
  Future<ApiResponseRule<Unit>> deleteTaskPriority({required String id}) async {
    return SuccessResponseRule<Unit>(data: unit);
  }
}

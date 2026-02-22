import 'package:task_manager_pro/core/core.dart'
    show
        ApiResponseRule,
        SuccessResponseRule,
        unit,
        Unit,
        TaskDataRule,
        TaskServiceRule;

class TaskServiceUseFakeTest implements TaskServiceRule {
  final List<TaskDataRule> tasks;

  TaskServiceUseFakeTest({required this.tasks});

  @override
  Future<ApiResponseRule<List<TaskDataRule>>> getTasks() async {
    return SuccessResponseRule(data: tasks);
  }

  @override
  Future<ApiResponseRule<Unit>> deleteTask({required String id}) async {
    return SuccessResponseRule<Unit>(data: unit);
  }

  @override
  Future<ApiResponseRule<TaskDataRule>> createTask({
    required TaskDataRule task,
  }) async {
    return SuccessResponseRule(data: task);
  }

  @override
  Future<ApiResponseRule<TaskDataRule?>> getTaskById({
    required String id,
  }) async {
    TaskDataRule? found;

    for (final TaskDataRule task in tasks) {
      if (task.id == id) {
        found = task;
        break;
      }
    }

    return SuccessResponseRule<TaskDataRule?>(data: found);
  }

  @override
  Future<ApiResponseRule<TaskDataRule>> updateTask({
    required TaskDataRule task,
  }) async {
    return SuccessResponseRule(data: task);
  }
}

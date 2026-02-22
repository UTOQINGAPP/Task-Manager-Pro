import 'package:task_manager_pro/core/core.dart'
    show
        TaskCategoryDataRule,
        ApiResponseRule,
        SuccessResponseRule,
        TaskCategoryServiceRule,
        unit,
        Unit;

/// Fake implementation of [TaskCategoryServiceRule] for tests.
/// Implementación falsa de [TaskCategoryServiceRule] para pruebas.
class TaskCategoryServiceUseFakeTest implements TaskCategoryServiceRule {
  final List<TaskCategoryDataRule> taskCategories;

  TaskCategoryServiceUseFakeTest({required this.taskCategories});

  @override
  Future<ApiResponseRule<List<TaskCategoryDataRule>>>
  getTaskCategories() async {
    return SuccessResponseRule(data: taskCategories);
  }

  @override
  Future<ApiResponseRule<TaskCategoryDataRule?>> getTaskCategoryById({
    required String id,
  }) async {
    try {
      final found = taskCategories.firstWhere((c) => c.id == id);
      return SuccessResponseRule<TaskCategoryDataRule?>(data: found);
    } catch (_) {
      return SuccessResponseRule<TaskCategoryDataRule?>(data: null);
    }
  }

  @override
  Future<ApiResponseRule<TaskCategoryDataRule>> createTaskCategory({
    required TaskCategoryDataRule taskCategory,
  }) async {
    return SuccessResponseRule(data: taskCategory);
  }

  @override
  Future<ApiResponseRule<TaskCategoryDataRule>> updateTaskCategory({
    required TaskCategoryDataRule taskCategory,
  }) async {
    return SuccessResponseRule(data: taskCategory);
  }

  @override
  Future<ApiResponseRule<Unit>> deleteTaskCategory({required String id}) async {
    return SuccessResponseRule<Unit>(data: unit);
  }
}

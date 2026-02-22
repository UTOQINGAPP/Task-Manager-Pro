import 'package:task_manager_pro/core/rules/rules_core.dart';

/// Task category consumer implementation. Use cases for task categories (e.g. from UI).
/// Implementación del consumer de categorías de tarea. Casos de uso (ej. desde la UI).
class TaskCategoryConsumerUse implements TaskCategoryConsumerRule {
  final TaskCategoryServiceRule _taskCategoryService;

  TaskCategoryConsumerUse({
    required TaskCategoryServiceRule taskCategoryService,
  }) : _taskCategoryService = taskCategoryService;

  @override
  Future<ApiResponseRule<List<TaskCategoryDataRule>>> loadTaskCategories() =>
      _taskCategoryService.getTaskCategories();

  @override
  Future<ApiResponseRule<TaskCategoryDataRule?>> loadTaskCategoryById({
    required String id,
  }) => _taskCategoryService.getTaskCategoryById(id: id);

  @override
  Future<ApiResponseRule<TaskCategoryDataRule>> addTaskCategory({
    required TaskCategoryDataRule taskCategory,
  }) => _taskCategoryService.createTaskCategory(taskCategory: taskCategory);

  @override
  Future<ApiResponseRule<TaskCategoryDataRule>> updateTaskCategory({
    required TaskCategoryDataRule taskCategory,
  }) => _taskCategoryService.updateTaskCategory(taskCategory: taskCategory);

  @override
  Future<ApiResponseRule<Unit>> deleteTaskCategory({required String id}) =>
      _taskCategoryService.deleteTaskCategory(id: id);
}

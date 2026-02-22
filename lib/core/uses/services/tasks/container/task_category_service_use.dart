import 'package:drift/drift.dart';
import 'package:task_manager_pro/core/infra/infra_core.dart';
import 'package:task_manager_pro/core/rules/rules_core.dart';
import 'package:task_manager_pro/core/uses/adapters/adapters_uses.dart';

/// Task category service implementation. Persists and retrieves task categories via Drift.
/// Implementación del servicio de categorías de tarea. Persiste y obtiene categorías vía Drift.
class TaskCategoryServiceUse implements TaskCategoryServiceRule {
  final ManagerDatabase _db;

  TaskCategoryServiceUse({required ManagerDatabase database}) : _db = database;

  @override
  Future<ApiResponseRule<List<TaskCategoryDataRule>>>
  getTaskCategories() async {
    try {
      final rows = await _db.select(_db.taskCategories).get();
      final list = rows
          .map(
            (row) => TaskCategoryAdapterUse.fromOrigin(
              TaskCategoryAdapterUse.fromDrift(row),
            ),
          )
          .toList();
      return SuccessResponseRule<List<TaskCategoryDataRule>>(data: list);
    } catch (e) {
      return FailureResponseRule<List<TaskCategoryDataRule>>(
        message: e.toString(),
        errorCode: 'GET_TASK_CATEGORIES',
      );
    }
  }

  @override
  Future<ApiResponseRule<TaskCategoryDataRule?>> getTaskCategoryById({
    required String id,
  }) async {
    try {
      final query = _db.select(_db.taskCategories)
        ..where((c) => c.id.equals(id));
      final row = await query.getSingleOrNull();
      final data = row != null
          ? TaskCategoryAdapterUse.fromOrigin(
              TaskCategoryAdapterUse.fromDrift(row),
            )
          : null;
      return SuccessResponseRule<TaskCategoryDataRule?>(data: data);
    } catch (e) {
      return FailureResponseRule<TaskCategoryDataRule?>(
        message: e.toString(),
        errorCode: 'GET_TASK_CATEGORY_BY_ID',
      );
    }
  }

  @override
  Future<ApiResponseRule<TaskCategoryDataRule>> createTaskCategory({
    required TaskCategoryDataRule taskCategory,
  }) async {
    try {
      if (!taskCategory.isValid) {
        return FailureResponseRule<TaskCategoryDataRule>(
          message: 'Invalid task category data',
          errorCode: 'VALIDATION',
        );
      }
      await _db
          .into(_db.taskCategories)
          .insert(
            TaskCategoryAdapterUse.toInsertCompanion(taskCategory),
            mode: InsertMode.insertOrReplace,
          );
      return SuccessResponseRule<TaskCategoryDataRule>(data: taskCategory);
    } catch (e) {
      return FailureResponseRule<TaskCategoryDataRule>(
        message: e.toString(),
        errorCode: 'CREATE_TASK_CATEGORY',
      );
    }
  }

  @override
  Future<ApiResponseRule<TaskCategoryDataRule>> updateTaskCategory({
    required TaskCategoryDataRule taskCategory,
  }) async {
    try {
      if (!taskCategory.isValid) {
        return FailureResponseRule<TaskCategoryDataRule>(
          message: 'Invalid task category data',
          errorCode: 'VALIDATION',
        );
      }
      await (_db.update(_db.taskCategories)
            ..where((c) => c.id.equals(taskCategory.id)))
          .write(TaskCategoryAdapterUse.toUpdateCompanion(taskCategory));
      return SuccessResponseRule<TaskCategoryDataRule>(data: taskCategory);
    } catch (e) {
      return FailureResponseRule<TaskCategoryDataRule>(
        message: e.toString(),
        errorCode: 'UPDATE_TASK_CATEGORY',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> deleteTaskCategory({required String id}) async {
    try {
      await (_db.delete(
        _db.taskCategories,
      )..where((c) => c.id.equals(id))).go();
      return SuccessResponseRule<Unit>(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'DELETE_TASK_CATEGORY',
      );
    }
  }
}

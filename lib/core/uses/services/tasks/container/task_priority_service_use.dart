import 'package:drift/drift.dart';
import 'package:task_manager_pro/core/infra/infra_core.dart';
import 'package:task_manager_pro/core/rules/rules_core.dart';
import 'package:task_manager_pro/core/uses/adapters/adapters_uses.dart';

/// Task priority service implementation. Persists and retrieves task priorities via Drift.
/// Implementación del servicio de prioridades de tarea. Persiste y obtiene prioridades vía Drift.
class TaskPriorityServiceUse implements TaskPriorityServiceRule {
  final ManagerDatabase _db;

  TaskPriorityServiceUse({required ManagerDatabase database}) : _db = database;

  @override
  Future<ApiResponseRule<List<TaskPriorityDataRule>>>
  getTaskPriorities() async {
    try {
      final rows = await _db.select(_db.taskPriorities).get();
      final list = rows
          .map(
            (row) => TaskPriorityAdapterUse.fromOrigin(
              TaskPriorityAdapterUse.fromDrift(row),
            ),
          )
          .toList();
      return SuccessResponseRule<List<TaskPriorityDataRule>>(data: list);
    } catch (e) {
      return FailureResponseRule<List<TaskPriorityDataRule>>(
        message: e.toString(),
        errorCode: 'GET_TASK_PRIORITIES',
      );
    }
  }

  @override
  Future<ApiResponseRule<TaskPriorityDataRule?>> getTaskPriorityById({
    required String id,
  }) async {
    try {
      final query = _db.select(_db.taskPriorities)
        ..where((c) => c.id.equals(id));
      final row = await query.getSingleOrNull();
      final data = row != null
          ? TaskPriorityAdapterUse.fromOrigin(
              TaskPriorityAdapterUse.fromDrift(row),
            )
          : null;
      return SuccessResponseRule<TaskPriorityDataRule?>(data: data);
    } catch (e) {
      return FailureResponseRule<TaskPriorityDataRule?>(
        message: e.toString(),
        errorCode: 'GET_TASK_PRIORITY_BY_ID',
      );
    }
  }

  @override
  Future<ApiResponseRule<TaskPriorityDataRule>> createTaskPriority({
    required TaskPriorityDataRule taskPriority,
  }) async {
    try {
      if (!taskPriority.isValid) {
        return FailureResponseRule<TaskPriorityDataRule>(
          message: 'Invalid task priority data',
          errorCode: 'VALIDATION',
        );
      }
      await _db
          .into(_db.taskPriorities)
          .insert(
            TaskPriorityAdapterUse.toInsertCompanion(taskPriority),
            mode: InsertMode.insertOrReplace,
          );
      return SuccessResponseRule<TaskPriorityDataRule>(data: taskPriority);
    } catch (e) {
      return FailureResponseRule<TaskPriorityDataRule>(
        message: e.toString(),
        errorCode: 'CREATE_TASK_PRIORITY',
      );
    }
  }

  @override
  Future<ApiResponseRule<TaskPriorityDataRule>> updateTaskPriority({
    required TaskPriorityDataRule taskPriority,
  }) async {
    try {
      if (!taskPriority.isValid) {
        return FailureResponseRule<TaskPriorityDataRule>(
          message: 'Invalid task priority data',
          errorCode: 'VALIDATION',
        );
      }
      await (_db.update(_db.taskPriorities)
            ..where((c) => c.id.equals(taskPriority.id)))
          .write(TaskPriorityAdapterUse.toUpdateCompanion(taskPriority));
      return SuccessResponseRule<TaskPriorityDataRule>(data: taskPriority);
    } catch (e) {
      return FailureResponseRule<TaskPriorityDataRule>(
        message: e.toString(),
        errorCode: 'UPDATE_TASK_PRIORITY',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> deleteTaskPriority({required String id}) async {
    try {
      await (_db.delete(
        _db.taskPriorities,
      )..where((c) => c.id.equals(id))).go();
      return SuccessResponseRule<Unit>(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'DELETE_TASK_PRIORITY',
      );
    }
  }
}

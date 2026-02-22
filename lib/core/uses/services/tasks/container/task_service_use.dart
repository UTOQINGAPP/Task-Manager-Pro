import 'package:drift/drift.dart';
import 'package:task_manager_pro/core/infra/infra_core.dart';
import 'package:task_manager_pro/core/rules/rules_core.dart';
import 'package:task_manager_pro/core/uses/adapters/adapters_uses.dart';

/// Task service implementation. Persists and retrieves tasks via Drift.
/// Expects task from [TaskDataRule.create] on create (id and timestamps already set).
/// Implementación del servicio de tareas. En create espera tarea de [TaskDataRule.create].
class TaskServiceUse implements TaskServiceRule {
  final ManagerDatabase _db;

  TaskServiceUse({required ManagerDatabase database}) : _db = database;

  @override
  Future<ApiResponseRule<List<TaskDataRule>>> getTasks() async {
    try {
      await _archiveOverdueTasks();
      final rows = await _db.select(_db.tasks).get();
      final list = rows
          .map(
            (row) => TaskAdapterUse.fromOrigin(TaskAdapterUse.fromDrift(row)),
          )
          .toList();
      return SuccessResponseRule<List<TaskDataRule>>(data: list);
    } catch (e) {
      return FailureResponseRule<List<TaskDataRule>>(
        message: e.toString(),
        errorCode: 'GET_TASKS',
      );
    }
  }

  @override
  Future<ApiResponseRule<TaskDataRule?>> getTaskById({
    required String id,
  }) async {
    try {
      await _archiveOverdueTasks();
      final query = _db.select(_db.tasks)..where((t) => t.id.equals(id));
      final row = await query.getSingleOrNull();
      final data = row != null
          ? TaskAdapterUse.fromOrigin(TaskAdapterUse.fromDrift(row))
          : null;
      return SuccessResponseRule<TaskDataRule?>(data: data);
    } catch (e) {
      return FailureResponseRule<TaskDataRule?>(
        message: e.toString(),
        errorCode: 'GET_TASK_BY_ID',
      );
    }
  }

  @override
  Future<ApiResponseRule<TaskDataRule>> createTask({
    required TaskDataRule task,
  }) async {
    try {
      await _db
          .into(_db.tasks)
          .insert(
            TaskAdapterUse.toInsertCompanion(task),
            mode: InsertMode.insert,
          );
      return SuccessResponseRule<TaskDataRule>(data: task);
    } catch (e) {
      return FailureResponseRule<TaskDataRule>(
        message: e.toString(),
        errorCode: 'CREATE_TASK',
      );
    }
  }

  @override
  Future<ApiResponseRule<TaskDataRule>> updateTask({
    required TaskDataRule task,
  }) async {
    try {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final taskToUpdate = task.copyWith(updatedAt: now);
      await (_db.update(_db.tasks)..where((t) => t.id.equals(taskToUpdate.id)))
          .write(TaskAdapterUse.toUpdateCompanion(taskToUpdate));
      return SuccessResponseRule<TaskDataRule>(data: taskToUpdate);
    } catch (e) {
      return FailureResponseRule<TaskDataRule>(
        message: e.toString(),
        errorCode: 'UPDATE_TASK',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> deleteTask({required String id}) async {
    try {
      await (_db.delete(_db.tasks)..where((t) => t.id.equals(id))).go();
      return SuccessResponseRule<Unit>(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'DELETE_TASK',
      );
    }
  }

  /// Archives all completed and overdue tasks in a single SQL statement.
  /// Archiva todas las tareas completadas y vencidas en una sola sentencia SQL.
  Future<void> _archiveOverdueTasks() async {
    final int nowSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final update = _db.update(_db.tasks)
      ..where(
        (tbl) =>
            tbl.isArchived.equals(false) &
            tbl.isCompleted.equals(true) &
            tbl.dueDate.isSmallerOrEqualValue(nowSeconds),
      );
    await update.write(
      TasksCompanion(
        isArchived: const Value(true),
        updatedAt: Value(nowSeconds),
      ),
    );
  }
}

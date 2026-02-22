import 'package:drift/drift.dart';
import 'package:task_manager_pro/core/infra/database/app_database/app_database.dart';
import 'package:task_manager_pro/core/rules/data/data_rules.dart';
import 'package:task_manager_pro/core/uses/origins/origins_uses.dart';

/// Converts between Drift row, origin (data as-is), and task data rule.
/// Convierte entre fila Drift, origen (dato tal cual) y regla de datos de tarea.
abstract final class TaskAdapterUse {
  TaskAdapterUse._();

  /// Stores Drift [Task] row into [TaskOriginUse] (single variable, as it arrives).
  /// Almacena la fila [Task] de Drift en [TaskOriginUse] (una variable, tal cual llega).
  static TaskOriginUse fromDrift(Task row) => TaskOriginUse(row);

  /// Converts [TaskOriginUse] to [TaskDataRule] (reads from origin.value).
  /// Convierte [TaskOriginUse] a [TaskDataRule] (lee desde origin.value).
  static TaskDataRule fromOrigin(TaskOriginUse origin) {
    final row = origin.value;
    return TaskDataRule.restore(
      id: row.id,
      title: row.title,
      description: row.description ?? '',
      taskCategoryId: row.taskCategoryId,
      taskPriorityId: row.taskPriorityId,
      dueDate: row.dueDate,
      isCompleted: row.isCompleted,
      isArchived: row.isArchived,
      isBin: row.isBin,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      reminderNotificationId: row.reminderNotificationId,
      dueNotificationId: row.dueNotificationId,
    );
  }

  /// Builds a [TasksCompanion] for insert from [TaskDataRule].
  /// Rule must come from [TaskDataRule.create] or [TaskDataRule.restore] (always complete).
  /// Construye un [TasksCompanion] para insertar. La regla debe venir de create o restore.
  static TasksCompanion toInsertCompanion(TaskDataRule rule) {
    return TasksCompanion.insert(
      id: rule.id,
      title: rule.title,
      description: Value(rule.description),
      taskCategoryId: rule.taskCategoryId,
      taskPriorityId: rule.taskPriorityId,
      dueDate: rule.dueDate,
      isCompleted: Value(rule.isCompleted),
      isArchived: Value(rule.isArchived),
      isBin: Value(rule.isBin),
      createdAt: rule.createdAt,
      updatedAt: rule.updatedAt,
    );
  }

  /// Builds a [TasksCompanion] for update (all values as [Value]).
  /// Construye un [TasksCompanion] para actualizar.
  static TasksCompanion toUpdateCompanion(TaskDataRule rule) {
    return TasksCompanion(
      id: Value(rule.id),
      title: Value(rule.title),
      description: Value(rule.description),
      taskCategoryId: Value(rule.taskCategoryId),
      taskPriorityId: Value(rule.taskPriorityId),
      dueDate: Value(rule.dueDate),
      isCompleted: Value(rule.isCompleted),
      isArchived: Value(rule.isArchived),
      isBin: Value(rule.isBin),
      createdAt: Value(rule.createdAt),
      updatedAt: Value(rule.updatedAt),
    );
  }
}

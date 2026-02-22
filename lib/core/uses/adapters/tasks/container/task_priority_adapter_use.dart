import 'package:drift/drift.dart';
import 'package:task_manager_pro/core/infra/database/app_database/app_database.dart';
import 'package:task_manager_pro/core/rules/data/data_rules.dart';
import 'package:task_manager_pro/core/uses/origins/origins_uses.dart';

/// Converts between Drift row, origin (data as-is), and task priority data rule.
/// Convierte entre fila Drift, origen (dato tal cual) y regla de datos.
abstract final class TaskPriorityAdapterUse {
  TaskPriorityAdapterUse._();

  /// Stores Drift [TaskPriority] row into [TaskPriorityOriginUse] (single variable, as it arrives).
  /// Almacena la fila [TaskPriority] de Drift en [TaskPriorityOriginUse] (una variable, tal cual llega).
  static TaskPriorityOriginUse fromDrift(TaskPriority row) =>
      TaskPriorityOriginUse(row);

  /// Converts [TaskPriorityOriginUse] to [TaskPriorityDataRule] (reads from origin.value).
  /// Convierte [TaskPriorityOriginUse] a [TaskPriorityDataRule] (lee desde origin.value).
  static TaskPriorityDataRule fromOrigin(TaskPriorityOriginUse origin) {
    final row = origin.value;
    return TaskPriorityDataRule(
      id: row.id,
      name: row.name,
      color: row.color,
      sortOrder: row.sortOrder,
      createdAt: row.createdAt,
    );
  }

  /// Builds a [TaskPrioritiesCompanion] for insert from [TaskPriorityDataRule].
  /// Construye un [TaskPrioritiesCompanion] para insertar desde [TaskPriorityDataRule].
  static TaskPrioritiesCompanion toInsertCompanion(TaskPriorityDataRule rule) {
    return TaskPrioritiesCompanion.insert(
      id: rule.id,
      name: rule.name,
      color: rule.color,
      sortOrder: rule.sortOrder,
      createdAt: rule.createdAt,
    );
  }

  /// Builds a [TaskPrioritiesCompanion] for update.
  /// Construye un [TaskPrioritiesCompanion] para actualizar.
  static TaskPrioritiesCompanion toUpdateCompanion(TaskPriorityDataRule rule) {
    return TaskPrioritiesCompanion(
      id: Value(rule.id),
      name: Value(rule.name),
      color: Value(rule.color),
      sortOrder: Value(rule.sortOrder),
      createdAt: Value(rule.createdAt),
    );
  }
}

import 'package:drift/drift.dart';
import 'package:task_manager_pro/core/infra/database/app_database/app_database.dart';
import 'package:task_manager_pro/core/rules/data/data_rules.dart';
import 'package:task_manager_pro/core/uses/origins/origins_uses.dart';

/// Converts between Drift row, origin (data as-is), and task category data rule.
/// Convierte entre fila Drift, origen (dato tal cual) y regla de datos.
abstract final class TaskCategoryAdapterUse {
  TaskCategoryAdapterUse._();

  /// Stores Drift [TaskCategory] row into [TaskCategoryOriginUse] (single variable, as it arrives).
  /// Almacena la fila [TaskCategory] de Drift en [TaskCategoryOriginUse] (una variable, tal cual llega).
  static TaskCategoryOriginUse fromDrift(TaskCategory row) =>
      TaskCategoryOriginUse(row);

  /// Converts [TaskCategoryOriginUse] to [TaskCategoryDataRule] (reads from origin.value).
  /// Convierte [TaskCategoryOriginUse] a [TaskCategoryDataRule] (lee desde origin.value).
  static TaskCategoryDataRule fromOrigin(TaskCategoryOriginUse origin) {
    final row = origin.value;
    return TaskCategoryDataRule(
      id: row.id,
      name: row.name,
      color: row.color,
      createdAt: row.createdAt,
    );
  }

  /// Builds a [TaskCategoriesCompanion] for insert from [TaskCategoryDataRule].
  /// Construye un [TaskCategoriesCompanion] para insertar desde [TaskCategoryDataRule].
  static TaskCategoriesCompanion toInsertCompanion(TaskCategoryDataRule rule) {
    return TaskCategoriesCompanion.insert(
      id: rule.id,
      name: rule.name,
      color: rule.color,
      createdAt: rule.createdAt,
    );
  }

  /// Builds a [TaskCategoriesCompanion] for update.
  /// Construye un [TaskCategoriesCompanion] para actualizar.
  static TaskCategoriesCompanion toUpdateCompanion(TaskCategoryDataRule rule) {
    return TaskCategoriesCompanion(
      id: Value(rule.id),
      name: Value(rule.name),
      color: Value(rule.color),
      createdAt: Value(rule.createdAt),
    );
  }
}

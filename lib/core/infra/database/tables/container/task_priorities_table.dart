import 'package:drift/drift.dart';

/// Task priorities table. Stores priority levels (keys: low, medium, high).
/// Tabla de prioridades de tarea. Almacena claves (low, medium, high).
class TaskPriorities extends Table {
  @override
  String get tableName => 'task_priorities';

  /// Unique identifier.
  TextColumn get id => text()();

  /// Localization key for display name (e.g. low, medium, high).
  TextColumn get name => text()();

  /// Color value (e.g. ARGB integer) for UI display.
  IntColumn get color => integer()();

  /// Sort order for listing (0 = lowest, higher = more urgent).
  IntColumn get sortOrder => integer().named('sort_order')();

  /// Unix timestamp (seconds) when the priority was created.
  IntColumn get createdAt => integer().named('created_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

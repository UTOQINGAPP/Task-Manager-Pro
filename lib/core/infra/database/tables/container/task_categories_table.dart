import 'package:drift/drift.dart';

/// Task categories table. Stores task categories with name and color.
/// Tabla de categorías de tarea. Almacena categorías de tareas con nombre y color.
class TaskCategories extends Table {
  @override
  String get tableName => 'task_categories';

  /// Unique identifier.
  TextColumn get id => text()();

  /// Localization key for display name (e.g. personal, work, study).
  TextColumn get name => text()();

  /// Color value (e.g. ARGB integer).
  IntColumn get color => integer()();

  /// Unix timestamp (seconds) when the task category was created.
  IntColumn get createdAt => integer().named('created_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

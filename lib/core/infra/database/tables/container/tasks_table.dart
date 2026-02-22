import 'package:drift/drift.dart';

import 'task_categories_table.dart';
import 'task_priorities_table.dart';

/// Tasks table. Priority is referenced via [TaskPriorities].
/// Tabla de tareas. La prioridad se referencia mediante [TaskPriorities].
@TableIndex(name: 'idx_tasks_completed', columns: {#isCompleted})
@TableIndex(name: 'idx_tasks_archived', columns: {#isArchived})
@TableIndex(name: 'idx_tasks_bin', columns: {#isBin})
@TableIndex(name: 'idx_tasks_task_category', columns: {#taskCategoryId})
@TableIndex(name: 'idx_tasks_task_priority', columns: {#taskPriorityId})
@TableIndex(name: 'idx_tasks_due_date', columns: {#dueDate})
class Tasks extends Table {
  @override
  String get tableName => 'tasks';

  /// Unique identifier.
  TextColumn get id => text()();

  /// Task title.
  TextColumn get title => text()();

  /// Optional description.
  TextColumn get description => text().nullable()();

  /// Reference to [TaskCategories.id]. Cascade delete when task category is removed.
  /// DB column remains 'category_id' for migration compatibility.
  TextColumn get taskCategoryId => text()
      .named('category_id')
      .references(TaskCategories, #id, onDelete: KeyAction.cascade)();

  /// Reference to [TaskPriorities.id]. Restrict delete when priority is in use.
  TextColumn get taskPriorityId => text()
      .named('task_priority_id')
      .references(TaskPriorities, #id, onDelete: KeyAction.restrict)();

  /// Required due date (Unix timestamp in seconds).
  /// Fecha de vencimiento obligatoria (timestamp Unix en segundos).
  IntColumn get dueDate => integer().named('due_date')();

  /// Whether the task is completed.
  BoolColumn get isCompleted =>
      boolean().named('is_completed').withDefault(const Constant(false))();

  /// Whether the task is archived.
  /// Indica si la tarea está archivada.
  BoolColumn get isArchived =>
      boolean().named('is_archived').withDefault(const Constant(false))();

  /// Whether the task is in the bin (recycle/paper bin).
  /// Indica si la tarea está en la papelera.
  BoolColumn get isBin =>
      boolean().named('is_bin').withDefault(const Constant(false))();

  /// Unix timestamp (seconds) when the task was created.
  IntColumn get createdAt => integer().named('created_at')();

  /// Unix timestamp (seconds) when the task was last updated.
  IntColumn get updatedAt => integer().named('updated_at')();

  /// ID de la notificación de recordatorio en el sistema operativo.
  /// No es clave foránea. Solo se usa para cancelar o reprogramar.
  ///
  /// ID of the reminder notification in the OS.
  /// Not a foreign key. Used only to cancel or reschedule.
  IntColumn get reminderNotificationId =>
      integer().named('reminder_notification_id').nullable()();

  /// ID de la notificación de vencimiento en el sistema operativo.
  /// No es clave foránea. Solo se usa para gestión técnica.
  ///
  /// ID of the due notification in the OS.
  /// Not a foreign key. Used for technical management only.
  IntColumn get dueNotificationId =>
      integer().named('due_notification_id').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

import 'package:uuid/uuid.dart';

/// Data rule for task entity.
/// Represents pure business data and domain identity.
/// Regla de datos para la entidad tarea.
/// Representa datos de negocio e identidad del dominio.
class TaskDataRule {
  final String id;
  final String title;
  final String? description;
  final String taskCategoryId;
  final String taskPriorityId;
  final int dueDate;
  final bool isCompleted;
  final bool isArchived;
  /// Whether the task is in the bin (recycle/paper bin).
  /// Indica si la tarea está en la papelera.
  final bool isBin;
  final int createdAt;
  final int updatedAt;
  final int? reminderNotificationId;
  final int? dueNotificationId;
  const TaskDataRule._({
    required this.id,
    required this.title,
    required this.description,
    required this.taskCategoryId,
    required this.taskPriorityId,
    required this.dueDate,
    required this.isCompleted,
    required this.isArchived,
    required this.isBin,
    required this.createdAt,
    required this.updatedAt,
    required this.reminderNotificationId,
    required this.dueNotificationId,
  });

  /// Factory for creating a new task.
  /// Factory para crear una nueva tarea.
  factory TaskDataRule.create({
    required String title,
    String? description,
    required String taskCategoryId,
    required String taskPriorityId,
    required int dueDate,
  }) {
    return TaskDataRule._(
      id: const Uuid().v4(),
      title: title.trim(),
      description: description?.trim(),
      taskCategoryId: taskCategoryId,
      taskPriorityId: taskPriorityId,
      dueDate: dueDate,
      isCompleted: false,
      isArchived: false,
      isBin: false,
      createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      updatedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      reminderNotificationId: null,
      dueNotificationId: null,
    );
  }

  /// Factory for restoring an existing task (from DB, API, etc.).
  /// Factory para restaurar una tarea existente (desde DB, API, etc.).
  factory TaskDataRule.restore({
    required String id,
    required String title,
    String? description,
    required String taskCategoryId,
    required String taskPriorityId,
    required int dueDate,
    required bool isCompleted,
    required bool isArchived,
    required bool isBin,
    required int createdAt,
    required int updatedAt,
    required int? reminderNotificationId,
    required int? dueNotificationId,
  }) {
    return TaskDataRule._(
      id: id,
      title: title,
      description: description,
      taskCategoryId: taskCategoryId,
      taskPriorityId: taskPriorityId,
      dueDate: dueDate,
      isCompleted: isCompleted,
      isArchived: isArchived,
      isBin: isBin,
      createdAt: createdAt,
      updatedAt: updatedAt,
      reminderNotificationId: reminderNotificationId,
      dueNotificationId: dueNotificationId,
    );
  }

  /// Basic business validation.
  /// Validación básica de negocio.
  bool get isValid =>
      title.trim().isNotEmpty &&
      taskCategoryId.isNotEmpty &&
      taskPriorityId.isNotEmpty &&
      dueDate > 0;

  /// Returns a new instance with updated fields.
  /// Devuelve una nueva instancia con campos actualizados.
  TaskDataRule copyWith({
    String? title,
    String? description,
    String? taskCategoryId,
    String? taskPriorityId,
    int? dueDate,
    bool? isCompleted,
    bool? isArchived,
    bool? isBin,
    int? updatedAt,
    Object? reminderNotificationId = _noChange,
    Object? dueNotificationId = _noChange,
  }) {
    return TaskDataRule._(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      taskCategoryId: taskCategoryId ?? this.taskCategoryId,
      taskPriorityId: taskPriorityId ?? this.taskPriorityId,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      isArchived: isArchived ?? this.isArchived,
      isBin: isBin ?? this.isBin,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reminderNotificationId: reminderNotificationId == _noChange
          ? this.reminderNotificationId
          : reminderNotificationId as int?,
      dueNotificationId: dueNotificationId == _noChange
          ? this.dueNotificationId
          : dueNotificationId as int?,
    );
  }

  static const _noChange = Object();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TaskDataRule &&
            other.id == id &&
            other.title == title &&
            other.description == description &&
            other.taskCategoryId == taskCategoryId &&
            other.taskPriorityId == taskPriorityId &&
            other.dueDate == dueDate &&
            other.isCompleted == isCompleted &&
            other.isArchived == isArchived &&
            other.isBin == isBin &&
            other.createdAt == createdAt &&
            other.updatedAt == updatedAt &&
            other.reminderNotificationId == reminderNotificationId &&
            other.dueNotificationId == dueNotificationId;
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    taskCategoryId,
    taskPriorityId,
    dueDate,
    isCompleted,
    isArchived,
    isBin,
    createdAt,
    updatedAt,
    reminderNotificationId,
    dueNotificationId,
  );

  @override
  String toString() =>
      'TaskDataRule(id: $id, title: $title, '
      'category: $taskCategoryId, priority: $taskPriorityId, isArchived: $isArchived, isBin: $isBin, '
      'reminderNotificationId: $reminderNotificationId, dueNotificationId: $dueNotificationId)';
}

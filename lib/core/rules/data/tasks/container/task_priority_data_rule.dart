/// Data rule for task priority entity. Aligns with the task_priorities table.
/// Regla de datos para la entidad prioridad de tarea. Alineada con la tabla task_priorities.
class TaskPriorityDataRule {
  /// Unique identifier.
  /// Identificador único.
  final String id;

  /// Localization key for display name (e.g. low, medium, high). Translation is done in interface.
  /// Clave de localización para el nombre (ej. low, medium, high). La traducción se hace en interface.
  final String name;

  /// Color value (e.g. ARGB integer) for UI display.
  /// Valor de color (ej. entero ARGB) para mostrar en la UI.
  final int color;

  /// Sort order for listing (0 = lowest, higher = more urgent).
  /// Orden para listar (0 = más baja, mayor = más urgente).
  final int sortOrder;

  /// Unix timestamp (seconds) when the task priority was created.
  /// Timestamp Unix (segundos) de creación.
  final int createdAt;

  const TaskPriorityDataRule({
    required this.id,
    required this.name,
    required this.color,
    required this.sortOrder,
    required this.createdAt,
  });

  /// Checks if the task priority has valid required fields.
  /// Verifica si la prioridad de tarea tiene los campos requeridos válidos.
  bool get isValid => id.isNotEmpty && name.isNotEmpty;

  /// Creates a copy with updated values.
  /// Crea una copia con valores actualizados.
  TaskPriorityDataRule copyWith({
    String? id,
    String? name,
    int? color,
    int? sortOrder,
    int? createdAt,
  }) {
    return TaskPriorityDataRule(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TaskPriorityDataRule &&
        other.id == id &&
        other.name == name &&
        other.color == color &&
        other.sortOrder == sortOrder &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hash(id, name, color, sortOrder, createdAt);

  @override
  String toString() =>
      'TaskPriorityDataRule(id: $id, name: $name, color: $color, sortOrder: $sortOrder)';
}

/// Data rule for task category entity. Aligns with the task_categories table.
/// Regla de datos para la entidad categoría de tarea. Alineada con la tabla task_categories.
class TaskCategoryDataRule {
  /// Unique identifier.
  /// Identificador único.
  final String id;

  /// Localization key for display name (e.g. personal, work, study). Translation is done in interface.
  /// Clave de localización para el nombre (ej. personal, work, study). La traducción se hace en interface.
  final String name;

  /// Color value (e.g. ARGB integer).
  /// Valor de color (ej. entero ARGB).
  final int color;

  /// Unix timestamp (seconds) when the task category was created.
  /// Timestamp Unix (segundos) de creación.
  final int createdAt;

  const TaskCategoryDataRule({
    required this.id,
    required this.name,
    required this.color,
    required this.createdAt,
  });

  /// Checks if the task category has valid required fields.
  /// Verifica si la categoría de tarea tiene los campos requeridos válidos.
  bool get isValid => id.isNotEmpty && name.isNotEmpty;

  /// Creates a copy with updated values.
  /// Crea una copia con valores actualizados.
  TaskCategoryDataRule copyWith({
    String? id,
    String? name,
    int? color,
    int? createdAt,
  }) {
    return TaskCategoryDataRule(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TaskCategoryDataRule &&
        other.id == id &&
        other.name == name &&
        other.color == color &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hash(id, name, color, createdAt);

  @override
  String toString() =>
      'TaskCategoryDataRule(id: $id, name: $name, color: $color)';
}

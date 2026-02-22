/// Enum of known task priority localization keys. Stored in DB as [storageKey].
/// Enum de claves de localización de prioridad de tarea. Se almacenan en DB como [storageKey].
enum TaskPriorityKeyRule {
  low,
  medium,
  high;

  /// Value stored in DB and used as ARB key for localization.
  /// Valor almacenado en DB y usado como clave ARB para localización.
  String get storageKey => name;

  /// Parses a storage string into a known key, or null if unknown.
  /// Parsea un string de almacenamiento a una clave conocida, o null si es desconocida.
  static TaskPriorityKeyRule? fromStorageKey(String? key) {
    if (key == null || key.isEmpty) return null;
    for (final value in TaskPriorityKeyRule.values) {
      if (value.storageKey == key) return value;
    }
    return null;
  }
}

/// Represents a system notification.
/// Pure domain data. No technology details.
class NotificationDataRule {
  /// Unique identifier of the notification.
  /// Can be the related entity ID (e.g., task ID).
  /// ID de la notificación.
  /// Puede ser el ID de la entidad relacionada (por ejemplo, ID de la tarea).
  final int id;

  /// Title shown to the user.
  /// Título mostrado al usuario.
  final String title;

  /// Body content shown to the user.
  /// Contenido del cuerpo mostrado al usuario.
  final String body;

  /// Optional date to schedule the notification.
  /// If null, notification is immediate.
  /// Si es null, la notificación es inmediata.
  final int? scheduledAt;

  const NotificationDataRule({
    required this.id,
    required this.title,
    required this.body,
    this.scheduledAt,
  });
}

import 'package:task_manager_pro/core/rules/data/data_rules.dart';
import 'package:task_manager_pro/core/rules/responses/responses_rules.dart';

/// Contract for notification consumers.
/// Contrato para consumers de notificaciones.
///
/// Used by other modules to trigger notifications.
/// Usado por otros módulos para disparar notificaciones.
abstract class NotificationConsumerRule {
  /// Sends a notification.
  /// Envía una notificación.
  ///
  /// [data] Notification data to send.
  /// [data] Datos de notificación a enviar.
  ///
  /// Returns a response indicating success or failure.
  /// Devuelve una respuesta indicando éxito o fallo.
  Future<ApiResponseRule<Unit>> send(NotificationDataRule data);

  /// Cancels a notification by ID.
  /// Cancela una notificación por ID.
  ///
  /// [id] Unique notification identifier.
  /// [id] Identificador único de la notificación.
  ///
  /// Returns a response indicating success or failure.
  /// Devuelve una respuesta indicando éxito o fallo.
  Future<ApiResponseRule<Unit>> cancel(int id);

  /// Cancels all scheduled notifications.
  /// Cancela todas las notificaciones programadas.
  ///
  /// Returns a response indicating success or failure.
  /// Devuelve una respuesta indicando éxito o fallo.
  Future<ApiResponseRule<Unit>> cancelAll();
}

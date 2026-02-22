import 'package:task_manager_pro/core/rules/data/data_rules.dart';
import 'package:task_manager_pro/core/rules/responses/responses_rules.dart';

/// Contract for notification services.
/// Contrato para servicios de notificaciones.
///
/// Defines system-level notification capabilities.
/// Define capacidades de notificación a nivel de sistema.
abstract class NotificationServiceRule {
  /// Sends a notification.
  /// Envía una notificación.
  ///
  /// If `scheduledAt` is null, it should be shown immediately.
  /// Si `scheduledAt` es null, debe mostrarse de inmediato.
  ///
  /// If `scheduledAt` is provided, it should be scheduled.
  /// Si `scheduledAt` tiene valor, debe programarse.
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

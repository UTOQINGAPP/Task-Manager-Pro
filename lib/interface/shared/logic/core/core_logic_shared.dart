import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager_pro/core/core.dart';

/// Provider that supplies the real task service (singleton database allowed).
/// Provider que entrega el servicio real de tareas (singleton de base de datos permitido).
final taskServiceProvider = Provider<TaskServiceRule>((ref) {
  return TaskServiceUse(database: ManagerDatabase());
});

/// Provider that supplies the task consumer.
/// Provider que entrega el consumer de tareas.
final taskConsumerProvider = Provider<TaskConsumerRule>((ref) {
  return TaskConsumerUse(taskService: ref.read(taskServiceProvider));
});

/// Provider that supplies the task priority service.
/// Provider que entrega el servicio de prioridades de tarea.
final taskPriorityServiceProvider = Provider<TaskPriorityServiceRule>((ref) {
  return TaskPriorityServiceUse(database: ManagerDatabase());
});

/// Provider that supplies the task priority consumer.
/// Provider que entrega el consumer de prioridades de tarea.
final taskPriorityConsumerProvider = Provider<TaskPriorityConsumerRule>((ref) {
  return TaskPriorityConsumerUse(
    taskPriorityService: ref.read(taskPriorityServiceProvider),
  );
});

/// Provider that supplies the task category service.
/// Provider que entrega el servicio de categorías de tarea.
final taskCategoryServiceProvider = Provider<TaskCategoryServiceRule>((ref) {
  return TaskCategoryServiceUse(database: ManagerDatabase());
});

/// Provider that supplies the task category consumer.
/// Provider que entrega el consumer de categorías de tarea.
final taskCategoryConsumerProvider = Provider<TaskCategoryConsumerRule>((ref) {
  return TaskCategoryConsumerUse(
    taskCategoryService: ref.read(taskCategoryServiceProvider),
  );
});

/// Provider that supplies the notification connector (plugin singleton).
/// Provider que entrega el conector de notificaciones (singleton del plugin).
final localConnectorNotificationProvider = Provider<LocalConnectorNotification>(
  (ref) {
    return LocalConnectorNotification(flutterLocalNotificationsPlugin);
  },
);

/// Provider that supplies the notification service.
/// Provider que entrega el servicio de notificaciones.
final notificationServiceProvider = Provider<NotificationServiceRule>((ref) {
  return NotificationServiceUse(
    localConnector: ref.read(localConnectorNotificationProvider),
  );
});

/// Provider that supplies the notification consumer.
/// Provider que entrega el consumer de notificaciones.
final notificationConsumerProvider = Provider<NotificationConsumerRule>((ref) {
  return NotificationConsumerUse(
    notificationService: ref.read(notificationServiceProvider),
  );
});

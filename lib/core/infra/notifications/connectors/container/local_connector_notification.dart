import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

/// Connector between system and flutter_local_notifications plugin.
/// Pure technical implementation.
/// Conector entre el sistema y el plugin flutter_local_notifications.
/// Implementación puramente técnica.
class LocalConnectorNotification {
  final FlutterLocalNotificationsPlugin _plugin;

  LocalConnectorNotification(this._plugin);

  // ===========================
  // SHOW IMMEDIATE
  // ===========================

  Future<void> show({
    required int id,
    required String title,
    required String body,
  }) async {
    const iosDetails = DarwinNotificationDetails();

    const androidDetails = AndroidNotificationDetails(
      'task_channel',
      'Task Notifications',
      channelDescription: 'Notifications related to task reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }

  // ===========================
  // SCHEDULE
  // ===========================

  Future<void> schedule({
    required int id,
    required int scheduledAt,
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'task_channel',
      'Task Notifications',
      channelDescription: 'Notifications related to task reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    final tzDate = tz.TZDateTime.fromMillisecondsSinceEpoch(
      tz.local,
      scheduledAt,
    );

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tzDate,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // ===========================
  // CANCEL
  // ===========================

  Future<void> cancel(int id) async {
    await _plugin.cancel(id: id);
  }

  // ===========================
  // CANCEL ALL
  // ===========================

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}

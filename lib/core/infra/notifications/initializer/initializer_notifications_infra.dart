import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import 'package:timezone/data/latest_10y.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Infra initializer for local notifications.
/// Only technical configuration. No business logic.
/// Inicializador de notificaciones locales. Solo configuración técnica. No lógica empresarial.
class InitializerNotification {
  final FlutterLocalNotificationsPlugin _plugin;

  InitializerNotification(this._plugin);

  Future<void> initialize() async {
    tzdata.initializeTimeZones();

    try {
      final TimezoneInfo currentTimeZone =
          await FlutterTimezone.getLocalTimezone();

      tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));
    } catch (_) {
      // Fallback seguro
      tz.setLocalLocation(tz.local);
    }

    // ===========================
    // ANDROID SETTINGS
    // ===========================

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // ===========================
    // iOS SETTINGS
    // ===========================

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // ===========================
    // GLOBAL SETTINGS
    // ===========================

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(settings: settings);

    // ===========================
    // ANDROID PERMISSIONS
    // ===========================

    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    // Android 13+ notification permission
    await androidPlugin?.requestNotificationsPermission();

    // Android 14+ exact alarm permission
    await androidPlugin?.requestExactAlarmsPermission();

    // ===========================
    // iOS PERMISSIONS (EXTRA SAFETY)
    // ===========================

    final iosPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    await iosPlugin?.requestPermissions(alert: true, badge: true, sound: true);
  }
}

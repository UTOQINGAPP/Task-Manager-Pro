import 'package:task_manager_pro/core/rules/rules_core.dart';

class NotificationConsumerUse implements NotificationConsumerRule {
  final NotificationServiceRule _notificationService;
  NotificationConsumerUse({
    required NotificationServiceRule notificationService,
  }) : _notificationService = notificationService;

  @override
  Future<ApiResponseRule<Unit>> send(NotificationDataRule data) async {
    return _notificationService.send(data);
  }

  @override
  Future<ApiResponseRule<Unit>> cancel(int id) {
    return _notificationService.cancel(id);
  }

  @override
  Future<ApiResponseRule<Unit>> cancelAll() {
    return _notificationService.cancelAll();
  }
}

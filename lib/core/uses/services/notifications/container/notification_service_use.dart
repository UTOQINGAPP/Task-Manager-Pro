import 'package:task_manager_pro/core/infra/infra_core.dart';
import 'package:task_manager_pro/core/rules/rules_core.dart';

class NotificationServiceUse implements NotificationServiceRule {
  final LocalConnectorNotification _localConnector;
  NotificationServiceUse({required LocalConnectorNotification localConnector})
    : _localConnector = localConnector;

  @override
  Future<ApiResponseRule<Unit>> send(NotificationDataRule data) async {
    try {
      if (data.scheduledAt != null) {
        await _localConnector.schedule(
          id: data.id,
          title: data.title,
          body: data.body,
          scheduledAt: data.scheduledAt!,
        );
      } else {
        await _localConnector.show(
          id: data.id,
          title: data.title,
          body: data.body,
        );
      }
      return SuccessResponseRule<Unit>(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'SEND_NOTIFICATION',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> cancel(int id) async {
    try {
      await _localConnector.cancel(id);
      return SuccessResponseRule<Unit>(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'CANCEL_NOTIFICATION',
      );
    }
  }

  @override
  Future<ApiResponseRule<Unit>> cancelAll() async {
    try {
      await _localConnector.cancelAll();
      return SuccessResponseRule<Unit>(data: unit);
    } catch (e) {
      return FailureResponseRule<Unit>(
        message: e.toString(),
        errorCode: 'CANCEL_ALL_NOTIFICATIONS',
      );
    }
  }
}

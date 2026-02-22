import 'package:task_manager_pro/core/core.dart'
    show
        ApiResponseRule,
        SuccessResponseRule,
        unit,
        Unit,
        NotificationDataRule,
        NotificationServiceRule;

/// Fake implementation of [NotificationServiceRule] for tests.
/// Implementación falsa de [NotificationServiceRule] para pruebas.
class NotificationServiceUseFakeTest implements NotificationServiceRule {
  @override
  Future<ApiResponseRule<Unit>> send(NotificationDataRule data) async {
    return SuccessResponseRule<Unit>(data: unit);
  }

  @override
  Future<ApiResponseRule<Unit>> cancel(int id) async {
    return SuccessResponseRule<Unit>(data: unit);
  }

  @override
  Future<ApiResponseRule<Unit>> cancelAll() async {
    return SuccessResponseRule<Unit>(data: unit);
  }
}

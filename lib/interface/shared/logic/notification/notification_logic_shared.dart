import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager_pro/core/core.dart'
    show NotificationDataRule, NotificationConsumerRule;
import 'package:task_manager_pro/interface/shared/logic/core/core_logic_shared.dart'
    show notificationConsumerProvider;

part 'notification_logic_shared.g.dart';

@Riverpod(keepAlive: true)
class NotificationLogicShared extends _$NotificationLogicShared {
  late final NotificationConsumerRule _consumer = ref.read(
    notificationConsumerProvider,
  );

  @override
  void build() {
    // No state.
    // Pure command handler.
  }

  Future<void> send(NotificationDataRule data) async {
    final response = await _consumer.send(data);

    response.resolve(
      onSuccess: (_, _) {},
      onFailure: (message, errorCode) =>
          throw NotificationException(message: message, errorCode: errorCode),
    );
  }

  Future<void> cancel(int id) async {
    final response = await _consumer.cancel(id);

    response.resolve(
      onSuccess: (_, _) {},
      onFailure: (message, errorCode) =>
          throw NotificationException(message: message, errorCode: errorCode),
    );
  }

  Future<void> cancelAll() async {
    final response = await _consumer.cancelAll();

    response.resolve(
      onSuccess: (_, _) {},
      onFailure: (message, errorCode) =>
          throw NotificationException(message: message, errorCode: errorCode),
    );
  }
}

class NotificationException implements Exception {
  const NotificationException({required this.message, this.errorCode});

  final String message;
  final String? errorCode;

  @override
  String toString() => 'NotificationException($message, $errorCode)';
}

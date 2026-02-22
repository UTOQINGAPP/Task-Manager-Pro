// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_logic_shared.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationLogicShared)
final notificationLogicSharedProvider = NotificationLogicSharedProvider._();

final class NotificationLogicSharedProvider
    extends $NotifierProvider<NotificationLogicShared, void> {
  NotificationLogicSharedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationLogicSharedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationLogicSharedHash();

  @$internal
  @override
  NotificationLogicShared create() => NotificationLogicShared();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$notificationLogicSharedHash() =>
    r'8863cc72c0922e6305a33f05c849ff6e5bc817a8';

abstract class _$NotificationLogicShared extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

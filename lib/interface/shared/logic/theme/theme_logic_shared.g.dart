// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_logic_shared.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for app theme state. Get/set theme mode and follow-system option.
/// Notifier del estado del tema. Get/set del modo y opción de seguir al sistema.

@ProviderFor(ThemeLogicShared)
final themeLogicSharedProvider = ThemeLogicSharedProvider._();

/// Notifier for app theme state. Get/set theme mode and follow-system option.
/// Notifier del estado del tema. Get/set del modo y opción de seguir al sistema.
final class ThemeLogicSharedProvider
    extends $NotifierProvider<ThemeLogicShared, ThemeState> {
  /// Notifier for app theme state. Get/set theme mode and follow-system option.
  /// Notifier del estado del tema. Get/set del modo y opción de seguir al sistema.
  ThemeLogicSharedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeLogicSharedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeLogicSharedHash();

  @$internal
  @override
  ThemeLogicShared create() => ThemeLogicShared();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeState>(value),
    );
  }
}

String _$themeLogicSharedHash() => r'2c80e7ea40b7a8d5f939555af929386ad07aaaa0';

/// Notifier for app theme state. Get/set theme mode and follow-system option.
/// Notifier del estado del tema. Get/set del modo y opción de seguir al sistema.

abstract class _$ThemeLogicShared extends $Notifier<ThemeState> {
  ThemeState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ThemeState, ThemeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeState, ThemeState>,
              ThemeState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priority_logic_shared.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier that loads and holds the list of task priorities from core.
/// Notifier que carga y mantiene la lista de prioridades de tarea desde core.

@ProviderFor(PriorityLogicShared)
final priorityLogicSharedProvider = PriorityLogicSharedProvider._();

/// Notifier that loads and holds the list of task priorities from core.
/// Notifier que carga y mantiene la lista de prioridades de tarea desde core.
final class PriorityLogicSharedProvider
    extends
        $AsyncNotifierProvider<
          PriorityLogicShared,
          List<TaskPriorityDataRule>
        > {
  /// Notifier that loads and holds the list of task priorities from core.
  /// Notifier que carga y mantiene la lista de prioridades de tarea desde core.
  PriorityLogicSharedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'priorityLogicSharedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$priorityLogicSharedHash();

  @$internal
  @override
  PriorityLogicShared create() => PriorityLogicShared();
}

String _$priorityLogicSharedHash() =>
    r'5bdeb14713e02329d997d0b8511eaa3cbbd91cec';

/// Notifier that loads and holds the list of task priorities from core.
/// Notifier que carga y mantiene la lista de prioridades de tarea desde core.

abstract class _$PriorityLogicShared
    extends $AsyncNotifier<List<TaskPriorityDataRule>> {
  FutureOr<List<TaskPriorityDataRule>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<TaskPriorityDataRule>>,
              List<TaskPriorityDataRule>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TaskPriorityDataRule>>,
                List<TaskPriorityDataRule>
              >,
              AsyncValue<List<TaskPriorityDataRule>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

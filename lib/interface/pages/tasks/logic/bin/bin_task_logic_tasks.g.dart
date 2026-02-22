// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bin_task_logic_tasks.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier that manages moving tasks to bin (isBin: true). Maintains a list
/// of task IDs and executes move-to-bin via updateTask(isBin: true).
///
/// Notifier que gestiona el envío de tareas a papelera (isBin: true). Mantiene
/// una lista de IDs y ejecuta el cambio mediante updateTask(isBin: true).

@ProviderFor(BinTaskLogicTasks)
final binTaskLogicTasksProvider = BinTaskLogicTasksProvider._();

/// Notifier that manages moving tasks to bin (isBin: true). Maintains a list
/// of task IDs and executes move-to-bin via updateTask(isBin: true).
///
/// Notifier que gestiona el envío de tareas a papelera (isBin: true). Mantiene
/// una lista de IDs y ejecuta el cambio mediante updateTask(isBin: true).
final class BinTaskLogicTasksProvider
    extends $NotifierProvider<BinTaskLogicTasks, DeleteTaskState> {
  /// Notifier that manages moving tasks to bin (isBin: true). Maintains a list
  /// of task IDs and executes move-to-bin via updateTask(isBin: true).
  ///
  /// Notifier que gestiona el envío de tareas a papelera (isBin: true). Mantiene
  /// una lista de IDs y ejecuta el cambio mediante updateTask(isBin: true).
  BinTaskLogicTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'binTaskLogicTasksProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$binTaskLogicTasksHash();

  @$internal
  @override
  BinTaskLogicTasks create() => BinTaskLogicTasks();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteTaskState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteTaskState>(value),
    );
  }
}

String _$binTaskLogicTasksHash() => r'c77a50ae3ea46ff193a67089356a1f6e2682dc26';

/// Notifier that manages moving tasks to bin (isBin: true). Maintains a list
/// of task IDs and executes move-to-bin via updateTask(isBin: true).
///
/// Notifier que gestiona el envío de tareas a papelera (isBin: true). Mantiene
/// una lista de IDs y ejecuta el cambio mediante updateTask(isBin: true).

abstract class _$BinTaskLogicTasks extends $Notifier<DeleteTaskState> {
  DeleteTaskState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DeleteTaskState, DeleteTaskState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DeleteTaskState, DeleteTaskState>,
              DeleteTaskState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

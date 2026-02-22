// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_and_restore_logic_bin.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier that manages permanent deletion and restore of tasks in the bin.
/// Delete via [TaskConsumerRule.deleteTask]; restore via [TaskConsumerRule]
/// loadTaskById + updateTask(isBin: false).
///
/// Notifier que gestiona la eliminación permanente y la restauración de
/// tareas en la papelera. Elimina con deleteTask; restaura con loadTaskById
/// + updateTask(isBin: false).

@ProviderFor(DeleteAndRestoreTaskLogicBin)
final deleteAndRestoreTaskLogicBinProvider =
    DeleteAndRestoreTaskLogicBinProvider._();

/// Notifier that manages permanent deletion and restore of tasks in the bin.
/// Delete via [TaskConsumerRule.deleteTask]; restore via [TaskConsumerRule]
/// loadTaskById + updateTask(isBin: false).
///
/// Notifier que gestiona la eliminación permanente y la restauración de
/// tareas en la papelera. Elimina con deleteTask; restaura con loadTaskById
/// + updateTask(isBin: false).
final class DeleteAndRestoreTaskLogicBinProvider
    extends
        $NotifierProvider<
          DeleteAndRestoreTaskLogicBin,
          DeleteAndRestoreTaskState
        > {
  /// Notifier that manages permanent deletion and restore of tasks in the bin.
  /// Delete via [TaskConsumerRule.deleteTask]; restore via [TaskConsumerRule]
  /// loadTaskById + updateTask(isBin: false).
  ///
  /// Notifier que gestiona la eliminación permanente y la restauración de
  /// tareas en la papelera. Elimina con deleteTask; restaura con loadTaskById
  /// + updateTask(isBin: false).
  DeleteAndRestoreTaskLogicBinProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteAndRestoreTaskLogicBinProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteAndRestoreTaskLogicBinHash();

  @$internal
  @override
  DeleteAndRestoreTaskLogicBin create() => DeleteAndRestoreTaskLogicBin();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteAndRestoreTaskState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteAndRestoreTaskState>(value),
    );
  }
}

String _$deleteAndRestoreTaskLogicBinHash() =>
    r'd7f0c8129322566adda705b45e6f9284c331d040';

/// Notifier that manages permanent deletion and restore of tasks in the bin.
/// Delete via [TaskConsumerRule.deleteTask]; restore via [TaskConsumerRule]
/// loadTaskById + updateTask(isBin: false).
///
/// Notifier que gestiona la eliminación permanente y la restauración de
/// tareas en la papelera. Elimina con deleteTask; restaura con loadTaskById
/// + updateTask(isBin: false).

abstract class _$DeleteAndRestoreTaskLogicBin
    extends $Notifier<DeleteAndRestoreTaskState> {
  DeleteAndRestoreTaskState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<DeleteAndRestoreTaskState, DeleteAndRestoreTaskState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DeleteAndRestoreTaskState, DeleteAndRestoreTaskState>,
              DeleteAndRestoreTaskState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

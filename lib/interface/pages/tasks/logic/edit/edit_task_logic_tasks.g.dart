// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_task_logic_tasks.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Handles task updates and reschedules related notifications.
/// Gestiona la actualización de tareas y reprograma notificaciones relacionadas.

@ProviderFor(EditTaskLogicTasks)
final editTaskLogicTasksProvider = EditTaskLogicTasksProvider._();

/// Handles task updates and reschedules related notifications.
/// Gestiona la actualización de tareas y reprograma notificaciones relacionadas.
final class EditTaskLogicTasksProvider
    extends $NotifierProvider<EditTaskLogicTasks, void> {
  /// Handles task updates and reschedules related notifications.
  /// Gestiona la actualización de tareas y reprograma notificaciones relacionadas.
  EditTaskLogicTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editTaskLogicTasksProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editTaskLogicTasksHash();

  @$internal
  @override
  EditTaskLogicTasks create() => EditTaskLogicTasks();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$editTaskLogicTasksHash() =>
    r'5b7424d81e42331326f78b9c7281cd689ad6e511';

/// Handles task updates and reschedules related notifications.
/// Gestiona la actualización de tareas y reprograma notificaciones relacionadas.

abstract class _$EditTaskLogicTasks extends $Notifier<void> {
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_task_logic_tasks.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Handles task creation and schedules related notifications.
/// Gestiona la creación de tareas y programa notificaciones relacionadas.

@ProviderFor(CreateTaskLogicTasks)
final createTaskLogicTasksProvider = CreateTaskLogicTasksProvider._();

/// Handles task creation and schedules related notifications.
/// Gestiona la creación de tareas y programa notificaciones relacionadas.
final class CreateTaskLogicTasksProvider
    extends $NotifierProvider<CreateTaskLogicTasks, void> {
  /// Handles task creation and schedules related notifications.
  /// Gestiona la creación de tareas y programa notificaciones relacionadas.
  CreateTaskLogicTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createTaskLogicTasksProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createTaskLogicTasksHash();

  @$internal
  @override
  CreateTaskLogicTasks create() => CreateTaskLogicTasks();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$createTaskLogicTasksHash() =>
    r'2d4b26f74fa210acf2cbf2ec5a0c98a3a095df43';

/// Handles task creation and schedules related notifications.
/// Gestiona la creación de tareas y programa notificaciones relacionadas.

abstract class _$CreateTaskLogicTasks extends $Notifier<void> {
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

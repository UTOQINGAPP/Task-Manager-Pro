// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_logic_shared.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier that loads and holds the list of tasks and exposes CRUD operations.
/// Notifier que carga y mantiene la lista de tareas y expone operaciones CRUD.

@ProviderFor(TasksLogicShared)
final tasksLogicSharedProvider = TasksLogicSharedProvider._();

/// Notifier that loads and holds the list of tasks and exposes CRUD operations.
/// Notifier que carga y mantiene la lista de tareas y expone operaciones CRUD.
final class TasksLogicSharedProvider
    extends $AsyncNotifierProvider<TasksLogicShared, List<TaskDataRule>> {
  /// Notifier that loads and holds the list of tasks and exposes CRUD operations.
  /// Notifier que carga y mantiene la lista de tareas y expone operaciones CRUD.
  TasksLogicSharedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tasksLogicSharedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tasksLogicSharedHash();

  @$internal
  @override
  TasksLogicShared create() => TasksLogicShared();
}

String _$tasksLogicSharedHash() => r'd8072dee504d906b08793e1fb49351efe4a5a25e';

/// Notifier that loads and holds the list of tasks and exposes CRUD operations.
/// Notifier que carga y mantiene la lista de tareas y expone operaciones CRUD.

abstract class _$TasksLogicShared extends $AsyncNotifier<List<TaskDataRule>> {
  FutureOr<List<TaskDataRule>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<TaskDataRule>>, List<TaskDataRule>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<TaskDataRule>>, List<TaskDataRule>>,
              AsyncValue<List<TaskDataRule>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

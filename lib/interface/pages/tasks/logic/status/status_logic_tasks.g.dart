// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_logic_tasks.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier that loads tasks and calculates statistics (total, completed, pending).
///
/// Notifier que carga tareas y calcula estadísticas (total, completadas, pendientes).

@ProviderFor(StatusLogicTasks)
final statusLogicTasksProvider = StatusLogicTasksProvider._();

/// Notifier that loads tasks and calculates statistics (total, completed, pending).
///
/// Notifier que carga tareas y calcula estadísticas (total, completadas, pendientes).
final class StatusLogicTasksProvider
    extends $AsyncNotifierProvider<StatusLogicTasks, TaskStatusState> {
  /// Notifier that loads tasks and calculates statistics (total, completed, pending).
  ///
  /// Notifier que carga tareas y calcula estadísticas (total, completadas, pendientes).
  StatusLogicTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statusLogicTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statusLogicTasksHash();

  @$internal
  @override
  StatusLogicTasks create() => StatusLogicTasks();
}

String _$statusLogicTasksHash() => r'd21febd44512fa911d05ade390d9ff2be0d813d9';

/// Notifier that loads tasks and calculates statistics (total, completed, pending).
///
/// Notifier que carga tareas y calcula estadísticas (total, completadas, pendientes).

abstract class _$StatusLogicTasks extends $AsyncNotifier<TaskStatusState> {
  FutureOr<TaskStatusState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<TaskStatusState>, TaskStatusState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TaskStatusState>, TaskStatusState>,
              AsyncValue<TaskStatusState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

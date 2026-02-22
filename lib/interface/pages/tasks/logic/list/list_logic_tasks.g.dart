// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_logic_tasks.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Loads tasks and applies search/filter operations over in-memory data.
/// Carga tareas y aplica operaciones de búsqueda/filtro en memoria.

@ProviderFor(ListLogicTasks)
final listLogicTasksProvider = ListLogicTasksProvider._();

/// Loads tasks and applies search/filter operations over in-memory data.
/// Carga tareas y aplica operaciones de búsqueda/filtro en memoria.
final class ListLogicTasksProvider
    extends $AsyncNotifierProvider<ListLogicTasks, TaskListState> {
  /// Loads tasks and applies search/filter operations over in-memory data.
  /// Carga tareas y aplica operaciones de búsqueda/filtro en memoria.
  ListLogicTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listLogicTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listLogicTasksHash();

  @$internal
  @override
  ListLogicTasks create() => ListLogicTasks();
}

String _$listLogicTasksHash() => r'f6e77ae065eb936eb1666a35d3e075a673792c4d';

/// Loads tasks and applies search/filter operations over in-memory data.
/// Carga tareas y aplica operaciones de búsqueda/filtro en memoria.

abstract class _$ListLogicTasks extends $AsyncNotifier<TaskListState> {
  FutureOr<TaskListState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<TaskListState>, TaskListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TaskListState>, TaskListState>,
              AsyncValue<TaskListState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

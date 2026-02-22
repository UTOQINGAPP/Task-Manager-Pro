import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager_pro/core/core.dart'
    show
        TaskDataRule,
        TaskCategoryDataRule,
        TaskPriorityDataRule;
import 'package:task_manager_pro/interface/shared/shared.dart'
    show tasksLogicSharedProvider;

part 'list_logic_tasks.g.dart';

/// Immutable state for task list, search query, and active filters.
/// Estado inmutable para la lista de tareas, búsqueda y filtros activos.
class TaskListState {
  const TaskListState({
    required this.allTasks,
    required this.visibleTasks,
    this.query = '',
    this.category,
    this.priority,
    this.isCompleted,
    this.isArchived,
  });

  final List<TaskDataRule> allTasks;
  final List<TaskDataRule> visibleTasks;
  final String query;
  final TaskCategoryDataRule? category;
  final TaskPriorityDataRule? priority;
  final bool? isCompleted;
  final bool? isArchived;
  bool get hasActiveFilters =>
      query.isNotEmpty ||
      category != null ||
      priority != null ||
      isCompleted != null ||
      isArchived != null;

  bool get isSearchActive => query.isNotEmpty;

  bool get isFilterActive =>
      category != null ||
      priority != null ||
      isCompleted != null ||
      isArchived != null;

  TaskListState copyWith({
    List<TaskDataRule>? allTasks,
    List<TaskDataRule>? visibleTasks,
    String? query,
    TaskCategoryDataRule? category,
    TaskPriorityDataRule? priority,
    bool? isCompleted,
    bool? isArchived,
  }) {
    return TaskListState(
      allTasks: allTasks ?? this.allTasks,
      visibleTasks: visibleTasks ?? this.visibleTasks,
      query: query ?? this.query,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}

@riverpod
/// Loads tasks and applies search/filter operations over in-memory data.
/// Carga tareas y aplica operaciones de búsqueda/filtro en memoria.
class ListLogicTasks extends _$ListLogicTasks {
  @override
  Future<TaskListState> build() async {
    final tasks = await ref.read(tasksLogicSharedProvider.future);
    final activeTasks = tasks
        .where((task) => !task.isArchived && !task.isBin)
        .toList();
    return TaskListState(allTasks: tasks, visibleTasks: activeTasks);
  }

  /// Reloads the task list from [TasksLogicShared] and rebuilds local state.
  /// Recarga la lista de tareas desde [TasksLogicShared] y reconstruye el estado local.
  Future<void> refresh() async {
    state = const AsyncLoading();
    await ref.read(tasksLogicSharedProvider.notifier).refresh();
    state = await AsyncValue.guard(() => build());
  }

  /// Applies a text search by title/description while keeping filter state.
  /// Aplica búsqueda por título/descripción manteniendo el estado de filtros.
  void search(String query) {
    final current = state.value;
    if (current == null) return;

    final trimmed = query.trim();
    final lower = trimmed.toLowerCase();

    final filtered = trimmed.isEmpty
        ? _applyFilters(current.copyWith(query: ''))
        : current.allTasks.where((task) {
            if (task.isBin) return false;
            final titleMatch = task.title.toLowerCase().contains(lower);
            final descMatch =
                task.description?.toLowerCase().contains(lower) ?? false;
            return titleMatch || descMatch;
          }).toList();

    state = AsyncData(current.copyWith(query: trimmed, visibleTasks: filtered));
  }

  /// Applies category, priority, and completion filters.
  /// Aplica filtros de categoría, prioridad y completado.
  void filter({
    TaskCategoryDataRule? category,
    TaskPriorityDataRule? priority,
    bool? isCompleted,
    bool? isArchived,
  }) {
    final current = state.value;
    if (current == null) return;

    final updated = current.copyWith(
      category: category,
      priority: priority,
      isCompleted: isCompleted,
      isArchived: isArchived,
    );

    final filtered = _applyFilters(updated);

    state = AsyncData(updated.copyWith(visibleTasks: filtered));
  }

  /// Clears search and filter criteria, restoring all loaded tasks.
  /// Limpia búsqueda y filtros, restaurando todas las tareas cargadas.
  void clearFilters() {
    final current = state.value;
    if (current == null) return;
    final List<TaskDataRule> activeTasks = current.allTasks
        .where((TaskDataRule task) => !task.isArchived && !task.isBin)
        .toList();

    state = AsyncData(
      TaskListState(
        allTasks: current.allTasks,
        visibleTasks: activeTasks,
        query: '',
        category: null,
        priority: null,
        isCompleted: null,
        isArchived: null,
      ),
    );
  }

  /// Internal predicate-based filtering over [TaskListState.allTasks].
  /// Filtrado interno basado en predicados sobre [TaskListState.allTasks].
  List<TaskDataRule> _applyFilters(TaskListState state) {
    final lowerQuery = state.query.toLowerCase();

    return state.allTasks.where((task) {
      if (task.isBin) return false;

      if (state.category != null && task.taskCategoryId != state.category!.id) {
        return false;
      }

      if (state.priority != null && task.taskPriorityId != state.priority!.id) {
        return false;
      }

      if (state.isCompleted != null && task.isCompleted != state.isCompleted) {
        return false;
      }

      if (state.isArchived != null && task.isArchived != state.isArchived) {
        return false;
      }

      if (state.query.isNotEmpty) {
        final titleMatch = task.title.toLowerCase().contains(lowerQuery);
        final descMatch =
            task.description?.toLowerCase().contains(lowerQuery) ?? false;

        if (!titleMatch && !descMatch) return false;
      }

      return true;
    }).toList();
  }
}

class ListTasksException implements Exception {
  /// Exception thrown when task list loading fails.
  /// Excepción lanzada cuando falla la carga de la lista de tareas.
  const ListTasksException({required this.message, this.errorCode});

  final String message;
  final String? errorCode;

  @override
  String toString() => 'ListTasksException($message, $errorCode)';
}

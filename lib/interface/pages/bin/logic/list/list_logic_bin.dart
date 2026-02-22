import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager_pro/core/core.dart'
    show
        TaskDataRule,
        TaskCategoryDataRule,
        TaskPriorityDataRule;
import 'package:task_manager_pro/interface/shared/shared.dart'
    show tasksLogicSharedProvider, ListTasksLogicException;

part 'list_logic_bin.g.dart';

/// Immutable state for bin task list, search query, and active filters.
/// Estado inmutable para la lista de tareas en papelera, búsqueda y filtros activos.
class BinListState {
  const BinListState({
    required this.allTasks,
    required this.visibleTasks,
    this.query = '',
    this.category,
    this.priority,
  });

  final List<TaskDataRule> allTasks;
  final List<TaskDataRule> visibleTasks;
  final String query;
  final TaskCategoryDataRule? category;
  final TaskPriorityDataRule? priority;

  bool get hasActiveFilters =>
      query.isNotEmpty || category != null || priority != null;

  bool get isSearchActive => query.isNotEmpty;

  bool get isFilterActive => category != null || priority != null;

  BinListState copyWith({
    List<TaskDataRule>? allTasks,
    List<TaskDataRule>? visibleTasks,
    String? query,
    TaskCategoryDataRule? category,
    TaskPriorityDataRule? priority,
  }) {
    return BinListState(
      allTasks: allTasks ?? this.allTasks,
      visibleTasks: visibleTasks ?? this.visibleTasks,
      query: query ?? this.query,
      category: category ?? this.category,
      priority: priority ?? this.priority,
    );
  }
}

@riverpod
/// Loads tasks in bin (isBin == true) and applies search/filter operations.
/// Carga tareas en papelera (isBin == true) y aplica búsqueda/filtro.
class ListLogicBin extends _$ListLogicBin {
  @override
  Future<BinListState> build() async {
    final List<TaskDataRule> tasks =
        await ref.read(tasksLogicSharedProvider.future);
    final List<TaskDataRule> binTasks =
        tasks.where((TaskDataRule t) => t.isBin).toList();
    return BinListState(allTasks: binTasks, visibleTasks: binTasks);
  }

  /// Reloads the bin list from [TasksLogicShared].
  /// Recarga la lista de papelera desde [TasksLogicShared].
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
        : current.allTasks.where((TaskDataRule task) {
            if (!task.isBin) return false;
            final titleMatch = task.title.toLowerCase().contains(lower);
            final descMatch =
                task.description?.toLowerCase().contains(lower) ?? false;
            return titleMatch || descMatch;
          }).toList();

    state = AsyncData(current.copyWith(query: trimmed, visibleTasks: filtered));
  }

  /// Applies category and priority filters.
  /// Aplica filtros de categoría y prioridad.
  void filter({
    TaskCategoryDataRule? category,
    TaskPriorityDataRule? priority,
  }) {
    final current = state.value;
    if (current == null) return;

    final updated = current.copyWith(category: category, priority: priority);

    final filtered = _applyFilters(updated);

    state = AsyncData(updated.copyWith(visibleTasks: filtered));
  }

  /// Clears search and filter criteria, restoring all loaded bin tasks.
  /// Limpia búsqueda y filtros, restaurando todas las tareas de papelera cargadas.
  void clearFilters() {
    final current = state.value;
    if (current == null) return;

    state = AsyncData(
      BinListState(
        allTasks: current.allTasks,
        visibleTasks: current.allTasks,
        query: '',
        category: null,
        priority: null,
      ),
    );
  }

  /// Permanently deletes a task by id and refreshes the list.
  /// Elimina permanentemente una tarea por id y actualiza la lista.
  Future<void> deleteById(String id) async {
    try {
      await ref.read(tasksLogicSharedProvider.notifier).deleteTask(id: id);
    } on ListTasksLogicException catch (e) {
      throw ListBinException(message: e.message, errorCode: e.errorCode);
    }
    await refresh();
  }

  /// Permanently deletes all tasks currently in the bin and refreshes.
  /// Elimina permanentemente todas las tareas en la papelera y actualiza.
  Future<void> deleteAll() async {
    final current = state.value;
    if (current == null || current.allTasks.isEmpty) return;

    final notifier = ref.read(tasksLogicSharedProvider.notifier);
    for (final task in current.allTasks) {
      try {
        await notifier.deleteTask(id: task.id);
      } on ListTasksLogicException catch (e) {
        throw ListBinException(message: e.message, errorCode: e.errorCode);
      }
    }
    await refresh();
  }

  /// Restores a single task from the bin (sets isBin to false) and refreshes.
  /// Restaura una tarea de la papelera (pone isBin en false) y actualiza.
  Future<void> restoreById(String id) async {
    final notifier = ref.read(tasksLogicSharedProvider.notifier);
    try {
      final TaskDataRule? data = await notifier.getTaskById(id: id);
      if (data == null || !data.isBin) return;
      final TaskDataRule updated = data.copyWith(isBin: false);
      await notifier.updateTask(task: updated);
    } on ListTasksLogicException catch (e) {
      throw ListBinException(message: e.message, errorCode: e.errorCode);
    }
    await refresh();
  }

  /// Restores all tasks from the bin (sets isBin to false for each) and refreshes.
  /// Restaura todas las tareas de la papelera y actualiza.
  Future<void> restoreAll() async {
    final current = state.value;
    if (current == null || current.allTasks.isEmpty) return;

    final notifier = ref.read(tasksLogicSharedProvider.notifier);
    for (final task in current.allTasks) {
      final TaskDataRule updated = task.copyWith(isBin: false);
      try {
        await notifier.updateTask(task: updated);
      } on ListTasksLogicException catch (e) {
        throw ListBinException(message: e.message, errorCode: e.errorCode);
      }
    }
    await refresh();
  }

  /// Internal predicate-based filtering over [BinListState.allTasks].
  /// Filtrado interno basado en predicados sobre [BinListState.allTasks].
  List<TaskDataRule> _applyFilters(BinListState state) {
    final lowerQuery = state.query.toLowerCase();

    return state.allTasks.where((TaskDataRule task) {
      if (!task.isBin) return false;

      if (state.category != null && task.taskCategoryId != state.category!.id) {
        return false;
      }

      if (state.priority != null && task.taskPriorityId != state.priority!.id) {
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

/// Exception thrown when bin list loading or operations fail.
/// Excepción cuando falla la carga u operaciones de la lista de papelera.
class ListBinException implements Exception {
  const ListBinException({required this.message, this.errorCode});

  final String message;
  final String? errorCode;

  @override
  String toString() => 'ListBinException($message, $errorCode)';
}

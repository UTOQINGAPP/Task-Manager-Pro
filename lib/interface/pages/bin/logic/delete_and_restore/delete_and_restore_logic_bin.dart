import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager_pro/core/core.dart' show TaskDataRule;
import 'package:task_manager_pro/interface/shared/shared.dart'
    show tasksLogicSharedProvider, ListTasksLogicException;

part 'delete_and_restore_logic_bin.g.dart';

// ═══════════════════════════════════════════════════════════════════════════
// DELETE AND RESTORE LOGIC (Bin) – permanent delete & restore (isBin: false)
// ═══════════════════════════════════════════════════════════════════════════

/// State for delete-and-restore logic (bin). Holds the list of selected task
/// IDs and the status of delete/restore operations.
///
/// Estado para la lógica eliminar/restaurar (papelera). Mantiene la lista de
/// IDs seleccionados y el estado de las operaciones de eliminar/restaurar.
class DeleteAndRestoreTaskState {
  /// List of task IDs selected (for delete or restore).
  /// Lista de IDs de tareas seleccionadas (para eliminar o restaurar).
  final List<String> selectedTaskIds;

  /// Whether selection mode is active.
  /// Si el modo selección está activo.
  final bool isSelectionMode;

  /// Whether permanent-delete is in progress.
  /// Si la eliminación permanente está en progreso.
  final bool isDeleting;

  /// Number of tasks successfully deleted.
  /// Número de tareas eliminadas exitosamente.
  final int deletedCount;

  /// Number of failed delete operations.
  /// Número de operaciones de eliminación fallidas.
  final int failedCount;

  /// Whether restore (isBin: false) is in progress.
  /// Si la restauración (isBin: false) está en progreso.
  final bool isRestoring;

  /// Number of tasks successfully restored.
  /// Número de tareas restauradas exitosamente.
  final int restoredCount;

  /// Number of failed restore operations.
  /// Número de operaciones de restauración fallidas.
  final int restoreFailedCount;

  /// Error message if last operation failed.
  /// Mensaje de error si la última operación falló.
  final String? errorMessage;

  const DeleteAndRestoreTaskState({
    this.selectedTaskIds = const [],
    this.isDeleting = false,
    this.deletedCount = 0,
    this.failedCount = 0,
    this.isRestoring = false,
    this.restoredCount = 0,
    this.restoreFailedCount = 0,
    this.errorMessage,
    this.isSelectionMode = false,
  });

  /// Returns true if there are tasks selected (for delete or restore).
  /// Retorna true si hay tareas seleccionadas (para eliminar o restaurar).
  bool get hasSelectedTasks => selectedTaskIds.isNotEmpty;

  /// Returns the total number of tasks selected.
  /// Retorna el número total de tareas seleccionadas.
  int get selectedTasksCount => selectedTaskIds.length;

  /// Returns true if any task was successfully deleted or restored in the
  /// current/last operation.
  /// Retorna true si alguna tarea fue eliminada o restaurada exitosamente.
  bool get hasDeletedOrRestoredTasks => deletedCount > 0 || restoredCount > 0;

  DeleteAndRestoreTaskState copyWith({
    List<String>? selectedTaskIds,
    bool? isDeleting,
    int? deletedCount,
    int? failedCount,
    bool? isRestoring,
    int? restoredCount,
    int? restoreFailedCount,
    String? errorMessage,
    bool clearError = false,
    bool? isSelectionMode,
  }) {
    return DeleteAndRestoreTaskState(
      selectedTaskIds: selectedTaskIds ?? this.selectedTaskIds,
      isDeleting: isDeleting ?? this.isDeleting,
      deletedCount: deletedCount ?? this.deletedCount,
      failedCount: failedCount ?? this.failedCount,
      isRestoring: isRestoring ?? this.isRestoring,
      restoredCount: restoredCount ?? this.restoredCount,
      restoreFailedCount: restoreFailedCount ?? this.restoreFailedCount,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
    );
  }
}

/// Notifier that manages permanent deletion and restore of tasks in the bin.
/// Delete and restore via [TasksLogicShared] (deleteTask, getTaskById, updateTask).
///
/// Notifier que gestiona la eliminación permanente y la restauración de
/// tareas en la papelera mediante [TasksLogicShared].
@Riverpod(keepAlive: true)
class DeleteAndRestoreTaskLogicBin extends _$DeleteAndRestoreTaskLogicBin {
  @override
  DeleteAndRestoreTaskState build() => const DeleteAndRestoreTaskState();

  /// Enables selection mode.
  /// Habilita el modo selección.
  void enableSelectionMode() {
    state = state.copyWith(isSelectionMode: true);
  }

  /// Disables selection mode.
  /// Deshabilita el modo selección.
  void disableSelectionMode() {
    state = state.copyWith(isSelectionMode: false, selectedTaskIds: const []);
  }

  /// Adds a task ID to the selected list (for delete or restore). If the ID
  /// is already in the list, it won't be added again.
  ///
  /// Añade un ID de tarea a la lista seleccionada (eliminar o restaurar). Si
  /// el ID ya está en la lista, no se añadirá de nuevo.
  ///
  /// [taskId] Task ID to add. / ID de tarea a añadir.
  void addSelectedTask(String taskId) {
    if (state.selectedTaskIds.contains(taskId)) {
      return;
    }
    state = state.copyWith(
      selectedTaskIds: [...state.selectedTaskIds, taskId],
      clearError: true,
    );
  }

  /// Removes a task ID from the selected list.
  ///
  /// Quita un ID de tarea de la lista seleccionada.
  ///
  /// [taskId] Task ID to remove. / ID de tarea a quitar.
  void removeSelectedTask(String taskId) {
    if (!state.selectedTaskIds.contains(taskId)) {
      return;
    }
    state = state.copyWith(
      selectedTaskIds: state.selectedTaskIds
          .where((String id) => id != taskId)
          .toList(),
      clearError: true,
    );
  }

  /// Adds multiple task IDs to the selected list.
  ///
  /// Añade múltiples IDs de tareas a la lista seleccionada.
  ///
  /// [taskIds] List of task IDs to add. / Lista de IDs de tareas a añadir.
  void addSelectedTasks(List<String> taskIds) {
    final Set<String> currentIds = state.selectedTaskIds.toSet();
    currentIds.addAll(taskIds);
    state = state.copyWith(
      selectedTaskIds: currentIds.toList(),
      clearError: true,
    );
  }

  /// Removes multiple task IDs from the selected list.
  ///
  /// Quita múltiples IDs de tareas de la lista seleccionada.
  ///
  /// [taskIds] List of task IDs to remove. / Lista de IDs de tareas a quitar.
  void removeSelectedTasks(List<String> taskIds) {
    final Set<String> taskIdsSet = taskIds.toSet();
    state = state.copyWith(
      selectedTaskIds: state.selectedTaskIds
          .where((String id) => !taskIdsSet.contains(id))
          .toList(),
      clearError: true,
    );
  }

  /// Checks if a task ID is in the selected list.
  ///
  /// Verifica si un ID de tarea está en la lista seleccionada.
  ///
  /// [taskId] Task ID to check. / ID de tarea a verificar.
  ///
  /// Returns true if the task ID is in the list.
  /// Retorna true si el ID de tarea está en la lista.
  bool isTaskSelected(String taskId) {
    return state.selectedTaskIds.contains(taskId);
  }

  /// Clears all task IDs from the selected list.
  ///
  /// Limpia todos los IDs de tareas de la lista seleccionada.
  void clearSelectedTasks() {
    state = state.copyWith(selectedTaskIds: const [], clearError: true);
  }

  /// Permanently deletes all tasks in the list from storage via
  /// [TasksLogicShared.deleteTask]. Tracks success/failure per id.
  ///
  /// Elimina permanentemente todas las tareas de la lista usando
  /// [TasksLogicShared.deleteTask]. Rastrea éxitos/fallos por id.
  ///
  /// Returns the number of tasks successfully deleted.
  /// Retorna el número de tareas eliminadas exitosamente.
  ///
  /// Throws [PermanentDeleteTaskException] if all delete operations fail or
  /// list is empty.
  /// Lanza [PermanentDeleteTaskException] si todas las operaciones fallan o
  /// la lista está vacía.
  Future<int> executeDeletion() async {
    if (state.selectedTaskIds.isEmpty) {
      throw const PermanentDeleteTaskException(
        message: 'No tasks selected to delete permanently',
        errorCode: 'EMPTY_LIST',
      );
    }

    if (!ref.mounted) {
      throw const PermanentDeleteTaskException(
        message: 'Provider disposed',
        errorCode: 'UNMOUNTED',
      );
    }

    state = state.copyWith(
      isDeleting: true,
      deletedCount: 0,
      failedCount: 0,
      clearError: true,
    );

    int deletedCount = 0;
    int failedCount = 0;
    String? lastError;
    final List<String> idsToProcess = List<String>.from(state.selectedTaskIds);
    final tasksNotifier = ref.read(tasksLogicSharedProvider.notifier);

    for (final String taskId in idsToProcess) {
      if (!ref.mounted) {
        throw const PermanentDeleteTaskException(
          message: 'Provider disposed during permanent delete',
          errorCode: 'UNMOUNTED',
        );
      }

      try {
        await tasksNotifier.deleteTask(id: taskId);
        deletedCount++;
      } on ListTasksLogicException catch (e) {
        failedCount++;
        lastError = e.message;
      } catch (e) {
        failedCount++;
        lastError = e.toString();
      }

      if (ref.mounted) {
        state = state.copyWith(
          deletedCount: deletedCount,
          failedCount: failedCount,
          errorMessage: lastError,
        );
      }
    }

    if (!ref.mounted) {
      throw const PermanentDeleteTaskException(
        message: 'Provider disposed',
        errorCode: 'UNMOUNTED',
      );
    }

    state = state.copyWith(
      isDeleting: false,
      deletedCount: deletedCount,
      failedCount: failedCount,
      errorMessage: failedCount > 0 ? lastError : null,
    );

    if (failedCount == idsToProcess.length) {
      throw PermanentDeleteTaskException(
        message: lastError ?? 'All permanent delete operations failed',
        errorCode: 'ALL_FAILED',
      );
    }

    if (deletedCount > 0) {
      state = state.copyWith(selectedTaskIds: const []);
    }

    return deletedCount;
  }

  /// Restores all selected tasks (sets isBin to false) via [TasksLogicShared]
  /// getTaskById + updateTask. Tracks success/failure counts.
  ///
  /// Restaura todas las tareas seleccionadas (isBin: false) usando
  /// [TasksLogicShared]. Rastrea éxitos/fallos.
  ///
  /// Returns the number of tasks successfully restored.
  /// Retorna el número de tareas restauradas exitosamente.
  ///
  /// Throws [RestoreTaskException] if all restore operations fail or list is empty.
  /// Lanza [RestoreTaskException] si todas las operaciones fallan o la lista está vacía.
  Future<int> executeRestore() async {
    if (state.selectedTaskIds.isEmpty) {
      throw const RestoreTaskException(
        message: 'No tasks selected to restore',
        errorCode: 'EMPTY_LIST',
      );
    }

    if (!ref.mounted) {
      throw const RestoreTaskException(
        message: 'Provider disposed',
        errorCode: 'UNMOUNTED',
      );
    }

    state = state.copyWith(
      isRestoring: true,
      restoredCount: 0,
      restoreFailedCount: 0,
      clearError: true,
    );

    int restoredCount = 0;
    int restoreFailedCount = 0;
    String? lastError;
    final List<String> idsToProcess = List<String>.from(state.selectedTaskIds);
    final tasksNotifier = ref.read(tasksLogicSharedProvider.notifier);

    for (final String taskId in idsToProcess) {
      if (!ref.mounted) {
        throw const RestoreTaskException(
          message: 'Provider disposed during restore',
          errorCode: 'UNMOUNTED',
        );
      }

      try {
        final TaskDataRule? data = await tasksNotifier.getTaskById(id: taskId);
        if (data == null) {
          restoreFailedCount++;
          lastError = 'Task not found';
        } else {
          final TaskDataRule updated = data.copyWith(isBin: false);
          await tasksNotifier.updateTask(task: updated);
          restoredCount++;
        }
      } on ListTasksLogicException catch (e) {
        restoreFailedCount++;
        lastError = e.message;
      } catch (e) {
        restoreFailedCount++;
        lastError = e.toString();
      }

      if (ref.mounted) {
        state = state.copyWith(
          restoredCount: restoredCount,
          restoreFailedCount: restoreFailedCount,
          errorMessage: lastError,
        );
      }
    }

    if (!ref.mounted) {
      throw const RestoreTaskException(
        message: 'Provider disposed',
        errorCode: 'UNMOUNTED',
      );
    }

    state = state.copyWith(
      isRestoring: false,
      restoredCount: restoredCount,
      restoreFailedCount: restoreFailedCount,
      errorMessage: restoreFailedCount > 0 ? lastError : null,
    );

    if (restoreFailedCount == idsToProcess.length) {
      throw RestoreTaskException(
        message: lastError ?? 'All restore operations failed',
        errorCode: 'ALL_FAILED',
      );
    }

    if (restoredCount > 0) {
      state = state.copyWith(selectedTaskIds: const []);
    }

    return restoredCount;
  }

  /// Resets the delete-and-restore state to initial values.
  ///
  /// Reinicia el estado eliminar/restaurar a los valores iniciales.
  void reset() {
    if (ref.mounted) {
      state = const DeleteAndRestoreTaskState();
    }
  }
}

/// Exception thrown when permanent delete from bin fails.
/// Excepción lanzada cuando falla la eliminación permanente desde la papelera.
class PermanentDeleteTaskException implements Exception {
  const PermanentDeleteTaskException({required this.message, this.errorCode});

  final String message;
  final String? errorCode;

  @override
  String toString() => 'PermanentDeleteTaskException($message, $errorCode)';
}

/// Exception thrown when restore from bin fails.
/// Excepción lanzada cuando falla la restauración desde la papelera.
class RestoreTaskException implements Exception {
  const RestoreTaskException({required this.message, this.errorCode});

  final String message;
  final String? errorCode;

  @override
  String toString() => 'RestoreTaskException($message, $errorCode)';
}

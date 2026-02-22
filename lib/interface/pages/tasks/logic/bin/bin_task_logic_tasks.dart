import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager_pro/core/core.dart' show TaskDataRule;
import 'package:task_manager_pro/interface/shared/shared.dart'
    show tasksLogicSharedProvider, ListTasksLogicException;

part 'bin_task_logic_tasks.g.dart';

// ═══════════════════════════════════════════════════════════════════════════
// BIN TASKS LOGIC (Notifier) – moves tasks to bin (isBin: true)
// ═══════════════════════════════════════════════════════════════════════════

/// State for move-to-bin logic. Holds the list of task IDs to move to bin
/// and the operation status.
///
/// Estado para la lógica de enviar a papelera. Mantiene la lista de IDs
/// de tareas a enviar a papelera y el estado de la operación.
class DeleteTaskState {
  /// List of task IDs selected to move to bin.
  /// Lista de IDs de tareas seleccionadas para enviar a papelera.
  final List<String> taskIdsToDelete;

  /// Whether the move-to-bin is in selection mode.
  /// Si el envío a papelera está en modo selección.
  final bool isSelectionMode;

  /// Whether move-to-bin is in progress.
  /// Si el envío a papelera está en progreso.
  final bool isDeleting;

  /// Number of tasks successfully moved to bin.
  /// Número de tareas enviadas a papelera exitosamente.
  final int deletedCount;

  /// Number of failed move-to-bin operations.
  /// Número de operaciones fallidas al enviar a papelera.
  final int failedCount;

  /// Error message if move-to-bin failed.
  /// Mensaje de error si falló el envío a papelera.
  final String? errorMessage;

  const DeleteTaskState({
    this.taskIdsToDelete = const [],
    this.isDeleting = false,
    this.deletedCount = 0,
    this.failedCount = 0,
    this.errorMessage,
    this.isSelectionMode = false,
  });

  /// Returns true if there are tasks selected to move to bin.
  /// Retorna true si hay tareas seleccionadas para enviar a papelera.
  bool get hasTasksToDelete => taskIdsToDelete.isNotEmpty;

  /// Returns the total number of tasks to move to bin.
  /// Retorna el número total de tareas a enviar a papelera.
  int get totalTasksToDelete => taskIdsToDelete.length;

  DeleteTaskState copyWith({
    List<String>? taskIdsToDelete,
    bool? isDeleting,
    int? deletedCount,
    int? failedCount,
    String? errorMessage,
    bool clearError = false,
    bool? isSelectionMode,
  }) {
    return DeleteTaskState(
      taskIdsToDelete: taskIdsToDelete ?? this.taskIdsToDelete,
      isDeleting: isDeleting ?? this.isDeleting,
      deletedCount: deletedCount ?? this.deletedCount,
      failedCount: failedCount ?? this.failedCount,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
    );
  }
}

/// Notifier that manages moving tasks to bin (isBin: true). Maintains a list
/// of task IDs and executes move-to-bin via updateTask(isBin: true).
///
/// Notifier que gestiona el envío de tareas a papelera (isBin: true). Mantiene
/// una lista de IDs y ejecuta el cambio mediante updateTask(isBin: true).
@Riverpod(keepAlive: true)
class BinTaskLogicTasks extends _$BinTaskLogicTasks {
  @override
  DeleteTaskState build() => const DeleteTaskState();

  /// Enables selection mode.
  /// Habilita el modo selección.
  void enableSelectionMode() {
    state = state.copyWith(isSelectionMode: true);
  }

  /// Disables selection mode.
  /// Deshabilita el modo selección.
  void disableSelectionMode() {
    state = state.copyWith(isSelectionMode: false, taskIdsToDelete: const []);
  }

  /// Adds a task ID to the move-to-bin list. If the ID is already in the list,
  /// it won't be added again.
  ///
  /// Añade un ID de tarea a la lista para enviar a papelera. Si el ID ya está
  /// en la lista, no se añadirá de nuevo.
  ///
  /// [taskId] Task ID to add. / ID de tarea a añadir.
  void addTaskToDelete(String taskId) {
    if (state.taskIdsToDelete.contains(taskId)) {
      return;
    }
    state = state.copyWith(
      taskIdsToDelete: [...state.taskIdsToDelete, taskId],
      clearError: true,
    );
  }

  /// Removes a task ID from the move-to-bin list.
  ///
  /// Quita un ID de tarea de la lista para enviar a papelera.
  ///
  /// [taskId] Task ID to remove. / ID de tarea a quitar.
  void removeTaskFromDelete(String taskId) {
    if (!state.taskIdsToDelete.contains(taskId)) {
      return;
    }
    state = state.copyWith(
      taskIdsToDelete: state.taskIdsToDelete
          .where((String id) => id != taskId)
          .toList(),
      clearError: true,
    );
  }

  /// Adds multiple task IDs to the move-to-bin list.
  ///
  /// Añade múltiples IDs de tareas a la lista para enviar a papelera.
  ///
  /// [taskIds] List of task IDs to add. / Lista de IDs de tareas a añadir.
  void addTasksToDelete(List<String> taskIds) {
    final Set<String> currentIds = state.taskIdsToDelete.toSet();
    currentIds.addAll(taskIds);
    state = state.copyWith(
      taskIdsToDelete: currentIds.toList(),
      clearError: true,
    );
  }

  /// Removes multiple task IDs from the move-to-bin list.
  ///
  /// Quita múltiples IDs de tareas de la lista para enviar a papelera.
  ///
  /// [taskIds] List of task IDs to remove. / Lista de IDs de tareas a quitar.
  void removeTasksFromDelete(List<String> taskIds) {
    final Set<String> taskIdsSet = taskIds.toSet();
    state = state.copyWith(
      taskIdsToDelete: state.taskIdsToDelete
          .where((String id) => !taskIdsSet.contains(id))
          .toList(),
      clearError: true,
    );
  }

  /// Checks if a task ID is in the move-to-bin list.
  ///
  /// Verifica si un ID de tarea está en la lista para enviar a papelera.
  ///
  /// [taskId] Task ID to check. / ID de tarea a verificar.
  ///
  /// Returns true if the task ID is in the list.
  /// Retorna true si el ID de tarea está en la lista.
  bool isTaskSelectedForDelete(String taskId) {
    return state.taskIdsToDelete.contains(taskId);
  }

  /// Clears all task IDs from the move-to-bin list.
  ///
  /// Limpia todos los IDs de tareas de la lista para enviar a papelera.
  void clearTasksToDelete() {
    state = state.copyWith(taskIdsToDelete: const [], clearError: true);
  }

  /// Moves all tasks in the list to bin (sets isBin to true). Loads each task
  /// by id, updates it with isBin: true, and tracks success/failure counts.
  ///
  /// Envía a papelera todas las tareas de la lista (pone isBin en true). Carga
  /// cada tarea por id, la actualiza con isBin: true y rastrea éxitos/fallos.
  ///
  /// Returns the number of tasks successfully moved to bin.
  /// Retorna el número de tareas enviadas a papelera exitosamente.
  ///
  /// Throws [DeleteTaskException] if all move-to-bin operations fail or list is empty.
  /// Lanza [DeleteTaskException] si todas las operaciones fallan o la lista está vacía.
  Future<int> executeDeletion() async {
    if (state.taskIdsToDelete.isEmpty) {
      throw const DeleteTaskException(
        message: 'No tasks selected to move to bin',
        errorCode: 'EMPTY_LIST',
      );
    }

    if (!ref.mounted) {
      throw const DeleteTaskException(
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

    int movedCount = 0;
    int failedCount = 0;
    String? lastError;
    final List<String> idsToProcess = List<String>.from(state.taskIdsToDelete);

    final tasksNotifier = ref.read(tasksLogicSharedProvider.notifier);

    for (final String taskId in idsToProcess) {
      if (!ref.mounted) {
        throw const DeleteTaskException(
          message: 'Provider disposed during move to bin',
          errorCode: 'UNMOUNTED',
        );
      }

      try {
        final TaskDataRule? data = await tasksNotifier.getTaskById(id: taskId);
        if (data == null) {
          failedCount++;
          lastError = 'Task not found';
        } else {
          final TaskDataRule updated = data.copyWith(isBin: true);
          await tasksNotifier.updateTask(task: updated);
          movedCount++;
        }
      } on ListTasksLogicException catch (e) {
        failedCount++;
        lastError = e.message;
      } catch (e) {
        failedCount++;
        lastError = e.toString();
      }

      if (ref.mounted) {
        state = state.copyWith(
          deletedCount: movedCount,
          failedCount: failedCount,
          errorMessage: lastError,
        );
      }
    }

    if (!ref.mounted) {
      throw const DeleteTaskException(
        message: 'Provider disposed',
        errorCode: 'UNMOUNTED',
      );
    }

    state = state.copyWith(
      isDeleting: false,
      deletedCount: movedCount,
      failedCount: failedCount,
      errorMessage: failedCount > 0 ? lastError : null,
    );

    if (failedCount == idsToProcess.length) {
      throw DeleteTaskException(
        message: lastError ?? 'All move-to-bin operations failed',
        errorCode: 'ALL_FAILED',
      );
    }

    if (movedCount > 0) {
      state = state.copyWith(taskIdsToDelete: const []);
    }

    return movedCount;
  }

  /// Resets the move-to-bin state to initial values.
  ///
  /// Reinicia el estado de envío a papelera a los valores iniciales.
  void reset() {
    if (ref.mounted) {
      state = const DeleteTaskState();
    }
  }
}

/// Exception thrown when move-to-bin fails.
/// Excepción lanzada cuando falla el envío a papelera.
class DeleteTaskException implements Exception {
  const DeleteTaskException({required this.message, this.errorCode});

  final String message;
  final String? errorCode;

  @override
  String toString() => 'DeleteTaskException($message, $errorCode)';
}

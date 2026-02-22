import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager_pro/core/core.dart'
    show TaskConsumerRule, TaskDataRule, ApiResponseRule, Unit;
import 'package:task_manager_pro/interface/shared/shared.dart'
    show taskConsumerProvider;

part 'tasks_logic_shared.g.dart';

// ═══════════════════════════════════════════════════════════════════════════
// TASKS LOGIC SHARED (AsyncNotifier)
// ═══════════════════════════════════════════════════════════════════════════

/// Notifier that loads and holds the list of tasks and exposes CRUD operations.
/// Notifier que carga y mantiene la lista de tareas y expone operaciones CRUD.
@Riverpod(keepAlive: true)
class TasksLogicShared extends _$TasksLogicShared {
  late final TaskConsumerRule _consumer = ref.read(taskConsumerProvider);

  @override
  Future<List<TaskDataRule>> build() async {
    final ApiResponseRule<List<TaskDataRule>> response = await _consumer
        .loadTasks();
    return response.resolve(
      onSuccess: (List<TaskDataRule> data, String? _) => data,
      onFailure: (String message, String? errorCode) =>
          throw ListTasksLogicException(message: message, errorCode: errorCode),
    );
  }

  /// Reloads the task list from the consumer.
  /// Recarga la lista de tareas desde el consumer.
  Future<void> refresh() async {
    state = const AsyncLoading<List<TaskDataRule>>();
    state = await AsyncValue.guard(() => build());
  }

  /// Fetches a single task by id.
  /// Obtiene una tarea por id.
  ///
  /// [id] Unique task identifier. / Identificador único de la tarea.
  ///
  /// Returns the task or null if not found; throws on failure.
  /// Devuelve la tarea o null si no existe; lanza en fallo.
  Future<TaskDataRule?> getTaskById({required String id}) async {
    final ApiResponseRule<TaskDataRule?> response = await _consumer
        .loadTaskById(id: id);
    return response.resolve(
      onSuccess: (TaskDataRule? data, String? _) => data,
      onFailure: (String message, String? errorCode) =>
          throw ListTasksLogicException(message: message, errorCode: errorCode),
    );
  }

  /// Creates a new task and refreshes the list on success.
  /// Crea una nueva tarea y actualiza la lista en éxito.
  ///
  /// [task] Task data to create. / Datos de la tarea a crear.
  ///
  /// Returns the created task. / Devuelve la tarea creada.
  Future<TaskDataRule> addTask({required TaskDataRule task}) async {
    final ApiResponseRule<TaskDataRule> response = await _consumer.addTask(
      task: task,
    );
    final created = response.resolve(
      onSuccess: (TaskDataRule data, String? _) => data,
      onFailure: (String message, String? errorCode) =>
          throw ListTasksLogicException(message: message, errorCode: errorCode),
    );
    await refresh();
    return created;
  }

  /// Updates an existing task and refreshes the list on success.
  /// Actualiza una tarea existente y actualiza la lista en éxito.
  ///
  /// [task] Task data with updated values. / Datos de la tarea actualizados.
  ///
  /// Returns the updated task. / Devuelve la tarea actualizada.
  Future<TaskDataRule> updateTask({required TaskDataRule task}) async {
    final ApiResponseRule<TaskDataRule> response = await _consumer.updateTask(
      task: task,
    );
    final updated = response.resolve(
      onSuccess: (TaskDataRule data, String? _) => data,
      onFailure: (String message, String? errorCode) =>
          throw ListTasksLogicException(message: message, errorCode: errorCode),
    );
    await refresh();
    return updated;
  }

  /// Deletes a task by id and refreshes the list on success.
  /// Elimina una tarea por id y actualiza la lista en éxito.
  ///
  /// [id] Unique task identifier. / Identificador único de la tarea.
  Future<void> deleteTask({required String id}) async {
    final ApiResponseRule<Unit> response = await _consumer.deleteTask(id: id);
    response.resolve(
      onSuccess: (Unit _, String? _) => null,
      onFailure: (String message, String? errorCode) =>
          throw ListTasksLogicException(message: message, errorCode: errorCode),
    );
    await refresh();
  }
}

/// Exception thrown when task list loading or CRUD operations fail.
/// Excepción lanzada cuando falla la carga de tareas o las operaciones CRUD.
class ListTasksLogicException implements Exception {
  const ListTasksLogicException({required this.message, this.errorCode});

  final String message;
  final String? errorCode;

  @override
  String toString() => 'ListTasksLogicException($message, $errorCode)';
}

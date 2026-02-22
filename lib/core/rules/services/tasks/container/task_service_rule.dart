import 'package:task_manager_pro/core/rules/data/data_rules.dart';
import 'package:task_manager_pro/core/rules/responses/responses_rules.dart';

/// Contract for task services.
/// Contrato para servicios de tareas.
abstract class TaskServiceRule {
  /// Fetches all tasks.
  /// Obtiene todas las tareas.
  ///
  /// Returns a response containing the list of tasks or an error message.
  /// Devuelve una respuesta con la lista de tareas o un mensaje de error.
  Future<ApiResponseRule<List<TaskDataRule>>> getTasks();

  /// Fetches a single task by id.
  /// Obtiene una tarea por id.
  ///
  /// [id] Unique task identifier. / Identificador único de la tarea.
  ///
  /// Returns a response with the task or null if not found.
  /// Devuelve una respuesta con la tarea o null si no existe.
  Future<ApiResponseRule<TaskDataRule?>> getTaskById({required String id});

  /// Creates a new task.
  /// Crea una nueva tarea.
  ///
  /// [task] Task data to persist. / Datos de la tarea a persistir.
  ///
  /// Returns a response with the created task or an error message.
  /// Devuelve una respuesta con la tarea creada o un mensaje de error.
  Future<ApiResponseRule<TaskDataRule>> createTask({
    required TaskDataRule task,
  });

  /// Updates an existing task.
  /// Actualiza una tarea existente.
  ///
  /// [task] Task data with updated values. / Datos de la tarea con valores actualizados.
  ///
  /// Returns a response with the updated task or an error message.
  /// Devuelve una respuesta con la tarea actualizada o un mensaje de error.
  Future<ApiResponseRule<TaskDataRule>> updateTask({
    required TaskDataRule task,
  });

  /// Deletes a task by id.
  /// Elimina una tarea por id.
  ///
  /// [id] Unique task identifier. / Identificador único de la tarea.
  ///
  /// Returns a response indicating success or failure.
  /// Devuelve una respuesta indicando éxito o fallo.
  Future<ApiResponseRule<Unit>> deleteTask({required String id});
}

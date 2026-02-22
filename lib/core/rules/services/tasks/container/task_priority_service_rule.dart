import 'package:task_manager_pro/core/rules/data/data_rules.dart';
import 'package:task_manager_pro/core/rules/responses/responses_rules.dart';

abstract class TaskPriorityServiceRule {
  /// Fetches all task priorities.
  /// Obtiene todas las prioridades de tarea.
  ///
  /// Returns a response containing the list of task priorities or an error message.
  /// Devuelve una respuesta con la lista de prioridades de tarea o un mensaje de error.
  Future<ApiResponseRule<List<TaskPriorityDataRule>>> getTaskPriorities();

  /// Fetches a single task priority by id.
  /// Obtiene una prioridad de tarea por id.
  ///
  /// [id] Unique task priority identifier. / Identificador único de la prioridad de tarea.
  ///
  /// Returns a response with the task priority or null if not found.
  /// Devuelve una respuesta con la prioridad de tarea o null si no existe.
  Future<ApiResponseRule<TaskPriorityDataRule?>> getTaskPriorityById({
    required String id,
  });

  /// Creates a new task priority.
  /// Crea una nueva prioridad de tarea.
  ///
  /// [taskPriority] Task priority data to persist. / Datos de la prioridad a persistir.
  ///
  /// Returns a response with the created task priority or an error message.
  /// Devuelve una respuesta con la prioridad creada o un mensaje de error.
  Future<ApiResponseRule<TaskPriorityDataRule>> createTaskPriority({
    required TaskPriorityDataRule taskPriority,
  });

  /// Updates an existing task priority.
  /// Actualiza una prioridad de tarea existente.
  ///
  /// [taskPriority] Task priority data with updated values. / Datos con valores actualizados.
  ///
  /// Returns a response with the updated task priority or an error message.
  /// Devuelve una respuesta con la prioridad actualizada o un mensaje de error.
  Future<ApiResponseRule<TaskPriorityDataRule>> updateTaskPriority({
    required TaskPriorityDataRule taskPriority,
  });

  /// Deletes a task priority by id.
  /// Elimina una prioridad de tarea por id.
  ///
  /// [id] Unique task priority identifier. / Identificador único de la prioridad de tarea.
  ///
  /// Returns a response indicating success or failure.
  /// Devuelve una respuesta indicando éxito o fallo.
  Future<ApiResponseRule<Unit>> deleteTaskPriority({required String id});
}

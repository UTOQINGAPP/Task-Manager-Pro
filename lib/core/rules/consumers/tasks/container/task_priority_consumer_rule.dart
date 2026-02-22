import 'package:task_manager_pro/core/rules/data/data_rules.dart';
import 'package:task_manager_pro/core/rules/responses/responses_rules.dart';

abstract class TaskPriorityConsumerRule {
  /// Loads all task priorities and returns a response.
  /// Carga todas las prioridades de tarea y devuelve una respuesta.
  Future<ApiResponseRule<List<TaskPriorityDataRule>>> loadTaskPriorities();

  /// Loads a single task priority by id.
  /// Carga una prioridad de tarea por id.
  ///
  /// [id] Unique task priority identifier. / Identificador único de la prioridad de tarea.
  Future<ApiResponseRule<TaskPriorityDataRule?>> loadTaskPriorityById({
    required String id,
  });

  /// Adds a new task priority.
  /// Añade una nueva prioridad de tarea.
  ///
  /// [taskPriority] Task priority data to create. / Datos de la prioridad a crear.
  Future<ApiResponseRule<TaskPriorityDataRule>> addTaskPriority({
    required TaskPriorityDataRule taskPriority,
  });

  /// Updates an existing task priority.
  /// Actualiza una prioridad de tarea existente.
  ///
  /// [taskPriority] Task priority data with updated values. / Datos de la prioridad actualizados.
  Future<ApiResponseRule<TaskPriorityDataRule>> updateTaskPriority({
    required TaskPriorityDataRule taskPriority,
  });

  /// Deletes a task priority by id.
  /// Elimina una prioridad de tarea por id.
  ///
  /// [id] Unique task priority identifier. / Identificador único de la prioridad de tarea.
  Future<ApiResponseRule<Unit>> deleteTaskPriority({required String id});
}

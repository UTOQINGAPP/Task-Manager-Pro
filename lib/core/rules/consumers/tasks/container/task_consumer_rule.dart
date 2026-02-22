import 'package:task_manager_pro/core/rules/data/data_rules.dart';
import 'package:task_manager_pro/core/rules/responses/responses_rules.dart';

/// Contract for task consumers.
/// Contrato para consumers de tareas.
abstract class TaskConsumerRule {
  /// Loads all tasks and returns a response.
  /// Carga todas las tareas y devuelve una respuesta.
  Future<ApiResponseRule<List<TaskDataRule>>> loadTasks();

  /// Loads a single task by id.
  /// Carga una tarea por id.
  ///
  /// [id] Unique task identifier. / Identificador único de la tarea.
  Future<ApiResponseRule<TaskDataRule?>> loadTaskById({required String id});

  /// Adds a new task.
  /// Añade una nueva tarea.
  ///
  /// [task] Task data to create. / Datos de la tarea a crear.
  Future<ApiResponseRule<TaskDataRule>> addTask({required TaskDataRule task});

  /// Updates an existing task.
  /// Actualiza una tarea existente.
  ///
  /// [task] Task data with updated values. / Datos de la tarea actualizados.
  Future<ApiResponseRule<TaskDataRule>> updateTask({
    required TaskDataRule task,
  });

  /// Deletes a task by id.
  /// Elimina una tarea por id.
  ///
  /// [id] Unique task identifier. / Identificador único de la tarea.
  Future<ApiResponseRule<Unit>> deleteTask({required String id});

  /// Toggles the completed state of a task.
  /// Cambia el estado de completado de una tarea.
  ///
  /// [id] Unique task identifier. / Identificador único de la tarea.
  /// [isCompleted] New completed state. / Nuevo estado de completado.
  Future<ApiResponseRule<TaskDataRule>> setTaskCompleted({
    required String id,
    required bool isCompleted,
  });
}

import 'package:task_manager_pro/core/rules/data/data_rules.dart';
import 'package:task_manager_pro/core/rules/responses/responses_rules.dart';

abstract class TaskCategoryServiceRule {
  /// Fetches all task categories.
  /// Obtiene todas las categorías de tarea.
  ///
  /// Returns a response containing the list of task categories or an error message.
  /// Devuelve una respuesta con la lista de categorías de tarea o un mensaje de error.
  Future<ApiResponseRule<List<TaskCategoryDataRule>>> getTaskCategories();

  /// Fetches a single task category by id.
  /// Obtiene una categoría de tarea por id.
  ///
  /// [id] Unique task category identifier. / Identificador único de la categoría de tarea.
  ///
  /// Returns a response with the task category or null if not found.
  /// Devuelve una respuesta con la categoría de tarea o null si no existe.
  Future<ApiResponseRule<TaskCategoryDataRule?>> getTaskCategoryById({
    required String id,
  });

  /// Creates a new task category.
  /// Crea una nueva categoría de tarea.
  ///
  /// [taskCategory] Task category data to persist. / Datos de la categoría a persistir.
  ///
  /// Returns a response with the created task category or an error message.
  /// Devuelve una respuesta con la categoría creada o un mensaje de error.
  Future<ApiResponseRule<TaskCategoryDataRule>> createTaskCategory({
    required TaskCategoryDataRule taskCategory,
  });

  /// Updates an existing task category.
  /// Actualiza una categoría de tarea existente.
  ///
  /// [taskCategory] Task category data with updated values. / Datos con valores actualizados.
  ///
  /// Returns a response with the updated task category or an error message.
  /// Devuelve una respuesta con la categoría actualizada o un mensaje de error.
  Future<ApiResponseRule<TaskCategoryDataRule>> updateTaskCategory({
    required TaskCategoryDataRule taskCategory,
  });

  /// Deletes a task category by id.
  /// Elimina una categoría de tarea por id.
  ///
  /// [id] Unique task category identifier. / Identificador único de la categoría de tarea.
  ///
  /// Returns a response indicating success or failure.
  /// Devuelve una respuesta indicando éxito o fallo.
  Future<ApiResponseRule<Unit>> deleteTaskCategory({required String id});
}

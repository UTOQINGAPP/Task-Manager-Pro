import 'package:task_manager_pro/core/rules/data/data_rules.dart';
import 'package:task_manager_pro/core/rules/responses/responses_rules.dart';

abstract class TaskCategoryConsumerRule {
  /// Loads all task categories and returns a response.
  /// Carga todas las categorías de tarea y devuelve una respuesta.
  Future<ApiResponseRule<List<TaskCategoryDataRule>>> loadTaskCategories();

  /// Loads a single task category by id.
  /// Carga una categoría de tarea por id.
  ///
  /// [id] Unique task category identifier. / Identificador único de la categoría de tarea.
  Future<ApiResponseRule<TaskCategoryDataRule?>> loadTaskCategoryById({
    required String id,
  });

  /// Adds a new task category.
  /// Añade una nueva categoría de tarea.
  ///
  /// [taskCategory] Task category data to create. / Datos de la categoría a crear.
  Future<ApiResponseRule<TaskCategoryDataRule>> addTaskCategory({
    required TaskCategoryDataRule taskCategory,
  });

  /// Updates an existing task category.
  /// Actualiza una categoría de tarea existente.
  ///
  /// [taskCategory] Task category data with updated values. / Datos de la categoría actualizados.
  Future<ApiResponseRule<TaskCategoryDataRule>> updateTaskCategory({
    required TaskCategoryDataRule taskCategory,
  });

  /// Deletes a task category by id.
  /// Elimina una categoría de tarea por id.
  ///
  /// [id] Unique task category identifier. / Identificador único de la categoría de tarea.
  Future<ApiResponseRule<Unit>> deleteTaskCategory({required String id});
}

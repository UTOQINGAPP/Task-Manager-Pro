import 'package:task_manager_pro/core/infra/database/app_database/app_database.dart'
    show TaskCategory;

/// Origin for task category. One variable holding the Drift row as it arrives.
/// Origen de categoría de tarea. Una variable con la fila Drift tal cual llega.
class TaskCategoryOriginUse {
  final TaskCategory value;

  const TaskCategoryOriginUse(this.value);
}

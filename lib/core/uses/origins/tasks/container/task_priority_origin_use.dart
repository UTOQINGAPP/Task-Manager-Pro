import 'package:task_manager_pro/core/infra/database/app_database/app_database.dart'
    show TaskPriority;

/// Origin for task priority. One variable holding the Drift row as it arrives.
/// Origen de prioridad de tarea. Una variable con la fila Drift tal cual llega.
class TaskPriorityOriginUse {
  final TaskPriority value;

  const TaskPriorityOriginUse(this.value);
}

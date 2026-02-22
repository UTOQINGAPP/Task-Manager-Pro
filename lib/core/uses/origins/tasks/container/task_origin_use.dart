import 'package:task_manager_pro/core/infra/database/app_database/app_database.dart'
    show Task;

/// Origin for task. One variable holding the Drift row as it arrives.
/// Origen de tarea. Una variable con la fila Drift tal cual llega.
class TaskOriginUse {
  final Task value;

  const TaskOriginUse(this.value);
}

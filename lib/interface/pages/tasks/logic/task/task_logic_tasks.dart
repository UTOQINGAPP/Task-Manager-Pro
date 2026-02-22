import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager_pro/core/core.dart' show TaskDataRule;
import 'package:task_manager_pro/interface/shared/shared.dart'
    show tasksLogicSharedProvider, ListTasksLogicException;

part 'task_logic_tasks.g.dart';

// ═══════════════════════════════════════════════════════════════════════════
// TASK BY ID LOGIC (family provider)
// ═══════════════════════════════════════════════════════════════════════════

/// Loads a single task by id. Pass empty string for create mode (returns null).
/// Carga una tarea por id. Pasar cadena vacía en modo crear (devuelve null).
@riverpod
Future<TaskDataRule?> taskById(Ref ref, String id) async {
  if (id.isEmpty) return null;
  try {
    return await ref
        .read(tasksLogicSharedProvider.notifier)
        .getTaskById(id: id);
  } on ListTasksLogicException catch (e) {
    throw TaskByIdException(message: e.message, errorCode: e.errorCode);
  }
}

/// Exception thrown when loading a task by id fails.
/// Excepción lanzada cuando falla la carga de la tarea por id.
class TaskByIdException implements Exception {
  const TaskByIdException({required this.message, this.errorCode});

  final String message;
  final String? errorCode;

  @override
  String toString() => 'TaskByIdException($message, $errorCode)';
}

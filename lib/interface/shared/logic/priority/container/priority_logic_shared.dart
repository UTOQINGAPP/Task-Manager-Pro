import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager_pro/core/core.dart'
    show TaskPriorityConsumerRule, TaskPriorityDataRule, ApiResponseRule;
import 'package:task_manager_pro/interface/shared/shared.dart'
    show taskPriorityConsumerProvider;

part 'priority_logic_shared.g.dart';

// ═══════════════════════════════════════════════════════════════════════════
// LIST PRIORITIES LOGIC (AsyncNotifier)
// ═══════════════════════════════════════════════════════════════════════════

/// Notifier that loads and holds the list of task priorities from core.
/// Notifier que carga y mantiene la lista de prioridades de tarea desde core.
@riverpod
class PriorityLogicShared extends _$PriorityLogicShared {
  late final TaskPriorityConsumerRule _consumer = ref.read(
    taskPriorityConsumerProvider,
  );

  @override
  Future<List<TaskPriorityDataRule>> build() async {
    final ApiResponseRule<List<TaskPriorityDataRule>> response = await _consumer
        .loadTaskPriorities();
    return response.resolve(
      onSuccess: (List<TaskPriorityDataRule> data, String? _) => data,
      onFailure: (String message, String? errorCode) =>
          throw ListPrioritiesException(message: message, errorCode: errorCode),
    );
  }

  /// Reloads the priority list from core.
  /// Recarga la lista de prioridades desde core.
  Future<void> refresh() async {
    state = const AsyncLoading<List<TaskPriorityDataRule>>();
    state = await AsyncValue.guard(() => build());
  }
}

/// Exception thrown when loading the priority list fails.
/// Excepción lanzada cuando falla la carga de la lista de prioridades.
class ListPrioritiesException implements Exception {
  const ListPrioritiesException({required this.message, this.errorCode});

  final String message;
  final String? errorCode;

  @override
  String toString() => 'ListPrioritiesException($message, $errorCode)';
}

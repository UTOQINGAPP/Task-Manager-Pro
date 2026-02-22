import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager_pro/core/core.dart'
    show TaskCategoryConsumerRule, TaskCategoryDataRule, ApiResponseRule;
import 'package:task_manager_pro/interface/shared/shared.dart'
    show taskCategoryConsumerProvider;

part 'category_logic_shared.g.dart';

// ═══════════════════════════════════════════════════════════════════════════
// LIST CATEGORIES LOGIC (AsyncNotifier)
// ═══════════════════════════════════════════════════════════════════════════

/// Notifier that loads and holds the list of task categories from core.
/// Notifier que carga y mantiene la lista de categorías de tarea desde core.
@riverpod
class CategoryLogicShared extends _$CategoryLogicShared {
  late final TaskCategoryConsumerRule _consumer = ref.read(
    taskCategoryConsumerProvider,
  );

  @override
  Future<List<TaskCategoryDataRule>> build() async {
    final ApiResponseRule<List<TaskCategoryDataRule>> response = await _consumer
        .loadTaskCategories();
    return response.resolve(
      onSuccess: (List<TaskCategoryDataRule> data, String? _) => data,
      onFailure: (String message, String? errorCode) =>
          throw ListCategoriesException(message: message, errorCode: errorCode),
    );
  }

  /// Reloads the category list from core.
  /// Recarga la lista de categorías desde core.
  Future<void> refresh() async {
    state = const AsyncLoading<List<TaskCategoryDataRule>>();
    state = await AsyncValue.guard(() => build());
  }
}

/// Exception thrown when loading the category list fails.
/// Excepción lanzada cuando falla la carga de la lista de categorías.
class ListCategoriesException implements Exception {
  const ListCategoriesException({required this.message, this.errorCode});

  final String message;
  final String? errorCode;

  @override
  String toString() => 'ListCategoriesException($message, $errorCode)';
}

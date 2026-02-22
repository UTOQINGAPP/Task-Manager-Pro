// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_logic_shared.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier that loads and holds the list of task categories from core.
/// Notifier que carga y mantiene la lista de categorías de tarea desde core.

@ProviderFor(CategoryLogicShared)
final categoryLogicSharedProvider = CategoryLogicSharedProvider._();

/// Notifier that loads and holds the list of task categories from core.
/// Notifier que carga y mantiene la lista de categorías de tarea desde core.
final class CategoryLogicSharedProvider
    extends
        $AsyncNotifierProvider<
          CategoryLogicShared,
          List<TaskCategoryDataRule>
        > {
  /// Notifier that loads and holds the list of task categories from core.
  /// Notifier que carga y mantiene la lista de categorías de tarea desde core.
  CategoryLogicSharedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryLogicSharedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryLogicSharedHash();

  @$internal
  @override
  CategoryLogicShared create() => CategoryLogicShared();
}

String _$categoryLogicSharedHash() =>
    r'15e94ebc874c9a0eed2e790a40375a1adbfc9b1c';

/// Notifier that loads and holds the list of task categories from core.
/// Notifier que carga y mantiene la lista de categorías de tarea desde core.

abstract class _$CategoryLogicShared
    extends $AsyncNotifier<List<TaskCategoryDataRule>> {
  FutureOr<List<TaskCategoryDataRule>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<TaskCategoryDataRule>>,
              List<TaskCategoryDataRule>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TaskCategoryDataRule>>,
                List<TaskCategoryDataRule>
              >,
              AsyncValue<List<TaskCategoryDataRule>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

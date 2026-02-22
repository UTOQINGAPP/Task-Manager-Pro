import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager_pro/core/core.dart' show TaskCategoryDataRule;
import 'package:task_manager_pro/interface/shared/shared.dart'
    show categoryLogicSharedProvider;

import '../helper/test_container_helper.dart';

/// Unit tests for [CategoryLogicShared]: load categories and refresh.
/// Pruebas unitarias para [CategoryLogicShared]: carga de categorías y refresh.
void main() {
  setUpAll(WidgetsFlutterBinding.ensureInitialized);

  group('CategoryLogicShared', () {
    late ProviderContainer container;

    setUp(() {
      container = createTestContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('build returns a list of TaskCategoryDataRule', () async {
      final list = await container.read(categoryLogicSharedProvider.future);
      expect(list, isA<List<TaskCategoryDataRule>>());
      for (final item in list) {
        expect(item.id, isNotEmpty);
        expect(item.name, isNotEmpty);
      }
    });

    test('refresh reloads categories', () async {
      final notifier = container.read(categoryLogicSharedProvider.notifier);
      await notifier.refresh();
      final state = container.read(categoryLogicSharedProvider);
      expect(state.hasValue, isTrue);
      expect(state.value, isA<List<TaskCategoryDataRule>>());
    });
  });
}

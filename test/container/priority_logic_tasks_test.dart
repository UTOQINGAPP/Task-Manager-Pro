import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:task_manager_pro/core/core.dart' show TaskPriorityDataRule;
import 'package:task_manager_pro/interface/shared/shared.dart'
    show priorityLogicSharedProvider;

import '../helper/test_container_helper.dart';

/// Unit tests for [PriorityLogicShared]: load priorities and refresh.
/// Pruebas unitarias para [PriorityLogicShared]: carga de prioridades y refresh.
void main() {
  setUpAll(WidgetsFlutterBinding.ensureInitialized);

  group('PriorityLogicShared', () {
    late ProviderContainer container;

    setUp(() {
      container = createTestContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('build returns a list of TaskPriorityDataRule', () async {
      final list = await container.read(priorityLogicSharedProvider.future);
      expect(list, isA<List<TaskPriorityDataRule>>());
      for (final item in list) {
        expect(item.id, isNotEmpty);
        expect(item.name, isNotEmpty);
      }
    });

    test('refresh reloads priorities', () async {
      final notifier = container.read(priorityLogicSharedProvider.notifier);
      await notifier.refresh();
      final state = container.read(priorityLogicSharedProvider);
      expect(state.hasValue, isTrue);
      expect(state.value, isA<List<TaskPriorityDataRule>>());
    });
  });
}

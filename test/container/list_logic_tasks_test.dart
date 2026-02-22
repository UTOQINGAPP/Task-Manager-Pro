import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:task_manager_pro/core/core.dart';
import 'package:task_manager_pro/interface/pages/tasks/logic/list/list_logic_tasks.dart';

import '../helper/test_container_helper.dart';

/// Unit tests for [ListLogicTasks] state transitions (search, filter, clearFilters).
/// Uses [createTestContainer] for service fakes.
///
/// Pruebas unitarias para transiciones de estado de [ListLogicTasks].
void main() {
  setUpAll(WidgetsFlutterBinding.ensureInitialized);

  group('ListLogicTasks', () {
    late ProviderContainer container;

    setUp(() {
      container = createTestContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test(
      'build returns TaskListState with allTasks and visibleTasks',
      () async {
        final state = await container.read(listLogicTasksProvider.future);
        expect(state, isA<TaskListState>());
        expect(state.allTasks, isA<List<TaskDataRule>>());
        expect(state.visibleTasks, isA<List<TaskDataRule>>());
        expect(
          state.visibleTasks.length,
          lessThanOrEqualTo(state.allTasks.length),
        );
        expect(state.query, isEmpty);
        expect(state.category, isNull);
        expect(state.priority, isNull);
        expect(state.isCompleted, isNull);
      },
    );

    test(
      'search with empty query shows all tasks (via clearFilters)',
      () async {
        await container.read(listLogicTasksProvider.future);
        final notifier = container.read(listLogicTasksProvider.notifier);
        notifier.search('some query');
        final afterSearch = container.read(listLogicTasksProvider).value!;
        expect(afterSearch.query, 'some query');

        notifier.search('');
        final afterEmpty = container.read(listLogicTasksProvider).value!;
        expect(afterEmpty.query, isEmpty);
        expect(afterEmpty.visibleTasks.length, afterEmpty.allTasks.length);
      },
    );

    test(
      'clearFilters resets query, category, priority and isCompleted',
      () async {
        await container.read(listLogicTasksProvider.future);
        final notifier = container.read(listLogicTasksProvider.notifier);
        final cat = TaskCategoryDataRule(
          id: 'cat_1',
          name: 'Cat',
          color: 0xFF000000,
          createdAt: 0,
        );
        final pri = TaskPriorityDataRule(
          id: 'pri_1',
          name: 'Pri',
          color: 0xFF000000,
          sortOrder: 0,
          createdAt: 0,
        );
        notifier.filter(category: cat, priority: pri, isCompleted: true);
        var state = container.read(listLogicTasksProvider).value!;
        expect(state.category, isNotNull);
        expect(state.priority, isNotNull);
        expect(state.isCompleted, isTrue);

        notifier.clearFilters();
        state = container.read(listLogicTasksProvider).value!;
        expect(state.query, isEmpty);
        expect(state.category, isNull);
        expect(state.priority, isNull);
        expect(state.isCompleted, isNull);
        expect(state.visibleTasks.length, state.allTasks.length);
      },
    );

    test('filter by category updates visibleTasks', () async {
      await container.read(listLogicTasksProvider.future);
      final initialState = container.read(listLogicTasksProvider).value!;
      if (initialState.allTasks.isEmpty) return;

      final firstCategoryId = initialState.allTasks.first.taskCategoryId;
      final cat = TaskCategoryDataRule(
        id: firstCategoryId,
        name: 'Test',
        color: 0xFF000000,
        createdAt: 0,
      );
      container.read(listLogicTasksProvider.notifier).filter(category: cat);
      final state = container.read(listLogicTasksProvider).value!;
      expect(state.category?.id, firstCategoryId);
      for (final task in state.visibleTasks) {
        expect(task.taskCategoryId, firstCategoryId);
      }
    });

    test('refresh reloads state', () async {
      final notifier = container.read(listLogicTasksProvider.notifier);
      await notifier.refresh();
      final state = container.read(listLogicTasksProvider).value;
      expect(state, isNotNull);
    });
  });
}

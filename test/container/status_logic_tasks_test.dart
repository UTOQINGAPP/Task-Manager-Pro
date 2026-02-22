import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:task_manager_pro/core/core.dart';
import 'package:task_manager_pro/interface/pages/tasks/logic/status/status_logic_tasks.dart';

import '../helper/test_container_helper.dart';

/// Unit tests for [StatusLogicTasks] and [TaskStatusState]: build, refresh, updateFromTasks.
/// Pruebas unitarias para [StatusLogicTasks] y [TaskStatusState].
void main() {
  setUpAll(WidgetsFlutterBinding.ensureInitialized);

  group('TaskStatusState', () {
    test('fromTasks with empty list returns zero counts', () {
      final state = TaskStatusState.fromTasks([]);
      expect(state.totalTasks, 0);
      expect(state.completedTasks, 0);
      expect(state.pendingTasks, 0);
      expect(state.isEmpty, isTrue);
      expect(state.completionPercentage, 0.0);
    });

    test('fromTasks counts completed and pending', () {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final tasks = [
        TaskDataRule.create(
          title: 'A',
          taskCategoryId: 'c1',
          taskPriorityId: 'p1',
          dueDate: now + 3600,
        ),
        TaskDataRule.create(
          title: 'B',
          taskCategoryId: 'c1',
          taskPriorityId: 'p1',
          dueDate: now + 3600,
        ).copyWith(isCompleted: true),
      ];
      final state = TaskStatusState.fromTasks(tasks);
      expect(state.totalTasks, 2);
      expect(state.completedTasks, 1);
      expect(state.pendingTasks, 1);
      expect(state.completionPercentage, 0.5);
    });
  });

  group('StatusLogicTasks', () {
    late ProviderContainer container;

    setUp(() {
      container = createTestContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('build returns TaskStatusState', () async {
      final state = await container.read(statusLogicTasksProvider.future);
      expect(state, isA<TaskStatusState>());
      expect(state.totalTasks, greaterThanOrEqualTo(0));
      expect(state.completedTasks + state.pendingTasks, state.totalTasks);
    });

    test('refresh reloads state', () async {
      final notifier = container.read(statusLogicTasksProvider.notifier);
      await notifier.refresh();
      final state = container.read(statusLogicTasksProvider).value;
      expect(state, isNotNull);
    });

    test('updateFromTasks updates state from given list', () async {
      await container.read(statusLogicTasksProvider.future);
      final notifier = container.read(statusLogicTasksProvider.notifier);
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final tasks = [
        TaskDataRule.create(
          title: 'T1',
          taskCategoryId: 'c1',
          taskPriorityId: 'p1',
          dueDate: now + 3600,
        ),
        TaskDataRule.create(
          title: 'T2',
          taskCategoryId: 'c1',
          taskPriorityId: 'p1',
          dueDate: now + 3600,
        ).copyWith(isCompleted: true),
      ];
      notifier.updateFromTasks(tasks);
      final state = container.read(statusLogicTasksProvider).value!;
      expect(state.totalTasks, 2);
      expect(state.completedTasks, 1);
      expect(state.pendingTasks, 1);
    });
  });
}

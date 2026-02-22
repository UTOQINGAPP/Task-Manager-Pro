import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager_pro/interface/pages/tasks/logic/bin/bin_task_logic_tasks.dart';

import '../helper/test_container_helper.dart';

/// Unit tests for [BinTaskLogicTasks] state transitions.
/// Pruebas unitarias para las transiciones de estado de [BinTaskLogicTasks].
void main() {
  group('BinTaskLogicTasks', () {
    late ProviderContainer container;

    setUp(() {
      container = createTestContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test(
      'initial state has empty taskIdsToDelete and selection mode disabled',
      () {
        final state = container.read(binTaskLogicTasksProvider);
        expect(state.taskIdsToDelete, isEmpty);
        expect(state.isSelectionMode, isFalse);
        expect(state.totalTasksToDelete, 0);
        expect(state.hasTasksToDelete, isFalse);
      },
    );

    test('enableSelectionMode sets isSelectionMode to true', () {
      container.read(binTaskLogicTasksProvider.notifier).enableSelectionMode();
      final state = container.read(binTaskLogicTasksProvider);
      expect(state.isSelectionMode, isTrue);
    });

    test('disableSelectionMode clears selection and taskIdsToDelete', () {
      final notifier = container.read(binTaskLogicTasksProvider.notifier);
      notifier.enableSelectionMode();
      notifier.addTaskToDelete('id-1');
      notifier.disableSelectionMode();
      final state = container.read(binTaskLogicTasksProvider);
      expect(state.isSelectionMode, isFalse);
      expect(state.taskIdsToDelete, isEmpty);
    });

    test('addTaskToDelete adds a single task id', () {
      container
          .read(binTaskLogicTasksProvider.notifier)
          .addTaskToDelete('id-1');
      final state = container.read(binTaskLogicTasksProvider);
      expect(state.taskIdsToDelete, ['id-1']);
      expect(state.totalTasksToDelete, 1);
    });

    test('addTaskToDelete does not duplicate same id', () {
      final notifier = container.read(binTaskLogicTasksProvider.notifier);
      notifier.addTaskToDelete('id-1');
      notifier.addTaskToDelete('id-1');
      final state = container.read(binTaskLogicTasksProvider);
      expect(state.taskIdsToDelete, ['id-1']);
    });

    test('addTasksToDelete adds multiple ids', () {
      container.read(binTaskLogicTasksProvider.notifier).addTasksToDelete([
        'id-1',
        'id-2',
        'id-3',
      ]);
      final state = container.read(binTaskLogicTasksProvider);
      expect(state.taskIdsToDelete, containsAll(['id-1', 'id-2', 'id-3']));
      expect(state.totalTasksToDelete, 3);
    });

    test('removeTaskFromDelete removes one id', () {
      final notifier = container.read(binTaskLogicTasksProvider.notifier);
      notifier.addTasksToDelete(['id-1', 'id-2']);
      notifier.removeTaskFromDelete('id-1');
      final state = container.read(binTaskLogicTasksProvider);
      expect(state.taskIdsToDelete, ['id-2']);
    });

    test('removeTasksFromDelete removes multiple ids', () {
      final notifier = container.read(binTaskLogicTasksProvider.notifier);
      notifier.addTasksToDelete(['id-1', 'id-2', 'id-3']);
      notifier.removeTasksFromDelete(['id-1', 'id-3']);
      final state = container.read(binTaskLogicTasksProvider);
      expect(state.taskIdsToDelete, ['id-2']);
    });

    test('clearTasksToDelete empties the list', () {
      final notifier = container.read(binTaskLogicTasksProvider.notifier);
      notifier.addTasksToDelete(['id-1', 'id-2']);
      notifier.clearTasksToDelete();
      final state = container.read(binTaskLogicTasksProvider);
      expect(state.taskIdsToDelete, isEmpty);
    });

    test('isTaskSelectedForDelete returns true when id is in list', () {
      container
          .read(binTaskLogicTasksProvider.notifier)
          .addTaskToDelete('id-1');
      final notifier = container.read(binTaskLogicTasksProvider.notifier);
      expect(notifier.isTaskSelectedForDelete('id-1'), isTrue);
      expect(notifier.isTaskSelectedForDelete('id-2'), isFalse);
    });

    test('executeDeletion throws when list is empty', () async {
      expect(
        () => container
            .read(binTaskLogicTasksProvider.notifier)
            .executeDeletion(),
        throwsA(
          isA<DeleteTaskException>().having(
            (e) => e.errorCode,
            'errorCode',
            'EMPTY_LIST',
          ),
        ),
      );
    });

    test('reset restores initial state', () {
      final notifier = container.read(binTaskLogicTasksProvider.notifier);
      notifier.enableSelectionMode();
      notifier.addTaskToDelete('id-1');
      notifier.reset();
      final state = container.read(binTaskLogicTasksProvider);
      expect(state.taskIdsToDelete, isEmpty);
      expect(state.isSelectionMode, isFalse);
    });
  });
}

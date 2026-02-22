import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:task_manager_pro/interface/pages/tasks/logic/edit/edit_task_logic_tasks.dart';

import '../helper/test_container_helper.dart';

/// Unit tests for [EditTaskLogicTasks]: submit validation and not-found behaviour.
/// Pruebas unitarias para [EditTaskLogicTasks]: validación y tarea no encontrada.
void main() {
  setUpAll(WidgetsFlutterBinding.ensureInitialized);

  group('EditTaskLogicTasks', () {
    late ProviderContainer container;

    setUp(() {
      container = createTestContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('submit with empty taskId throws EditTaskException', () async {
      final notifier = container.read(editTaskLogicTasksProvider.notifier);
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      expect(
        () => notifier.submit(
          taskId: '',
          title: 'Title',
          taskCategoryId: 'cat_1',
          taskPriorityId: 'pri_1',
          dueDate: now + 3600,
        ),
        throwsA(isA<EditTaskException>()),
      );
    });
  });
}

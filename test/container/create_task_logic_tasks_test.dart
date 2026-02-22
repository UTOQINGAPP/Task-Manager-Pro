import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager_pro/interface/pages/tasks/logic/create/create_task_logic_tasks.dart';

import '../helper/test_container_helper.dart';

/// Unit tests for [CreateTaskLogicTasks] validation and error handling.
/// Pruebas unitarias para validación y manejo de errores de [CreateTaskLogicTasks].
void main() {
  group('CreateTaskLogicTasks', () {
    late ProviderContainer container;

    setUp(() {
      container = createTestContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('submit with empty title throws CreateTaskException', () async {
      final notifier = container.read(createTaskLogicTasksProvider.notifier);
      expect(
        () => notifier.submit(
          title: '',
          taskCategoryId: 'cat_1',
          taskPriorityId: 'pri_1',
          dueDate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        ),
        throwsA(
          isA<CreateTaskException>().having(
            (e) => e.errorCode,
            'errorCode',
            'VALIDATION',
          ),
        ),
      );
    });

    test(
      'submit with whitespace-only title throws CreateTaskException',
      () async {
        final notifier = container.read(createTaskLogicTasksProvider.notifier);
        expect(
          () => notifier.submit(
            title: '   ',
            taskCategoryId: 'cat_1',
            taskPriorityId: 'pri_1',
            dueDate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          ),
          throwsA(
            isA<CreateTaskException>().having(
              (e) => e.errorCode,
              'errorCode',
              'VALIDATION',
            ),
          ),
        );
      },
    );

    test(
      'submit with empty taskCategoryId throws CreateTaskException',
      () async {
        final notifier = container.read(createTaskLogicTasksProvider.notifier);
        expect(
          () => notifier.submit(
            title: 'Valid title',
            taskCategoryId: '',
            taskPriorityId: 'pri_1',
            dueDate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          ),
          throwsA(
            isA<CreateTaskException>().having(
              (e) => e.errorCode,
              'errorCode',
              'VALIDATION',
            ),
          ),
        );
      },
    );

    test(
      'submit with empty taskPriorityId throws CreateTaskException',
      () async {
        final notifier = container.read(createTaskLogicTasksProvider.notifier);
        expect(
          () => notifier.submit(
            title: 'Valid title',
            taskCategoryId: 'cat_1',
            taskPriorityId: '',
            dueDate: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          ),
          throwsA(
            isA<CreateTaskException>().having(
              (e) => e.errorCode,
              'errorCode',
              'VALIDATION',
            ),
          ),
        );
      },
    );

    test(
      'submit with dueDate zero or negative throws CreateTaskException',
      () async {
        final notifier = container.read(createTaskLogicTasksProvider.notifier);
        expect(
          () => notifier.submit(
            title: 'Valid title',
            taskCategoryId: 'cat_1',
            taskPriorityId: 'pri_1',
            dueDate: 0,
          ),
          throwsA(
            isA<CreateTaskException>().having(
              (e) => e.errorCode,
              'errorCode',
              'VALIDATION',
            ),
          ),
        );
      },
    );
  });
}

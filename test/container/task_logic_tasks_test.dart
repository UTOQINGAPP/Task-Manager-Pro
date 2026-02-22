import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager_pro/interface/pages/tasks/logic/task/task_logic_tasks.dart';

import '../helper/test_container_helper.dart';

/// Unit tests for task-by-id logic: empty id returns null (create mode).
/// Pruebas unitarias para la lógica de tarea por id: id vacío devuelve null (modo crear).
void main() {
  setUpAll(WidgetsFlutterBinding.ensureInitialized);

  group('taskById', () {
    late ProviderContainer container;

    setUp(() {
      container = createTestContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('empty id returns null (create mode)', () async {
      final result = await container.read(taskByIdProvider('').future);
      expect(result, isNull);
    });
  });
}

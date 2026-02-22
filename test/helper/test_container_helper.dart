import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager_pro/core/core.dart'
    show TaskDataRule;
import 'package:task_manager_pro/interface/shared/shared.dart'
    show
        notificationServiceProvider,
        taskServiceProvider,
        taskPriorityServiceProvider,
        taskCategoryServiceProvider;

import '../fakes/fakes.dart';
import 'test_data_helper.dart';

/// Creates reusable overrides for tests.
/// Crea los overrides reutilizables para tests.
List<Override> createTestOverrides({List<TaskDataRule> tasks = const []}) {
  return [
    taskServiceProvider.overrideWithValue(TaskServiceUseFakeTest(tasks: tasks)),
    taskPriorityServiceProvider.overrideWithValue(
      TaskPriorityServiceUseFakeTest(taskPriorities: fakeTaskPriorities),
    ),
    taskCategoryServiceProvider.overrideWithValue(
      TaskCategoryServiceUseFakeTest(taskCategories: fakeTaskCategories),
    ),
    notificationServiceProvider.overrideWithValue(NotificationServiceUseFakeTest()),
  ];
}

/// Creates a ProviderContainer configured for logic tests.
/// Crea un ProviderContainer configurado para tests de lógica.
ProviderContainer createTestContainer({List<TaskDataRule> tasks = const []}) {
  return ProviderContainer(overrides: createTestOverrides(tasks: tasks));
}

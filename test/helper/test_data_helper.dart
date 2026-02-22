import 'package:task_manager_pro/core/core.dart'
    show TaskCategoryDataRule, TaskPriorityDataRule;

/// Shared fake priorities for tests.
/// Prioridades fake compartidas para pruebas.
const List<TaskPriorityDataRule> fakeTaskPriorities = <TaskPriorityDataRule>[
  TaskPriorityDataRule(
    id: '1',
    name: 'Priority 1',
    color: 0xFF000000,
    sortOrder: 1,
    createdAt: 1,
  ),
  TaskPriorityDataRule(
    id: '2',
    name: 'Priority 2',
    color: 0xFF000000,
    sortOrder: 2,
    createdAt: 2,
  ),
  TaskPriorityDataRule(
    id: '3',
    name: 'Priority 3',
    color: 0xFF000000,
    sortOrder: 3,
    createdAt: 3,
  ),
];

/// Shared fake categories for tests.
/// Categorías fake compartidas para pruebas.
const List<TaskCategoryDataRule> fakeTaskCategories = <TaskCategoryDataRule>[
  TaskCategoryDataRule(
    id: '1',
    name: 'Category 1',
    color: 0xFF000000,
    createdAt: 1,
  ),
  TaskCategoryDataRule(
    id: '2',
    name: 'Category 2',
    color: 0xFF000000,
    createdAt: 2,
  ),
  TaskCategoryDataRule(
    id: '3',
    name: 'Category 3',
    color: 0xFF000000,
    createdAt: 3,
  ),
];

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'internationalization_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class InternationalizationLocalizationsEn
    extends InternationalizationLocalizations {
  InternationalizationLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Task Manager Pro';

  @override
  String get noTasks => 'No tasks';

  @override
  String get createTaskToStart => 'Create a task to get started';

  @override
  String get pullToRefresh => 'Pull down to refresh';

  @override
  String get errorLoadingTasks => 'An error occurred while loading tasks';

  @override
  String get errorLoading => 'Error loading';

  @override
  String get tapToRetry => 'Tap to retry';

  @override
  String get addTask => 'Add task';

  @override
  String get clearFilters => 'Clear filters';

  @override
  String get selectAllTasks => 'Select all tasks';

  @override
  String get cancelSelection => 'Cancel selection';

  @override
  String get delete => 'Delete';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get reload => 'Reload';

  @override
  String get openTask => 'Open task';

  @override
  String get selectTask => 'Select task';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get newTask => 'New task';

  @override
  String get editTask => 'Edit task';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get category => 'Category';

  @override
  String get priority => 'Priority';

  @override
  String get searchTask => 'Search task';

  @override
  String get filter => 'Filter';

  @override
  String get filterTasks => 'Filter tasks';

  @override
  String get completionStatus => 'Completion status';

  @override
  String get all => 'All';

  @override
  String get completed => 'Completed';

  @override
  String get notCompleted => 'Not completed';

  @override
  String get enterTaskTitle => 'Enter task title';

  @override
  String get enterTaskDescription => 'Enter task description';

  @override
  String get dueDate => 'Due date';

  @override
  String get enterTaskDueDate => 'Enter task due date';

  @override
  String get dueTime => 'Due time';

  @override
  String get enterTaskDueTime => 'Enter task due time';

  @override
  String get markAsCompleted => 'Mark as completed';

  @override
  String get markAsCompletedHint => 'If the task is completed, check the box';

  @override
  String get markAsArchived => 'Mark as archived';

  @override
  String get markAsArchivedHint =>
      'Archived tasks are hidden from the active list';

  @override
  String get total => 'TOTAL';

  @override
  String get pending => 'PENDING';

  @override
  String get archived => 'ARCHIVED';

  @override
  String get bin => 'Bin';

  @override
  String get binTasks => 'Deleted tasks';

  @override
  String get deleteTasksFromBin => 'Delete from bin';

  @override
  String get restoreTasksFromBin => 'Restore from bin';

  @override
  String get deleteAllTasksFromBin => 'Delete all from bin';

  @override
  String get emptyTrash => 'Empty trash';

  @override
  String get placeholderTaskTitle => 'Placeholder task title';

  @override
  String get placeholderTaskDescription =>
      'Example description for skeleton...';

  @override
  String get categoryPersonal => 'Personal';

  @override
  String get categoryWork => 'Work';

  @override
  String get categoryStudy => 'Study';

  @override
  String get priorityLow => 'Low';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityHigh => 'High';

  @override
  String errorWithDetails(String error) {
    return 'Error: $error';
  }
}

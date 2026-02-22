import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'internationalization_localizations_en.dart';
import 'internationalization_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of InternationalizationLocalizations
/// returned by `InternationalizationLocalizations.of(context)`.
///
/// Applications need to include `InternationalizationLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'container/internationalization_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: InternationalizationLocalizations.localizationsDelegates,
///   supportedLocales: InternationalizationLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the InternationalizationLocalizations.supportedLocales
/// property.
abstract class InternationalizationLocalizations {
  InternationalizationLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static InternationalizationLocalizations? of(BuildContext context) {
    return Localizations.of<InternationalizationLocalizations>(
      context,
      InternationalizationLocalizations,
    );
  }

  static const LocalizationsDelegate<InternationalizationLocalizations>
  delegate = _InternationalizationLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// Application title shown in app bars and window title.
  ///
  /// In en, this message translates to:
  /// **'Task Manager Pro'**
  String get appTitle;

  /// Empty-state title when there are no tasks to display.
  ///
  /// In en, this message translates to:
  /// **'No tasks'**
  String get noTasks;

  /// Empty-state subtitle encouraging users to create their first task.
  ///
  /// In en, this message translates to:
  /// **'Create a task to get started'**
  String get createTaskToStart;

  /// Hint text indicating users can pull down to refresh content.
  ///
  /// In en, this message translates to:
  /// **'Pull down to refresh'**
  String get pullToRefresh;

  /// Title shown when task list fails to load.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading tasks'**
  String get errorLoadingTasks;

  /// Generic short error label for loading failures.
  ///
  /// In en, this message translates to:
  /// **'Error loading'**
  String get errorLoading;

  /// Hint indicating that the user can tap to retry an action.
  ///
  /// In en, this message translates to:
  /// **'Tap to retry'**
  String get tapToRetry;

  /// Tooltip/label for creating a new task.
  ///
  /// In en, this message translates to:
  /// **'Add task'**
  String get addTask;

  /// Action label to clear active filters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFilters;

  /// Action label to select all visible tasks.
  ///
  /// In en, this message translates to:
  /// **'Select all tasks'**
  String get selectAllTasks;

  /// Action label to exit multi-selection mode.
  ///
  /// In en, this message translates to:
  /// **'Cancel selection'**
  String get cancelSelection;

  /// Generic delete action label.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Action label to clear the search query.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// Generic reload action label.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get reload;

  /// Accessibility label for opening a task item.
  ///
  /// In en, this message translates to:
  /// **'Open task'**
  String get openTask;

  /// Accessibility label for selecting a task item.
  ///
  /// In en, this message translates to:
  /// **'Select task'**
  String get selectTask;

  /// Field label for task title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// Field label for task description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Dialog/page title for creating a task.
  ///
  /// In en, this message translates to:
  /// **'New task'**
  String get newTask;

  /// Dialog/page title for editing a task.
  ///
  /// In en, this message translates to:
  /// **'Edit task'**
  String get editTask;

  /// Primary action label to save changes.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Secondary action label to cancel current operation.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Field label for task category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Field label for task priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// Placeholder/label for task search input.
  ///
  /// In en, this message translates to:
  /// **'Search task'**
  String get searchTask;

  /// Generic filter action label.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// Dialog title for task filters.
  ///
  /// In en, this message translates to:
  /// **'Filter tasks'**
  String get filterTasks;

  /// Field/group label for completion state filter.
  ///
  /// In en, this message translates to:
  /// **'Completion status'**
  String get completionStatus;

  /// Option meaning no filter; include all items.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Option/label for completed tasks.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// Option/label for pending or uncompleted tasks.
  ///
  /// In en, this message translates to:
  /// **'Not completed'**
  String get notCompleted;

  /// Hint text for task title input.
  ///
  /// In en, this message translates to:
  /// **'Enter task title'**
  String get enterTaskTitle;

  /// Hint text for task description input.
  ///
  /// In en, this message translates to:
  /// **'Enter task description'**
  String get enterTaskDescription;

  /// Field label for due date.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get dueDate;

  /// Hint text for due date input.
  ///
  /// In en, this message translates to:
  /// **'Enter task due date'**
  String get enterTaskDueDate;

  /// Field label for due time.
  ///
  /// In en, this message translates to:
  /// **'Due time'**
  String get dueTime;

  /// Hint text for due time input.
  ///
  /// In en, this message translates to:
  /// **'Enter task due time'**
  String get enterTaskDueTime;

  /// Checkbox label to mark a task as completed.
  ///
  /// In en, this message translates to:
  /// **'Mark as completed'**
  String get markAsCompleted;

  /// Helper text for completion checkbox.
  ///
  /// In en, this message translates to:
  /// **'If the task is completed, check the box'**
  String get markAsCompletedHint;

  /// Checkbox label to archive a task manually.
  ///
  /// In en, this message translates to:
  /// **'Mark as archived'**
  String get markAsArchived;

  /// Helper text for archive checkbox.
  ///
  /// In en, this message translates to:
  /// **'Archived tasks are hidden from the active list'**
  String get markAsArchivedHint;

  /// Summary label for total tasks.
  ///
  /// In en, this message translates to:
  /// **'TOTAL'**
  String get total;

  /// Summary label for pending tasks.
  ///
  /// In en, this message translates to:
  /// **'PENDING'**
  String get pending;

  /// Summary label for archived tasks.
  ///
  /// In en, this message translates to:
  /// **'ARCHIVED'**
  String get archived;

  /// Button label for opening the deleted-tasks (bin) dialog.
  ///
  /// In en, this message translates to:
  /// **'Bin'**
  String get bin;

  /// Accessibility label for the button that opens the bin (deleted tasks) dialog.
  ///
  /// In en, this message translates to:
  /// **'Deleted tasks'**
  String get binTasks;

  /// Button label to permanently delete tasks from the bin.
  ///
  /// In en, this message translates to:
  /// **'Delete from bin'**
  String get deleteTasksFromBin;

  /// Button label to restore tasks from the bin.
  ///
  /// In en, this message translates to:
  /// **'Restore from bin'**
  String get restoreTasksFromBin;

  /// Button label to permanently delete all tasks from the bin.
  ///
  /// In en, this message translates to:
  /// **'Delete all from bin'**
  String get deleteAllTasksFromBin;

  /// Button/label to empty the trash (delete all from bin).
  ///
  /// In en, this message translates to:
  /// **'Empty trash'**
  String get emptyTrash;

  /// Skeleton/loading placeholder for task title.
  ///
  /// In en, this message translates to:
  /// **'Placeholder task title'**
  String get placeholderTaskTitle;

  /// Skeleton/loading placeholder for task description.
  ///
  /// In en, this message translates to:
  /// **'Example description for skeleton...'**
  String get placeholderTaskDescription;

  /// Display name for task category: Personal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get categoryPersonal;

  /// Display name for task category: Work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get categoryWork;

  /// Display name for task category: Study.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get categoryStudy;

  /// Display name for task priority: Low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get priorityLow;

  /// Display name for task priority: Medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get priorityMedium;

  /// Display name for task priority: High.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get priorityHigh;

  /// Error message template including dynamic error details.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorWithDetails(String error);
}

class _InternationalizationLocalizationsDelegate
    extends LocalizationsDelegate<InternationalizationLocalizations> {
  const _InternationalizationLocalizationsDelegate();

  @override
  Future<InternationalizationLocalizations> load(Locale locale) {
    return SynchronousFuture<InternationalizationLocalizations>(
      lookupInternationalizationLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_InternationalizationLocalizationsDelegate old) => false;
}

InternationalizationLocalizations lookupInternationalizationLocalizations(
  Locale locale,
) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return InternationalizationLocalizationsEn();
    case 'es':
      return InternationalizationLocalizationsEs();
  }

  throw FlutterError(
    'InternationalizationLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

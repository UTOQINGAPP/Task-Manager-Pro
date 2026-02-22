import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager_pro/configs/configs.dart';
import 'package:task_manager_pro/core/core.dart'
    show TaskCategoryDataRule, TaskPriorityDataRule, TaskDataRule;
import 'package:task_manager_pro/interface/pages/tasks/components/components_tasks.dart';
import 'package:task_manager_pro/interface/pages/tasks/logic/logic_tasks.dart';
import 'package:task_manager_pro/interface/shared/shared.dart';

/// Dialog for creating a new task or editing an existing one.
/// Reads categories and priorities from shared providers.
///
/// Diálogo para crear una tarea nueva o editar una existente.
/// Lee categorías y prioridades desde los providers compartidos.
class CreateAndEditTaskDialogTasks extends ConsumerStatefulWidget {
  /// Creates the create/edit task dialog.
  /// Crea el diálogo de creación/edición de tareas.
  const CreateAndEditTaskDialogTasks({
    super.key,
    this.task,
  });

  final TaskDataRule? task;

  @override
  ConsumerState<CreateAndEditTaskDialogTasks> createState() =>
      _CreateAndEditTaskDialogTasksState();
}

class _CreateAndEditTaskDialogTasksState
    extends ConsumerState<CreateAndEditTaskDialogTasks> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  TaskCategoryDataRule? _selectedCategory;
  TaskPriorityDataRule? _selectedPriority;
  late DateTime _selectedDueDate;
  bool? _selectedIsCompleted;
  bool? _selectedIsArchived;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    final categories =
        ref.read(categoryLogicSharedProvider).value ?? <TaskCategoryDataRule>[];
    final priorities =
        ref.read(priorityLogicSharedProvider).value ?? <TaskPriorityDataRule>[];
    const defaultCategory = TaskCategoryDataRule(
      id: '',
      name: '',
      color: 0xFF9E9E9E,
      createdAt: 0,
    );
    const defaultPriority = TaskPriorityDataRule(
      id: '',
      name: '',
      color: 0xFF9E9E9E,
      sortOrder: 0,
      createdAt: 0,
    );
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description ?? '';

      _selectedCategory = categories.firstWhere(
        (c) => c.id == widget.task!.taskCategoryId,
        orElse: () =>
            categories.isNotEmpty ? categories.first : defaultCategory,
      );
      _selectedPriority = priorities.firstWhere(
        (p) => p.id == widget.task!.taskPriorityId,
        orElse: () =>
            priorities.isNotEmpty ? priorities.first : defaultPriority,
      );
      _selectedDueDate = DateTime.fromMillisecondsSinceEpoch(
        widget.task!.dueDate,
      );

      _selectedIsCompleted = widget.task!.isCompleted;
      _selectedIsArchived = widget.task!.isArchived;
    } else {
      _selectedCategory =
          categories.isNotEmpty ? categories.first : defaultCategory;
      _selectedPriority =
          priorities.isNotEmpty ? priorities.first : defaultPriority;
      _selectedIsCompleted = null;
      _selectedIsArchived = null;
      _selectedDueDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InternationalizationLocalizations l10n =
        InternationalizationLocalizations.of(context)!;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        elevation: 0.5,
        child: SafeArea(
          child: Column(
            children: [
              _headerView(context, l10n),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: _formView(context, l10n),
                ),
              ),

              _actionsButtonView(context, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Padding _headerView(
    BuildContext context,
    InternationalizationLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.task != null ? l10n.editTask : l10n.newTask,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Column _formView(
    BuildContext context,
    InternationalizationLocalizations l10n,
  ) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: CustomTextFieldComponentTasks(
            label: l10n.title,
            controller: _titleController,
            hint: l10n.enterTaskTitle,
            required: true,
            theme: CustomTextFieldThemeTasks(
              labelStyle:
                  textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ) ??
                  DefaultTextStyle.of(context).style,
              requiredIndicatorColor: Theme.of(context).colorScheme.error,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.5),
              ),
              focusedBorderSide: BorderSide(
                width: 2,
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: CustomTextFieldComponentTasks(
            label: l10n.description,
            controller: _descriptionController,
            hint: l10n.enterTaskDescription,
            theme: CustomTextFieldThemeTasks(
              labelStyle:
                  textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ) ??
                  DefaultTextStyle.of(context).style,
              requiredIndicatorColor: Theme.of(context).colorScheme.error,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.5),
              ),
              focusedBorderSide: BorderSide(
                width: 2,
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              ref
                  .watch(categoryLogicSharedProvider)
                  .when(
                    data: (categories) => SizedBox(
                      width: context.width(45),
                      child: CustomDropdownComponentTasks<TaskCategoryDataRule>(
                        label: l10n.category,

                        value: _selectedCategory,
                        items: categories
                            .map(
                              (category) => CustomDropdownItemModel(
                                value: category,
                                child: Text(
                                  CategoryLabelHelperShared.getDisplayName(
                                    l10n,
                                    category.name,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (category) {
                          setState(() => _selectedCategory = category);
                        },
                        theme: CustomDropdownThemeTasks(
                          labelStyle:
                              textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ) ??
                              DefaultTextStyle.of(context).style,
                          requiredIndicatorColor: Theme.of(
                            context,
                          ).colorScheme.error,
                          fillColor: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          borderSide: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.outline.withValues(alpha: 0.5),
                          ),
                          enabledBorderSide: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.outline.withValues(alpha: 0.5),
                          ),
                          focusedBorderSide: BorderSide(
                            width: 2,
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          dropdownColor: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                        ),
                      ),
                    ),
                    error: (error, stackTrace) =>
                        Text(l10n.errorWithDetails(error.toString())),
                    loading: () => CircularProgressIndicator(),
                  ),
              SizedBox(width: context.width(4.5)),
              ref
                  .watch(priorityLogicSharedProvider)
                  .when(
                    data: (priorities) => SizedBox(
                      width: context.width(45),
                      child: CustomDropdownComponentTasks<TaskPriorityDataRule>(
                        theme: CustomDropdownThemeTasks(
                          labelStyle:
                              textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ) ??
                              DefaultTextStyle.of(context).style,
                          requiredIndicatorColor: Theme.of(
                            context,
                          ).colorScheme.error,
                          fillColor: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          borderSide: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.outline.withValues(alpha: 0.5),
                          ),
                          enabledBorderSide: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.outline.withValues(alpha: 0.5),
                          ),
                          focusedBorderSide: BorderSide(
                            width: 2,
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          dropdownColor: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                        ),
                        label: l10n.priority,
                        value: _selectedPriority,
                        items: priorities
                            .map(
                              (priority) => CustomDropdownItemModel(
                                value: priority,
                                child: Text(
                                  PriorityLabelLogicShared.getDisplayName(
                                    l10n,
                                    priority.name,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (priority) {
                          setState(() => _selectedPriority = priority);
                        },
                      ),
                    ),
                    error: (error, stackTrace) =>
                        Text(l10n.errorWithDetails(error.toString())),
                    loading: () => CircularProgressIndicator(),
                  ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: CustomDateFieldComponentTasks(
            label: l10n.dueDate,
            hint: l10n.enterTaskDueDate,
            initialDate: _selectedDueDate,
            required: true,
            theme: CustomDateFieldThemeTasks(
              labelStyle:
                  textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ) ??
                  DefaultTextStyle.of(context).style,
              requiredIndicatorColor: Theme.of(context).colorScheme.error,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              enabledBorderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.5),
              ),
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.5),
              ),
              focusedBorderSide: BorderSide(
                width: 2,
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            onDateSelected: (date) {
              if (date == null) return;

              setState(() {
                final current = _selectedDueDate;

                _selectedDueDate = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  current.hour,
                  current.minute,
                  current.second,
                );
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: CustomTimeFieldComponentTasks(
            label: l10n.dueTime,
            hint: l10n.enterTaskDueTime,
            required: true,
            initialTime: TimeOfDay.fromDateTime(_selectedDueDate.toLocal()),
            onTimeSelected: (TimeOfDay? time) {
              if (time == null) return;

              setState(() {
                final current = _selectedDueDate;

                _selectedDueDate = DateTime(
                  current.year,
                  current.month,
                  current.day,
                  time.hour,
                  time.minute,
                  DateTime.now().second,
                );
              });
            },
            theme: CustomTimeFieldThemeTasks(
              labelStyle:
                  textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ) ??
                  DefaultTextStyle.of(context).style,
              requiredIndicatorColor: Theme.of(context).colorScheme.error,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderSide: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        if (widget.task != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: CheckboxListTile(
              value: _selectedIsCompleted ?? false,
              onChanged: (value) {
                setState(() => _selectedIsCompleted = value);
              },
              title: Text(l10n.markAsCompleted),
              subtitle: Text(l10n.markAsCompletedHint),
              secondary: Icon(Icons.task_alt_sharp),
              activeColor: Theme.of(context).colorScheme.primary,
              checkColor: Theme.of(context).colorScheme.onPrimary,
              side: BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
          ),
        if (widget.task != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: CheckboxListTile(
              value: _selectedIsArchived ?? false,
              onChanged: (value) {
                setState(() => _selectedIsArchived = value);
              },
              title: Text(l10n.markAsArchived),
              subtitle: Text(l10n.markAsArchivedHint),
              secondary: Icon(Icons.archive_outlined),
              activeColor: Theme.of(context).colorScheme.primary,
              checkColor: Theme.of(context).colorScheme.onPrimary,
              side: BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
          ),
      ],
    );
  }

  Padding _actionsButtonView(
    BuildContext context,
    InternationalizationLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),

      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: FilledButton(
              onPressed: () async {
                try {
                  if (widget.task == null) {
                    await ref
                        .read(createTaskLogicTasksProvider.notifier)
                        .submit(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          taskCategoryId: _selectedCategory!.id,
                          taskPriorityId: _selectedPriority!.id,
                          dueDate: _selectedDueDate.millisecondsSinceEpoch,
                        );
                    ref.invalidate(listLogicTasksProvider);
                    ref.read(statusLogicTasksProvider.notifier).refresh();
                  } else {
                    await ref
                        .read(editTaskLogicTasksProvider.notifier)
                        .submit(
                          taskId: widget.task!.id,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          taskCategoryId: _selectedCategory!.id,
                          taskPriorityId: _selectedPriority!.id,
                          dueDate: _selectedDueDate.millisecondsSinceEpoch,
                          isCompleted: _selectedIsCompleted,
                          isArchived: _selectedIsArchived,
                        );
                    ref.read(listLogicTasksProvider.notifier).refresh();
                    ref.read(statusLogicTasksProvider.notifier).refresh();
                  }

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                  }
                }
              },
              child: Text(l10n.save),
            ),
          ),

          SizedBox(width: 10),
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(l10n.cancel),
            ),
          ),
        ],
      ),
    );
  }
}

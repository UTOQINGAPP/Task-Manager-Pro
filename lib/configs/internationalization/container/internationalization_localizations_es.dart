// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'internationalization_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class InternationalizationLocalizationsEs
    extends InternationalizationLocalizations {
  InternationalizationLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Task Manager Pro';

  @override
  String get noTasks => 'No hay tareas';

  @override
  String get createTaskToStart => 'Crea una tarea para empezar';

  @override
  String get pullToRefresh => 'Desliza hacia abajo para recargar';

  @override
  String get errorLoadingTasks => 'Hubo un error al cargar las tareas';

  @override
  String get errorLoading => 'Error al cargar';

  @override
  String get tapToRetry => 'Toca para reintentar';

  @override
  String get addTask => 'Añadir tarea';

  @override
  String get clearFilters => 'Limpiar filtros';

  @override
  String get selectAllTasks => 'Seleccionar todas las tareas';

  @override
  String get cancelSelection => 'Cancelar selección';

  @override
  String get delete => 'Eliminar';

  @override
  String get clearSearch => 'Limpiar búsqueda';

  @override
  String get reload => 'Recargar';

  @override
  String get openTask => 'Abrir tarea';

  @override
  String get selectTask => 'Seleccionar tarea';

  @override
  String get title => 'Título';

  @override
  String get description => 'Descripción';

  @override
  String get newTask => 'Nueva tarea';

  @override
  String get editTask => 'Editar tarea';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get category => 'Categoría';

  @override
  String get priority => 'Prioridad';

  @override
  String get searchTask => 'Buscar tarea';

  @override
  String get filter => 'Filtrar';

  @override
  String get filterTasks => 'Filtrar tareas';

  @override
  String get completionStatus => 'Estado de completado';

  @override
  String get all => 'Todas';

  @override
  String get completed => 'Completadas';

  @override
  String get notCompleted => 'No completadas';

  @override
  String get enterTaskTitle => 'Ingrese el título de la tarea';

  @override
  String get enterTaskDescription => 'Ingrese la descripción de la tarea';

  @override
  String get dueDate => 'Fecha de vencimiento';

  @override
  String get enterTaskDueDate => 'Ingrese la fecha de vencimiento de la tarea';

  @override
  String get dueTime => 'Hora de vencimiento';

  @override
  String get enterTaskDueTime => 'Ingrese la hora de vencimiento de la tarea';

  @override
  String get markAsCompleted => 'Marcar como completado';

  @override
  String get markAsCompletedHint =>
      'Si la tarea está completada, marque la casilla';

  @override
  String get markAsArchived => 'Marcar como archivada';

  @override
  String get markAsArchivedHint =>
      'Las tareas archivadas se ocultan de la lista activa';

  @override
  String get total => 'TOTAL';

  @override
  String get pending => 'PENDIENTES';

  @override
  String get archived => 'ARCHIVADAS';

  @override
  String get bin => 'Papelera';

  @override
  String get binTasks => 'Tareas eliminadas';

  @override
  String get deleteTasksFromBin => 'Eliminar de la papelera';

  @override
  String get restoreTasksFromBin => 'Restaurar de la papelera';

  @override
  String get deleteAllTasksFromBin => 'Eliminar todas de la papelera';

  @override
  String get emptyTrash => 'Vaciar papelera';

  @override
  String get placeholderTaskTitle => 'Título de tarea de ejemplo';

  @override
  String get placeholderTaskDescription =>
      'Descripción de ejemplo para skeleton...';

  @override
  String get categoryPersonal => 'Personal';

  @override
  String get categoryWork => 'Trabajo';

  @override
  String get categoryStudy => 'Estudio';

  @override
  String get priorityLow => 'Baja';

  @override
  String get priorityMedium => 'Media';

  @override
  String get priorityHigh => 'Alta';

  @override
  String errorWithDetails(String error) {
    return 'Error: $error';
  }
}

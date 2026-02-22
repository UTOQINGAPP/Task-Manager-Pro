import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

import '../tables/tables.dart';

part 'app_database.g.dart';

// ==========================================
// DEFAULT SEED DATA
// ==========================================

/// Default task category IDs for initial seed.
/// IDs de categorías de tarea por defecto para el seed inicial.
abstract final class DefaultTaskCategoryIds {
  static const String personal = 'cat_personal';
  static const String work = 'cat_work';
  static const String study = 'cat_study';
}

/// Default task category colors (ARGB integers). Chosen for contrast on
/// surface/surfaceContainerLow in both light and dark palette.
/// Colores por defecto de categoría (ARGB). Contrastan con surface/surfaceContainerLow.
abstract final class DefaultTaskCategoryColors {
  /// Personal – Indigo soft (armónico con primary)
  static const int personal = 0xFF5E5CE6;

  /// Work – Blue toned to Material 3 harmony
  static const int work = 0xFF4F5BD5;

  /// Study – Deep muted purple (coherente con primaryContainer)
  static const int study = 0xFF7B61A8;
}

/// Default task priority IDs for initial seed.
/// IDs de prioridad de tarea por defecto para el seed inicial.
abstract final class DefaultTaskPriorityIds {
  static const String low = 'pri_low';
  static const String medium = 'pri_medium';
  static const String high = 'pri_high';
}

/// Default task priority colors (ARGB integers). Chosen for contrast on
/// surface/surfaceContainerLow in both light and dark palette.
/// Colores por defecto de prioridad (ARGB). Contrastan con el fondo de la paleta.
abstract final class DefaultTaskPriorityColors {
  /// Low – uses a harmonized success tone.
  /// Low – usa un tono success armonizado.
  static const int low = 0xFF4CAF50;

  /// Medium – uses a warning tone aligned to Material palette.
  /// Medium – usa un tono warning alineado a la paleta Material.
  static const int medium = 0xFFF9A825;

  /// High – uses the system error tone.
  /// High – usa el tono de error del sistema.
  static const int high = 0xFFB3261E;
}

// ==========================================
// APP DATABASE (Singleton)
// ==========================================

@DriftDatabase(tables: [TaskCategories, TaskPriorities, Tasks])
class ManagerDatabase extends _$ManagerDatabase {
  ManagerDatabase._(super.executor);

  /// Singleton instance. Single database for the whole app (avoids Drift warnings).
  /// Instancia singleton. Una sola base de datos para toda la app (evita warnings de Drift).
  static ManagerDatabase? _instance;

  /// Returns the unique [ManagerDatabase] instance.
  /// Devuelve la instancia única de [ManagerDatabase].
  static ManagerDatabase get instance =>
      _instance ??= ManagerDatabase._(_openExecutor());

  /// Public factory: always returns the singleton (for backward compatibility).
  /// Factory pública: siempre devuelve el singleton (compatibilidad con código existente).
  factory ManagerDatabase() => instance;

  /// Opens the database (path_provider + sqlite3 native).
  /// Abre la base de datos (path_provider + sqlite3 nativo).
  static QueryExecutor _openExecutor() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File('${dbFolder.path}/task_manager_pro.db');
      return NativeDatabase.createInBackground(file);
    });
  }

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await _seedDefaultTaskCategories();
      await _seedDefaultTaskPriorities();
      await customStatement('PRAGMA foreign_keys = ON;');
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.addColumn(tasks, tasks.isArchived);
      }
      if (from < 3) {
        await m.addColumn(tasks, tasks.isBin);
      }
      if (from < 4) {
        await _migrateCategoryAndPriorityNamesToKeys();
      }
    },
  );

  /// Migrates existing category/priority display names to localization keys (no data loss).
  /// Migra nombres de categoría/prioridad existentes a claves de localización (sin pérdida de datos).
  Future<void> _migrateCategoryAndPriorityNamesToKeys() async {
    await transaction(() async {
      await customStatement(
        "UPDATE task_categories SET name = CASE id "
        "WHEN '${DefaultTaskCategoryIds.personal}' THEN 'personal' "
        "WHEN '${DefaultTaskCategoryIds.work}' THEN 'work' "
        "WHEN '${DefaultTaskCategoryIds.study}' THEN 'study' "
        "ELSE name END",
      );
      await customStatement(
        "UPDATE task_priorities SET name = CASE id "
        "WHEN '${DefaultTaskPriorityIds.low}' THEN 'low' "
        "WHEN '${DefaultTaskPriorityIds.medium}' THEN 'medium' "
        "WHEN '${DefaultTaskPriorityIds.high}' THEN 'high' "
        "ELSE name END",
      );
    });
  }

  /// Inserts default task categories (keys: personal, work, study) if they do not exist.
  /// Inserta categorías de tarea por defecto (claves: personal, work, study) si no existen.
  Future<void> _seedDefaultTaskCategories() async {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    await batch((batch) {
      batch.insert(
        taskCategories,
        TaskCategoriesCompanion.insert(
          id: DefaultTaskCategoryIds.personal,
          name: 'personal',
          color: DefaultTaskCategoryColors.personal,
          createdAt: now,
        ),
        mode: InsertMode.insertOrIgnore,
      );
      batch.insert(
        taskCategories,
        TaskCategoriesCompanion.insert(
          id: DefaultTaskCategoryIds.work,
          name: 'work',
          color: DefaultTaskCategoryColors.work,
          createdAt: now,
        ),
        mode: InsertMode.insertOrIgnore,
      );
      batch.insert(
        taskCategories,
        TaskCategoriesCompanion.insert(
          id: DefaultTaskCategoryIds.study,
          name: 'study',
          color: DefaultTaskCategoryColors.study,
          createdAt: now,
        ),
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  /// Inserts default task priorities (keys: low, medium, high) if they do not exist.
  /// Inserta prioridades de tarea por defecto (claves: low, medium, high) si no existen.
  Future<void> _seedDefaultTaskPriorities() async {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    await batch((batch) {
      batch.insert(
        taskPriorities,
        TaskPrioritiesCompanion.insert(
          id: DefaultTaskPriorityIds.low,
          name: 'low',
          color: DefaultTaskPriorityColors.low,
          sortOrder: 0,
          createdAt: now,
        ),
        mode: InsertMode.insertOrIgnore,
      );
      batch.insert(
        taskPriorities,
        TaskPrioritiesCompanion.insert(
          id: DefaultTaskPriorityIds.medium,
          name: 'medium',
          color: DefaultTaskPriorityColors.medium,
          sortOrder: 1,
          createdAt: now,
        ),
        mode: InsertMode.insertOrIgnore,
      );
      batch.insert(
        taskPriorities,
        TaskPrioritiesCompanion.insert(
          id: DefaultTaskPriorityIds.high,
          name: 'high',
          color: DefaultTaskPriorityColors.high,
          sortOrder: 2,
          createdAt: now,
        ),
        mode: InsertMode.insertOrIgnore,
      );
    });
  }
}

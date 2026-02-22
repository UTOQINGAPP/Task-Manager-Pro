// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_logic_tasks.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Loads a single task by id. Pass empty string for create mode (returns null).
/// Carga una tarea por id. Pasar cadena vacía en modo crear (devuelve null).

@ProviderFor(taskById)
final taskByIdProvider = TaskByIdFamily._();

/// Loads a single task by id. Pass empty string for create mode (returns null).
/// Carga una tarea por id. Pasar cadena vacía en modo crear (devuelve null).

final class TaskByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<TaskDataRule?>,
          TaskDataRule?,
          FutureOr<TaskDataRule?>
        >
    with $FutureModifier<TaskDataRule?>, $FutureProvider<TaskDataRule?> {
  /// Loads a single task by id. Pass empty string for create mode (returns null).
  /// Carga una tarea por id. Pasar cadena vacía en modo crear (devuelve null).
  TaskByIdProvider._({
    required TaskByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'taskByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$taskByIdHash();

  @override
  String toString() {
    return r'taskByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TaskDataRule?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TaskDataRule?> create(Ref ref) {
    final argument = this.argument as String;
    return taskById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$taskByIdHash() => r'c887e1a7b29c5273c48e42d5faa6400602d1f7c4';

/// Loads a single task by id. Pass empty string for create mode (returns null).
/// Carga una tarea por id. Pasar cadena vacía en modo crear (devuelve null).

final class TaskByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TaskDataRule?>, String> {
  TaskByIdFamily._()
    : super(
        retry: null,
        name: r'taskByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Loads a single task by id. Pass empty string for create mode (returns null).
  /// Carga una tarea por id. Pasar cadena vacía en modo crear (devuelve null).

  TaskByIdProvider call(String id) =>
      TaskByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'taskByIdProvider';
}

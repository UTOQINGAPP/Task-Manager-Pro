// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_logic_bin.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Loads tasks in bin (isBin == true) and applies search/filter operations.
/// Carga tareas en papelera (isBin == true) y aplica búsqueda/filtro.

@ProviderFor(ListLogicBin)
final listLogicBinProvider = ListLogicBinProvider._();

/// Loads tasks in bin (isBin == true) and applies search/filter operations.
/// Carga tareas en papelera (isBin == true) y aplica búsqueda/filtro.
final class ListLogicBinProvider
    extends $AsyncNotifierProvider<ListLogicBin, BinListState> {
  /// Loads tasks in bin (isBin == true) and applies search/filter operations.
  /// Carga tareas en papelera (isBin == true) y aplica búsqueda/filtro.
  ListLogicBinProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listLogicBinProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listLogicBinHash();

  @$internal
  @override
  ListLogicBin create() => ListLogicBin();
}

String _$listLogicBinHash() => r'908ed3e33a8f5206255201fb961d746e54ba4c01';

/// Loads tasks in bin (isBin == true) and applies search/filter operations.
/// Carga tareas en papelera (isBin == true) y aplica búsqueda/filtro.

abstract class _$ListLogicBin extends $AsyncNotifier<BinListState> {
  FutureOr<BinListState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BinListState>, BinListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BinListState>, BinListState>,
              AsyncValue<BinListState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

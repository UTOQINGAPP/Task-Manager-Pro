import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager_pro/configs/configs.dart';
import 'package:task_manager_pro/interface/app/router/app_router.dart'
    show appRouter;

import '../shared/shared.dart';

/// Root application widget.
/// Widget raíz de la aplicación.
class App extends ConsumerWidget {
  /// Creates the App widget.
  /// Crea el widget App.
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeState themeState = ref.watch(themeLogicSharedProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) =>
          InternationalizationLocalizations.of(context)!.appTitle,
      theme: AppThemeData.light,
      darkTheme: AppThemeData.dark,
      themeMode: themeState.effectiveThemeMode,
      localizationsDelegates:
          InternationalizationLocalizations.localizationsDelegates,
      supportedLocales: InternationalizationLocalizations.supportedLocales,
      routerConfig: appRouter,
    );
  }
}

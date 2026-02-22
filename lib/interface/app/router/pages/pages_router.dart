import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_pro/interface/pages/pages.dart';

part 'pages_router.g.dart';

/// Exporta todas las rutas generadas
List<RouteBase> get pagesRouter => $appRoutes;

/// ===============================
/// TASKS (principal)
/// ===============================

@TypedGoRoute<TasksRoute>(path: TasksPage.path, name: TasksPage.name)
class TasksRoute extends GoRouteData with $TasksRoute {
  const TasksRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TasksPage();
  }
}

/// ===============================
/// BIN (papelera)
/// ===============================

@TypedGoRoute<BinRoute>(path: BinPage.path, name: BinPage.name)
class BinRoute extends GoRouteData with $BinRoute {
  const BinRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BinPage();
  }
}

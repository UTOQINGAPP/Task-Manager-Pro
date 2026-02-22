import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_pro/interface/app/router/pages/pages_router.dart'
    show pagesRouter, TasksRoute;

final GoRouter appRouter = GoRouter(
  initialLocation: const TasksRoute().location,
  routes: [...pagesRouter],

  debugLogDiagnostics: true,
  errorBuilder: (context, state) =>
      const Scaffold(body: Center(child: Text('Página no encontrada'))),
);

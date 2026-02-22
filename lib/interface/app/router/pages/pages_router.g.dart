// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pages_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$tasksRoute, $binRoute];

RouteBase get $tasksRoute => GoRouteData.$route(
  path: '/tasks',
  name: 'tasks',
  factory: $TasksRoute._fromState,
);

mixin $TasksRoute on GoRouteData {
  static TasksRoute _fromState(GoRouterState state) => const TasksRoute();

  @override
  String get location => GoRouteData.$location('/tasks');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $binRoute => GoRouteData.$route(
  path: '/bin',
  name: 'bin',
  factory: $BinRoute._fromState,
);

mixin $BinRoute on GoRouteData {
  static BinRoute _fromState(GoRouterState state) => const BinRoute();

  @override
  String get location => GoRouteData.$location('/bin');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

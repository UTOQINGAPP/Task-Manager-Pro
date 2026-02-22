import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager_pro/core/infra/infra_core.dart'
    show InitializerNotification, flutterLocalNotificationsPlugin;

import 'interface/interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final initializer = InitializerNotification(flutterLocalNotificationsPlugin);

  await initializer.initialize();
  runApp(ProviderScope(child: const App()));
}

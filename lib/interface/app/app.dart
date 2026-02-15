import 'package:flutter/material.dart';

/// Root application widget.
/// Widget raíz de la aplicación.
class App extends StatelessWidget {
  /// Creates the App widget.
  /// Crea el widget App.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: const Text('Hello World'),
        ),
      ),
    );
  }
}

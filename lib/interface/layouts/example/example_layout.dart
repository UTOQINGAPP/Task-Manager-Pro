/// This file is the end of the structure. Place your example layout content here.
/// Este archivo es el final de la estructura. Coloque aquí su contenido del layout de ejemplo.
/// 
/// If you want to grow the structure, change the file name to plural,
/// and create at the same level a "container" folder if it will grow into
/// multiple final files, or create named containers if they require more
/// organization or will grow further.
/// 
/// Si desea hacer crecer la estructura, cambie el nombre del archivo a plural,
/// y cree al mismo nivel una carpeta "container" si crecerá en varios archivos
/// finales, o cree contenedores con nombre si requieren más organización
/// o crecerán más.

import 'package:flutter/material.dart';

/// Example layout widget.
/// Widget de layout de ejemplo.
class ExampleLayout extends StatelessWidget {
  /// Creates an ExampleLayout widget.
  /// Crea un widget ExampleLayout.
  const ExampleLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Example Layout Content'),
      ),
    );
  }
}

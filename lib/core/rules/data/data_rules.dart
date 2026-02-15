library;

/// Barrel file for RULES/Data contracts.
/// Archivo barrel para los contratos RULES/Data.

// Example code / Código de ejemplo:
// /// Data rule for example entity.
// /// Regla de datos para entidad de ejemplo.
// class ExampleDataRule {
//   /// Property description. / Descripción de la propiedad.
//   final String property;
//
//   const ExampleDataRule({
//     required this.property,
//   });
//
//   /// Check if valid. / Verificar si es válido.
//   bool get isValid => property.isNotEmpty;
//
//   /// Create a copy with updated values.
//   /// Crear una copia con valores actualizados.
//   ExampleDataRule copyWith({
//     String? property,
//   }) {
//     return ExampleDataRule(
//       property: property ?? this.property,
//     );
//   }
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     return other is ExampleDataRule && other.property == property;
//   }
//
//   @override
//   int get hashCode => property.hashCode;
//
//   @override
//   String toString() => 'ExampleDataRule(property: $property)';
// }

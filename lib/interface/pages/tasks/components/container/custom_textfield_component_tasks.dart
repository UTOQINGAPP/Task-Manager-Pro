import 'package:flutter/material.dart';

/// Theme data for [CustomTextFieldComponentTasks].
/// Allows customizing label, required indicator, and input decoration.
///
/// Datos de tema para [CustomTextFieldComponentTasks].
/// Permite personalizar etiqueta, indicador de requerido y decoración del input.
class CustomTextFieldThemeTasks {
  const CustomTextFieldThemeTasks({
    required this.labelStyle,
    required this.requiredIndicatorColor,
    required this.fillColor,
    required this.contentPadding,
    required this.borderRadius,
    this.borderSide,
    this.focusedBorderSide,
    this.hintStyle,
  });

  /// Text style for the label above the field.
  /// Estilo de texto para la etiqueta sobre el campo.
  final TextStyle labelStyle;

  /// Color for the asterisk when the field is required.
  /// Color del asterisco cuando el campo es requerido.
  final Color requiredIndicatorColor;

  /// Background color of the text field.
  /// Color de fondo del campo de texto.
  final Color fillColor;

  /// Inner padding of the text field.
  /// Relleno interno del campo de texto.
  final EdgeInsetsGeometry contentPadding;

  /// Border radius of the input.
  /// Radio del borde del input.
  final BorderRadius borderRadius;

  /// Border side for default/enabled state. If null, no border is drawn.
  /// Lado del borde para estado normal. Si es null, no se dibuja borde.
  final BorderSide? borderSide;

  /// Border side when the field is focused.
  /// Lado del borde cuando el campo tiene foco.
  final BorderSide? focusedBorderSide;

  /// Style for hint text. If null, uses a variant of label style.
  /// Estilo del texto de ayuda. Si es null, usa una variante del estilo de etiqueta.
  final TextStyle? hintStyle;

  /// Builds theme from the current app [ThemeData].
  /// Uses [InputDecorationThemeData] and [TextTheme] for defaults.
  ///
  /// Construye el tema a partir del [ThemeData] actual de la app.
  /// Usa [InputDecorationThemeData] y [TextTheme] para los valores por defecto.
  static CustomTextFieldThemeTasks fromContext(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final InputDecorationThemeData inputTheme = theme.inputDecorationTheme;
    final TextTheme textTheme = theme.textTheme;

    final Color fillColor =
        inputTheme.fillColor ??
        scheme.surfaceContainerHighest.withValues(alpha: 0.5);

    final EdgeInsetsGeometry contentPadding =
        inputTheme.contentPadding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14);

    final OutlineInputBorder? outlineBorder =
        inputTheme.border is OutlineInputBorder
        ? inputTheme.border as OutlineInputBorder
        : null;
    final BorderRadius radius =
        outlineBorder?.borderRadius ?? BorderRadius.circular(12);

    final BorderSide? defaultSide = outlineBorder?.borderSide;
    final BorderSide focusedSide =
        inputTheme.focusedBorder is OutlineInputBorder
        ? (inputTheme.focusedBorder as OutlineInputBorder).borderSide
        : BorderSide(color: scheme.primary, width: 2);

    return CustomTextFieldThemeTasks(
      labelStyle:
          textTheme.bodyLarge?.copyWith(color: scheme.onSurface) ??
          DefaultTextStyle.of(context).style.copyWith(color: scheme.onSurface),
      requiredIndicatorColor: scheme.error,
      fillColor: fillColor,
      contentPadding: contentPadding,
      borderRadius: radius,
      borderSide: defaultSide,
      focusedBorderSide: focusedSide,
      hintStyle:
          inputTheme.hintStyle ??
          textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
          ) ??
          DefaultTextStyle.of(
            context,
          ).style.copyWith(color: scheme.onSurfaceVariant.withValues(alpha: 0.7)),
    );
  }

  /// Input border for default state.
  /// Borde del input para estado normal.
  InputBorder get border => OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: borderSide ?? BorderSide.none,
  );

  /// Input border for focused state.
  /// Borde del input para estado enfocado.
  InputBorder get focusedBorder => OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: focusedBorderSide ?? borderSide ?? BorderSide.none,
  );
}

/// Reusable text field with label and optional required indicator.
/// Supports optional custom theme; otherwise uses app theme defaults.
///
/// Campo de texto reutilizable con etiqueta e indicador opcional de requerido.
/// Admite tema personalizado opcional; si no se pasa, usa el tema actual de la app.
class CustomTextFieldComponentTasks extends StatelessWidget {
  const CustomTextFieldComponentTasks({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.required = false,
    this.theme,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool required;

  /// Optional theme for this component. If null, uses [CustomTextFieldThemeTasks.fromContext].
  /// Tema opcional del componente. Si es null, usa [CustomTextFieldThemeTasks.fromContext].
  final CustomTextFieldThemeTasks? theme;

  @override
  Widget build(BuildContext context) {
    final CustomTextFieldThemeTasks resolvedTheme =
        theme ?? CustomTextFieldThemeTasks.fromContext(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: resolvedTheme.labelStyle,
            children: [
              if (required)
                TextSpan(
                  text: ' *',
                  style: resolvedTheme.labelStyle.copyWith(
                    color: resolvedTheme.requiredIndicatorColor,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: resolvedTheme.labelStyle,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: hint != null ? resolvedTheme.hintStyle : null,
            filled: true,
            fillColor: resolvedTheme.fillColor,
            contentPadding: resolvedTheme.contentPadding,
            border: resolvedTheme.border,
            enabledBorder: resolvedTheme.border,
            focusedBorder: resolvedTheme.focusedBorder,
          ),
        ),
      ],
    );
  }
}

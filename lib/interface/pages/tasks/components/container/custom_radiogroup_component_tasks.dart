import 'package:flutter/material.dart';

/// Theme data for [CustomRadioGroupComponentTasks].
/// Allows customizing group title, required indicator, and radio appearance.
///
/// Datos de tema para [CustomRadioGroupComponentTasks].
/// Permite personalizar título del grupo, indicador de requerido y apariencia del radio.
class CustomRadioGroupThemeTasks {
  const CustomRadioGroupThemeTasks({
    required this.titleStyle,
    required this.requiredIndicatorColor,
    required this.selectedColor,
    required this.unselectedColor,
    this.itemTextStyle,
  });

  /// Text style for the group title.
  /// Estilo de texto para el título del grupo.
  final TextStyle titleStyle;

  /// Color for the asterisk when the group is required.
  /// Color del asterisco cuando el grupo es requerido.
  final Color requiredIndicatorColor;

  /// Color of the radio when selected.
  /// Color del radio cuando está seleccionado.
  final Color selectedColor;

  /// Color of the radio when unselected.
  /// Color del radio cuando no está seleccionado.
  final Color unselectedColor;

  /// Text style for each radio option label. If null, uses [titleStyle].
  /// Estilo de texto para la etiqueta de cada opción. Si es null, usa [titleStyle].
  final TextStyle? itemTextStyle;

  /// Builds theme from the current app [ThemeData].
  /// Uses [RadioThemeData] and [TextTheme] for defaults.
  ///
  /// Construye el tema a partir del [ThemeData] actual de la app.
  /// Usa [RadioThemeData] y [TextTheme] para los valores por defecto.
  static CustomRadioGroupThemeTasks fromContext(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final RadioThemeData radioTheme = theme.radioTheme;
    final TextTheme textTheme = theme.textTheme;

    final Color selectedColor =
        radioTheme.fillColor?.resolve({WidgetState.selected}) ?? scheme.primary;
    final Color unselectedColor =
        radioTheme.fillColor?.resolve(const <WidgetState>{}) ?? scheme.outline;

    return CustomRadioGroupThemeTasks(
      titleStyle:
          textTheme.bodyLarge?.copyWith(color: scheme.onSurface) ??
          DefaultTextStyle.of(context).style.copyWith(color: scheme.onSurface),
      requiredIndicatorColor: scheme.error,
      selectedColor: selectedColor,
      unselectedColor: unselectedColor,
      itemTextStyle:
          textTheme.bodyMedium?.copyWith(color: scheme.onSurface) ??
          DefaultTextStyle.of(context).style.copyWith(color: scheme.onSurface),
    );
  }
}

/// Model for a single radio option.
///
/// Modelo para una opción del radio.
class CustomRadioItemModel<T> {
  const CustomRadioItemModel({
    required this.value,
    required this.label,
  });

  /// Value of this option.
  /// Valor de esta opción.
  final T value;

  /// Label text displayed next to the radio.
  /// Texto de etiqueta mostrado junto al radio.
  final String label;
}

/// Reusable radio group with title and optional required indicator.
/// Supports optional custom theme; otherwise uses app theme defaults.
///
/// Grupo de radios reutilizable con título e indicador opcional de requerido.
/// Admite tema personalizado opcional; si no se pasa, usa el tema actual de la app.
class CustomRadioGroupComponentTasks<T> extends StatelessWidget {
  const CustomRadioGroupComponentTasks({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    this.value,
    this.required = false,
    this.theme,
    this.direction = Axis.vertical,
  });

  /// Group title displayed above the radio options.
  /// Título del grupo mostrado sobre las opciones.
  final String title;

  /// List of radio options.
  /// Lista de opciones del radio.
  final List<CustomRadioItemModel<T>> items;

  /// Callback called when selection changes.
  /// Callback llamado cuando cambia la selección.
  final ValueChanged<T?> onChanged;

  /// Currently selected value.
  /// Valor actualmente seleccionado.
  final T? value;

  /// Whether the group is required (shows asterisk).
  /// Si el grupo es requerido (muestra asterisco).
  final bool required;

  /// Optional theme. If null, uses [CustomRadioGroupThemeTasks.fromContext].
  /// Tema opcional. Si es null, usa [CustomRadioGroupThemeTasks.fromContext].
  final CustomRadioGroupThemeTasks? theme;

  /// Layout direction of the radio options. Defaults to [Axis.vertical].
  /// Dirección del layout de las opciones. Por defecto [Axis.vertical].
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final CustomRadioGroupThemeTasks resolvedTheme =
        theme ?? CustomRadioGroupThemeTasks.fromContext(context);

    final List<Widget> radioWidgets = items
        .map(
          (item) => RadioListTile<T>(
            value: item.value,
            title: Text(
              item.label,
              style: resolvedTheme.itemTextStyle ?? resolvedTheme.titleStyle,
            ),
            activeColor: resolvedTheme.selectedColor,
            fillColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return resolvedTheme.selectedColor;
              }
              return resolvedTheme.unselectedColor;
            }),
          ),
        )
        .toList();

    final Widget radioContent = direction == Axis.vertical
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: radioWidgets,
          )
        : Wrap(
            spacing: 24,
            runSpacing: 8,
            children: radioWidgets.map((w) => SizedBox(width: 200, child: w)).toList(),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: resolvedTheme.titleStyle,
            children: [
              if (required)
                TextSpan(
                  text: ' *',
                  style: resolvedTheme.titleStyle.copyWith(
                    color: resolvedTheme.requiredIndicatorColor,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RadioGroup<T>(
          groupValue: value,
          onChanged: onChanged,
          child: radioContent,
        ),
      ],
    );
  }
}

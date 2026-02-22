import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Theme data for [CustomDateFieldComponentTasks].
/// Allows customizing label, required indicator, and input decoration.
///
/// Datos de tema para [CustomDateFieldComponentTasks].
/// Permite personalizar etiqueta, indicador de requerido y decoración del input.
class CustomDateFieldThemeTasks {
  const CustomDateFieldThemeTasks({
    required this.labelStyle,
    required this.requiredIndicatorColor,
    required this.fillColor,
    required this.contentPadding,
    required this.borderRadius,
    this.borderSide,
    this.enabledBorderSide,
    this.focusedBorderSide,
    this.hintStyle,
  });

  /// Text style for the label above the field.
  /// Estilo de texto para la etiqueta sobre el campo.
  final TextStyle labelStyle;

  /// Color for the asterisk when the field is required.
  /// Color del asterisco cuando el campo es requerido.
  final Color requiredIndicatorColor;

  /// Background color of the date field.
  /// Color de fondo del campo de fecha.
  final Color fillColor;

  /// Inner padding of the date field.
  /// Relleno interno del campo de fecha.
  final EdgeInsetsGeometry contentPadding;

  /// Border radius of the input.
  /// Radio del borde del input.
  final BorderRadius borderRadius;

  /// Border side for default/enabled state. If null, no border is drawn.
  /// Lado del borde para estado normal. Si es null, no se dibuja borde.
  final BorderSide? borderSide;

  /// Border side for enabled state. If null, uses [borderSide].
  /// Lado del borde para estado habilitado. Si es null, usa [borderSide].
  final BorderSide? enabledBorderSide;

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
  static CustomDateFieldThemeTasks fromContext(BuildContext context) {
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
    final BorderSide enabledSide =
        inputTheme.enabledBorder is OutlineInputBorder
        ? (inputTheme.enabledBorder as OutlineInputBorder).borderSide
        : BorderSide(color: scheme.outline.withValues(alpha: 0.5));
    final BorderSide focusedSide =
        inputTheme.focusedBorder is OutlineInputBorder
        ? (inputTheme.focusedBorder as OutlineInputBorder).borderSide
        : BorderSide(color: scheme.primary, width: 2);

    return CustomDateFieldThemeTasks(
      labelStyle:
          textTheme.bodyLarge?.copyWith(color: scheme.onSurface) ??
          DefaultTextStyle.of(context).style.copyWith(color: scheme.onSurface),
      requiredIndicatorColor: scheme.error,
      fillColor: fillColor,
      contentPadding: contentPadding,
      borderRadius: radius,
      borderSide: defaultSide,
      enabledBorderSide: enabledSide,
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

  /// Input border for enabled state.
  /// Borde del input para estado habilitado.
  InputBorder get enabledBorder => OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: enabledBorderSide ?? borderSide ?? BorderSide.none,
  );

  /// Input border for focused state.
  /// Borde del input para estado enfocado.
  InputBorder get focusedBorder => OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: focusedBorderSide ?? borderSide ?? BorderSide.none,
  );
}

/// Reusable date field with label and optional required indicator.
/// Supports optional custom theme; otherwise uses app theme defaults.
///
/// Campo de fecha reutilizable con etiqueta e indicador opcional de requerido.
/// Admite tema personalizado opcional; si no se pasa, usa el tema actual de la app.
class CustomDateFieldComponentTasks extends StatefulWidget {
  const CustomDateFieldComponentTasks({
    super.key,
    required this.label,
    required this.onDateSelected,
    this.hint,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
    this.required = false,
    this.theme,
  });

  /// Label text displayed above the field.
  /// Texto de etiqueta mostrado sobre el campo.
  final String label;

  /// Callback called when a date is selected.
  /// Callback llamado cuando se selecciona una fecha.
  final ValueChanged<DateTime?> onDateSelected;

  /// Hint text displayed when no date is selected.
  /// Texto de ayuda mostrado cuando no hay fecha seleccionada.
  final String? hint;

  /// Initially selected date.
  /// Fecha inicialmente seleccionada.
  final DateTime? initialDate;

  /// First selectable date. Defaults to 1900-01-01.
  /// Primera fecha seleccionable. Por defecto 1900-01-01.
  final DateTime? firstDate;

  /// Last selectable date. Defaults to 2100-12-31.
  /// Última fecha seleccionable. Por defecto 2100-12-31.
  final DateTime? lastDate;

  /// Date format for displaying the selected date. Defaults to 'dd/MM/yyyy'.
  /// Formato de fecha para mostrar la fecha seleccionada. Por defecto 'dd/MM/yyyy'.
  final DateFormat? dateFormat;

  /// Whether the field is required (shows asterisk).
  /// Si el campo es requerido (muestra asterisco).
  final bool required;

  /// Optional theme for this component. If null, uses [CustomDateFieldThemeTasks.fromContext].
  /// Tema opcional del componente. Si es null, usa [CustomDateFieldThemeTasks.fromContext].
  final CustomDateFieldThemeTasks? theme;

  @override
  State<CustomDateFieldComponentTasks> createState() =>
      _CustomDateFieldComponentTasksState();
}

class _CustomDateFieldComponentTasksState
    extends State<CustomDateFieldComponentTasks> {
  late TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _controller = TextEditingController(
      text: _selectedDate != null
          ? (widget.dateFormat ?? DateFormat('dd/MM/yyyy')).format(
              _selectedDate!,
            )
          : '',
    );
  }

  @override
  void didUpdateWidget(CustomDateFieldComponentTasks oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate) {
      _selectedDate = widget.initialDate;
      _controller.text = _selectedDate != null
          ? (widget.dateFormat ?? DateFormat('dd/MM/yyyy')).format(
              _selectedDate!,
            )
          : '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      locale: const Locale('es', 'ES'),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controller.text = (widget.dateFormat ?? DateFormat('dd/MM/yyyy'))
            .format(picked);
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final CustomDateFieldThemeTasks resolvedTheme =
        widget.theme ?? CustomDateFieldThemeTasks.fromContext(context);

    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: widget.label,
              style: resolvedTheme.labelStyle,
              children: [
                if (widget.required)
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
            controller: _controller,
            readOnly: true,
            style: resolvedTheme.labelStyle,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: widget.hint != null ? resolvedTheme.hintStyle : null,
              filled: true,
              fillColor: resolvedTheme.fillColor,
              contentPadding: resolvedTheme.contentPadding,
              border: resolvedTheme.border,
              enabledBorder: resolvedTheme.enabledBorder,
              focusedBorder: resolvedTheme.focusedBorder,
              suffixIcon: Icon(
                Icons.calendar_today,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            onTap: () => _selectDate(context),
          ),
        ],
      ),
    );
  }
}

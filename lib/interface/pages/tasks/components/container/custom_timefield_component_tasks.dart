import 'package:flutter/material.dart';

/// Theme data for [CustomTimeFieldComponentTasks].
/// Allows customizing label, required indicator, and input decoration.
///
/// Datos de tema para [CustomTimeFieldComponentTasks].
/// Permite personalizar etiqueta, indicador de requerido y decoración del input.
class CustomTimeFieldThemeTasks {
  const CustomTimeFieldThemeTasks({
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

  final TextStyle labelStyle;
  final Color requiredIndicatorColor;
  final Color fillColor;
  final EdgeInsetsGeometry contentPadding;
  final BorderRadius borderRadius;

  final BorderSide? borderSide;
  final BorderSide? enabledBorderSide;
  final BorderSide? focusedBorderSide;
  final TextStyle? hintStyle;

  static CustomTimeFieldThemeTasks fromContext(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final inputTheme = theme.inputDecorationTheme;
    final textTheme = theme.textTheme;

    final fillColor =
        inputTheme.fillColor ??
        scheme.surfaceContainerHighest.withValues(alpha: 0.5);

    final contentPadding =
        inputTheme.contentPadding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14);

    final outlineBorder = inputTheme.border is OutlineInputBorder
        ? inputTheme.border as OutlineInputBorder
        : null;

    final radius = outlineBorder?.borderRadius ?? BorderRadius.circular(12);

    final defaultSide = outlineBorder?.borderSide;

    final enabledSide = inputTheme.enabledBorder is OutlineInputBorder
        ? (inputTheme.enabledBorder as OutlineInputBorder).borderSide
        : BorderSide(color: scheme.outline.withValues(alpha: 0.5));

    final focusedSide = inputTheme.focusedBorder is OutlineInputBorder
        ? (inputTheme.focusedBorder as OutlineInputBorder).borderSide
        : BorderSide(color: scheme.primary, width: 2);

    return CustomTimeFieldThemeTasks(
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

  InputBorder get border => OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: borderSide ?? BorderSide.none,
  );

  InputBorder get enabledBorder => OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: enabledBorderSide ?? borderSide ?? BorderSide.none,
  );

  InputBorder get focusedBorder => OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: focusedBorderSide ?? borderSide ?? BorderSide.none,
  );
}

/// Reusable time field with label and optional required indicator.
/// Supports optional custom theme; otherwise uses app theme defaults.
///
/// Campo de tiempo reutilizable con etiqueta e indicador opcional de requerido.
/// Admite tema personalizado opcional; si no se pasa, usa el tema actual de la app.

class CustomTimeFieldComponentTasks extends StatefulWidget {
  const CustomTimeFieldComponentTasks({
    super.key,
    required this.label,
    required this.onTimeSelected,
    this.hint,
    this.initialTime,
    this.required = false,
    this.theme,
  });

  final String label;
  final ValueChanged<TimeOfDay?> onTimeSelected;
  final String? hint;
  final TimeOfDay? initialTime;
  final bool required;
  final CustomTimeFieldThemeTasks? theme;

  @override
  State<CustomTimeFieldComponentTasks> createState() =>
      _CustomTimeFieldComponentTasksState();
}

class _CustomTimeFieldComponentTasksState
    extends State<CustomTimeFieldComponentTasks> {
  late TextEditingController _controller;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_selectedTime != null) {
      _controller.text = _selectedTime!.format(context);
    }
  }

  @override
  void didUpdateWidget(covariant CustomTimeFieldComponentTasks oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialTime != oldWidget.initialTime) {
      _selectedTime = widget.initialTime;

      if (_selectedTime != null) {
        _controller.text = _selectedTime!.format(context);
      } else {
        _controller.text = '';
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _controller.text = picked.format(context);
      });

      widget.onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final resolvedTheme =
        widget.theme ?? CustomTimeFieldThemeTasks.fromContext(context);

    return Column(
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
              Icons.access_time,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          onTap: () => _selectTime(context),
        ),
      ],
    );
  }
}

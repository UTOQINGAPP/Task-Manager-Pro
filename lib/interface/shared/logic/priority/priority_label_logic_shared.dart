import 'package:task_manager_pro/configs/configs.dart';

/// Resolves priority localization keys to display strings using AppLocalizations.
/// La resolución de claves de prioridad a texto se hace solo en interface (sin lógica en core/infra).
abstract final class PriorityLabelLogicShared {
  PriorityLabelLogicShared._();

  /// Returns the localized display name for a priority key (e.g. low, medium, high).
  /// Devuelve el nombre localizado para la clave de prioridad (ej. low, medium, high).
  static String getDisplayName(
    InternationalizationLocalizations l10n,
    String localizationKey,
  ) {
    if (localizationKey.isEmpty) return '';
    switch (localizationKey) {
      case 'low':
        return l10n.priorityLow;
      case 'medium':
        return l10n.priorityMedium;
      case 'high':
        return l10n.priorityHigh;
      default:
        return localizationKey;
    }
  }
}

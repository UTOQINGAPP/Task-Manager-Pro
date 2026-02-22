import 'package:task_manager_pro/configs/configs.dart';

/// Resolves category localization keys to display strings using AppLocalizations.
/// La resolución de claves de categoría a texto se hace solo en interface (sin lógica en core/infra).
abstract final class CategoryLabelHelperShared {
  CategoryLabelHelperShared._();

  /// Returns the localized display name for a category key (e.g. personal, work, study).
  /// Devuelve el nombre localizado para la clave de categoría (ej. personal, work, study).
  static String getDisplayName(
    InternationalizationLocalizations l10n,
    String localizationKey,
  ) {
    if (localizationKey.isEmpty) return '';
    switch (localizationKey) {
      case 'personal':
        return l10n.categoryPersonal;
      case 'work':
        return l10n.categoryWork;
      case 'study':
        return l10n.categoryStudy;
      default:
        return localizationKey;
    }
  }
}

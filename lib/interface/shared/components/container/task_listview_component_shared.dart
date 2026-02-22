import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Models / Modelos
// ═══════════════════════════════════════════════════════════════════════════

/// Configuration for a chip displayed in a list item (e.g. category, priority).
/// Configuración de un chip mostrado en un ítem (ej. categoría, prioridad).
class ChipItemTaskListView {
  const ChipItemTaskListView({
    required this.label,
    this.backgroundColor,
    this.borderColor,
    this.shadowColor,
  });

  final String label;
  final Color? backgroundColor;
  final Color? borderColor;
  /// Used for Chip shadow (e.g. same as border for elevation).
  /// Usado para la sombra del Chip (ej. igual al borde para elevación).
  final Color? shadowColor;
}

/// Model for a single item in [TaskListViewComponentShared].
/// Modelo para un ítem en [TaskListViewComponentShared].
class ItemTaskListView {
  const ItemTaskListView({
    required this.id,
    required this.title,
    this.subtitle,
    this.gradientStartColor,
    this.gradientEndColor,
    this.leading,
    this.chips = const [],
    this.onTap,
    this.semanticsLabel,
  });

  final String id;
  final String title;
  final String? subtitle;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final Widget? leading;
  final List<ChipItemTaskListView> chips;
  final VoidCallback? onTap;
  final String? semanticsLabel;
}

// ═══════════════════════════════════════════════════════════════════════════
// Configuration / Configuración
// ═══════════════════════════════════════════════════════════════════════════

/// Theme and layout configuration for [TaskListViewComponentShared].
/// Configuración de tema y layout para [TaskListViewComponentShared].
class ConfigTaskListView {
  const ConfigTaskListView({
    this.subtitleMaxLength = 30,
    this.itemMargin = const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
    this.borderRadius = 12.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.skeletonItemCount = 5,
    this.listTransitionDuration = const Duration(milliseconds: 280),
    this.skeletonGradientStartColor,
    this.skeletonGradientEndColor,
  });

  /// Optional start color for skeleton gradient (alpha 0.3 applied).
  /// Color inicial opcional del gradiente del skeleton (se aplica alpha 0.3).
  final Color? skeletonGradientStartColor;

  /// Optional end color for skeleton gradient (alpha 0.3 applied).
  /// Color final opcional del gradiente del skeleton (se aplica alpha 0.3).
  final Color? skeletonGradientEndColor;

  /// Max characters for subtitle before truncation with ellipsis.
  /// Máximo de caracteres del subtítulo antes de truncar con ellipsis.
  final int subtitleMaxLength;

  final EdgeInsets itemMargin;
  final EdgeInsets itemPadding;
  final double borderRadius;
  final Duration animationDuration;
  final int skeletonItemCount;
  final Duration listTransitionDuration;
}

/// Labels and copy used by [TaskListViewComponentShared] (empty, error, refresh).
/// Etiquetas y textos usados por [TaskListViewComponentShared] (vacío, error, refrescar).
class StringsTaskListView {
  const StringsTaskListView({
    this.emptyTitle = 'No items',
    this.emptySubtitle = 'Add items to get started',
    this.errorTitle = 'Error loading',
    this.errorSubtitle,
    this.pullToRefresh = 'Pull to refresh',
    this.reload = 'Reload',
    this.placeholderSkeletonTitle = 'Title',
    this.placeholderSkeletonSubtitle = 'Description',
    this.skeletonChipLabels = const ['', '', ''],
  });

  final String emptyTitle;
  final String emptySubtitle;
  final String? errorSubtitle;
  final String errorTitle;
  final String pullToRefresh;
  final String reload;
  /// Skeleton list tile title placeholder.
  /// Placeholder del título en el skeleton.
  final String placeholderSkeletonTitle;
  /// Skeleton list tile subtitle placeholder.
  /// Placeholder del subtítulo en el skeleton.
  final String placeholderSkeletonSubtitle;
  /// Labels for the three skeleton chips (category, priority, date).
  /// Etiquetas para los tres chips del skeleton (categoría, prioridad, fecha).
  final List<String> skeletonChipLabels;
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared list view component / Componente de lista compartido
// ═══════════════════════════════════════════════════════════════════════════

/// Reusable list view that supports loading (skeleton), data, empty and error
/// states. No dependencies other than Flutter; all data and callbacks passed
/// via parameters.
///
/// Lista reutilizable que soporta estados de carga (skeleton), datos, vacío y
/// error. Sin dependencias aparte de Flutter; todos los datos y callbacks se
/// pasan por parámetros.
class TaskListViewComponentShared extends StatelessWidget {
  const TaskListViewComponentShared({
    super.key,
    required this.items,
    this.isLoading = false,
    this.error,
    this.onRefresh,
    this.onRetry,
    this.config = const ConfigTaskListView(),
    this.copy = const StringsTaskListView(),
    this.emptyIcon = Icons.inbox_outlined,
    this.errorIcon = Icons.error_outline,
  });

  final List<ItemTaskListView> items;
  final bool isLoading;
  final String? error;
  final Future<void> Function()? onRefresh;
  final VoidCallback? onRetry;
  final ConfigTaskListView config;
  final StringsTaskListView copy;
  final IconData emptyIcon;
  final IconData errorIcon;

  static String _truncate(String? text, int maxLength) {
    if (text == null || text.isEmpty) return '';
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = _buildContent(context);
    if (onRefresh != null) {
      return RefreshIndicator(onRefresh: onRefresh!, child: content);
    }
    return content;
  }

  Widget _buildContent(BuildContext context) {
    return AnimatedSwitcher(
      duration: config.animationDuration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0.0, 0.05),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),
            child: child,
          ),
        );
      },
      child: _stateChild(context),
    );
  }

  Widget _stateChild(BuildContext context) {
    if (isLoading) {
      return KeyedSubtree(
        key: const ValueKey<String>('loading'),
        child: _buildSkeletonList(context),
      );
    }
    if (error != null && error!.isNotEmpty) {
      return KeyedSubtree(
        key: const ValueKey<String>('error'),
        child: _buildErrorView(context),
      );
    }
    if (items.isEmpty) {
      return KeyedSubtree(
        key: const ValueKey<String>('empty'),
        child: _buildEmptyView(context),
      );
    }
    return KeyedSubtree(
      key: ValueKey<String>(
        'data-${items.length}-${items.map((e) => e.id).join('-')}',
      ),
      child: _buildListView(context),
    );
  }

  /// Skeleton list that mirrors the data list during loading state.
  /// Copied from task_list_view_tasks.dart _tasksListSkeletonView.
  /// Lista skeleton que replica la lista de datos durante la carga.
  Widget _buildSkeletonList(BuildContext context) {
    final Color startColor = (config.skeletonGradientStartColor ??
        const Color(0xFF9E9E9E)).withValues(alpha: 0.3);
    final Color endColor = (config.skeletonGradientEndColor ??
        const Color(0xFF9E9E9E)).withValues(alpha: 0.3);
    final String chip1 = copy.skeletonChipLabels.isNotEmpty
        ? copy.skeletonChipLabels.first
        : '';
    final String chip2 = copy.skeletonChipLabels.length >= 2
        ? copy.skeletonChipLabels[1]
        : '';
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: config.skeletonItemCount,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: config.itemMargin,
            padding: config.itemPadding,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [startColor, endColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(config.borderRadius),
            ),
            child: Card.filled(
              margin: EdgeInsets.zero,
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(config.borderRadius),
                side: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .outline
                      .withValues(alpha: 0.5),
                ),
              ),
              child: ListTile(
                title: Text(copy.placeholderSkeletonTitle),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(copy.placeholderSkeletonSubtitle),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Chip(label: Text(chip1)),
                        const SizedBox(width: 10),
                        Chip(label: Text(chip2)),
                        Chip(label: Text('')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return AnimatedSwitcher(
      duration: config.listTransitionDuration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0.0, 0.03),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),
            child: child,
          ),
        );
      },
      child: ListView.builder(
        key: ValueKey<String>(
          'list-${items.length}-${items.map((e) => e.id).join('-')}',
        ),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(context, items[index]);
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, ItemTaskListView item) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color rawStart =
        item.gradientStartColor ??
        colorScheme.primaryContainer;
    final Color rawEnd =
        item.gradientEndColor ??
        colorScheme.secondaryContainer;
    final Color startColor = rawStart.withValues(alpha: 0.3);
    final Color endColor = rawEnd.withValues(alpha: 0.3);

    return Container(
      key: Key(item.id),
      margin: config.itemMargin,
      padding: config.itemPadding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(config.borderRadius),
        boxShadow: [
          BoxShadow(
            color: rawStart.withValues(alpha: 0.1),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: rawEnd.withValues(alpha: 0.1),
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card.filled(
        margin: EdgeInsets.zero,
        color: colorScheme.surfaceContainerLow,
        elevation: 0.5,
        shadowColor: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(config.borderRadius),
          side: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
        child: Semantics(
          button: item.onTap != null,
          label: item.semanticsLabel ?? item.title,
          child: ListTile(
            onTap: item.onTap,
            leading: item.leading,
            title: Text(item.title),
            subtitle: item.subtitle != null || item.chips.isNotEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.subtitle != null)
                        Text(
                          _truncate(item.subtitle, config.subtitleMaxLength),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      if (item.chips.isNotEmpty) ...[
                        if (item.subtitle != null) const SizedBox(height: 4),
                        Wrap(
                          spacing: 10,
                          runSpacing: 2,
                          children: item.chips
                              .map(
                                (ChipItemTaskListView chip) {
                                  final Color bg = chip.backgroundColor ??
                                      colorScheme.surfaceContainerHighest;
                                  final Color border = chip.borderColor ?? bg;
                                  return Chip(
                                    elevation: 3,
                                    backgroundColor: bg.withValues(alpha: 0.2),
                                    shadowColor: chip.shadowColor ?? border,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        config.borderRadius,
                                      ),
                                      side: BorderSide(color: border),
                                    ),
                                    label: Text(chip.label),
                                  );
                                },
                              )
                              .toList(),
                        ),
                      ],
                    ],
                  )
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          child: Icon(emptyIcon, size: 50, color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 15),
        Text(
          copy.emptyTitle,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 15),
        Text(copy.emptySubtitle, style: textTheme.bodyLarge),
      ],
    );
  }

  Widget _buildErrorView(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final String errorMessage = error ?? copy.errorTitle;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.sizeOf(context).height * 0.6,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(errorIcon, size: 50, color: colorScheme.error),
            ),
            const SizedBox(height: 15),
            Text(
              copy.errorTitle,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                copy.errorSubtitle ?? errorMessage,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              copy.pullToRefresh,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(copy.reload),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

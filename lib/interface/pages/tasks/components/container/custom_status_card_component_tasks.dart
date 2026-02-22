import 'package:flutter/material.dart';

/// Status card widget for displaying task statistics.
/// Widget de tarjeta de estado para mostrar estadísticas de tareas.
class CustomStatusCardComponentTasks extends StatelessWidget {
  const CustomStatusCardComponentTasks({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 100,
      child: Card.filled(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: ListTile(
          title: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: Align(
            alignment: Alignment.topLeft,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0.0, 0.2),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOut,
                          ),
                        ),
                    child: child,
                  ),
                );
              },
              child: Text(
                value,
                key: ValueKey<String>(value),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          trailing: Column(children: [Icon(icon)]),
          onTap: onTap,
        ),
      ),
    );
  }
}

/// Error status card widget for displaying error state.
/// Widget de tarjeta de estado de error para mostrar estado de error.
class CustomErrorStatusCardComponentTasks extends StatelessWidget {
  const CustomErrorStatusCardComponentTasks({
    super.key,
    required this.onRetry,
    required this.errorLoadingText,
    required this.retryText,
  });

  final VoidCallback onRetry;
  final String errorLoadingText;
  final String retryText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 100,
      child: Card.filled(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Semantics(
          button: true,
          label: '$errorLoadingText. $retryText',
          child: InkWell(
            onTap: onRetry,
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    errorLoadingText,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    retryText,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

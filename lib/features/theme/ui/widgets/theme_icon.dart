import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class ThemeIcon extends ConsumerWidget {
  const ThemeIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeControllerProvider);
    final icon = _assignIcon(themeMode);

    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).preferredColor,
      ),
      child: Padding(
        padding: AppConstants.padding4,
        child: Icon(
          icon,
          color: Theme.of(context).foregroundColor,
        ),
      ),
    );
  }

  IconData _assignIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.brightness_high;
      case ThemeMode.dark:
        return Icons.brightness_3;
    }
  }
}

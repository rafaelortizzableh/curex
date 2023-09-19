import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/core.dart';
import 'features/features.dart';

class CurexApp extends ConsumerWidget {
  const CurexApp({super.key});

  static const appTitle = 'Curex';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeControllerProvider);
    final customTheme = ref.watch(customThemeProvider);
    final preferredColor = ref.watch(preferredColorControllerProvider);

    return MaterialApp.router(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: customTheme.lightTheme(preferredColor),
      darkTheme: customTheme.darkTheme(preferredColor),
      color: preferredColor,
      themeMode: themeMode,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}

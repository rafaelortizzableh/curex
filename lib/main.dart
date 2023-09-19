import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dependencies = await AppConfiguration.configureInitialDependencies();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesServiceProvider.overrideWithValue(
          SharedPreferencesService(
            dependencies.sharedPreferences,
          ),
        )
      ],
      child: const CurexApp(),
    ),
  );
}

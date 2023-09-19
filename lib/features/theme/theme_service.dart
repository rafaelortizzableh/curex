import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/core.dart';
import 'theme.dart';

/// The [Provider] for the [ThemeService].
final themeServiceProvider = Provider<ThemeService>(
  (ref) => ThemeService(ref.watch(sharedPreferencesServiceProvider)),
);

/// A service that stores and retrieves
/// the user's prefered theme mode and color locally.
class ThemeService {
  const ThemeService(this._sharedPreferencesService);

  final SharedPreferencesService _sharedPreferencesService;

  /// Loads the User's preferred ThemeMode from local or remote storage.
  ThemeMode getSavedThemeMode() {
    final savedThemeModeValue =
        _sharedPreferencesService.getStringFromSharedPreferences(
      ThemeConstants.selectedThemeKey,
    );

    return savedThemeModeValue.toThemeMode();
  }

  /// Saves the User's preferred ThemeMode to local storage.
  Future<bool> updateThemeMode(ThemeMode theme) async {
    switch (theme) {
      case ThemeMode.light:
        return await _sharedPreferencesService.save(
          ThemeConstants.selectedThemeKey,
          ThemeConstants.lightThemeMode,
        );
      case ThemeMode.dark:
        return await _sharedPreferencesService.save(
          ThemeConstants.selectedThemeKey,
          ThemeConstants.darkThemeMode,
        );
      case ThemeMode.system:
        return await _sharedPreferencesService.save(
          ThemeConstants.selectedThemeKey,
          ThemeConstants.systemThemeMode,
        );
    }
  }

  /// Saves the User's preferred [MaterialColor] to local storage.
  Future<bool> updatePreferredColor(MaterialColor color) async {
    return await _sharedPreferencesService.save(
      ThemeConstants.preferredColorKey,
      Colors.primaries.indexOf(color),
    );
  }

  /// Gets the User's preferred [MaterialColor] from local storage.
  MaterialColor getSavedPreferredColor() {
    final savedPreferredColorValue =
        _sharedPreferencesService.getIntFromSharedPreferences(
      ThemeConstants.preferredColorKey,
    );

    if (savedPreferredColorValue == null) {
      return Colors.deepPurple;
    }

    return Colors.primaries[savedPreferredColorValue];
  }
}

import 'package:curex/core/core.dart';
import 'package:curex/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('themeService', () {
    test(
      'Given a ThemeService, '
      'when updating the theme mode, '
      'then that theme should be saved to SharesPreferences.',
      () async {
        // Given
        SharedPreferences.setMockInitialValues({});
        final mockPreferences = await SharedPreferences.getInstance();
        final mockSharedPreferencesService =
            SharedPreferencesService(mockPreferences);
        final themeService = ThemeService(
          mockSharedPreferencesService,
        );

        const themeMode = ThemeMode.dark;

        // When
        await themeService.updateThemeMode(themeMode);

        // Then
        final savedTheme = mockSharedPreferencesService
            .getStringFromSharedPreferences(ThemeConstants.selectedThemeKey)
            .toThemeMode();
        expect(savedTheme, themeMode);
      },
    );

    test(
        'Given ThemeService, '
        'when getting the saved theme mode, '
        'then the correct theme mode should be returned.', () async {
      // Given
      SharedPreferences.setMockInitialValues({
        ThemeConstants.selectedThemeKey: ThemeConstants.darkThemeMode,
      });
      final mockPreferences = await SharedPreferences.getInstance();
      final mockSharedPreferencesService =
          SharedPreferencesService(mockPreferences);
      final themeService = ThemeService(
        mockSharedPreferencesService,
      );

      const themeMode = ThemeMode.dark;

      // When
      final savedTheme = themeService.getSavedThemeMode();

      // Then
      expect(savedTheme, themeMode);
    });

    test(
      'Given a ThemeService, '
      'when updating the preferred color, '
      'then that color should be saved to SharesPreferences.',
      () async {
        // Given
        SharedPreferences.setMockInitialValues({});
        final mockPreferences = await SharedPreferences.getInstance();
        final mockSharedPreferencesService =
            SharedPreferencesService(mockPreferences);
        final themeService = ThemeService(
          mockSharedPreferencesService,
        );

        const color = Colors.deepPurple;

        // When
        await themeService.updatePreferredColor(color);

        // Then
        final savedPreferredColorIndex = mockSharedPreferencesService
            .getIntFromSharedPreferences(ThemeConstants.preferredColorKey);
        final expectedColor = Colors.primaries[savedPreferredColorIndex!];
        expect(expectedColor, color);
      },
    );

    test(
        'Given a ThemeService, '
        'when getting the saved theme mode, '
        'then the correct theme mode should be returned.', () async {
      // Given
      SharedPreferences.setMockInitialValues({
        ThemeConstants.selectedThemeKey: ThemeConstants.darkThemeMode,
      });
      final mockPreferences = await SharedPreferences.getInstance();
      final mockSharedPreferencesService =
          SharedPreferencesService(mockPreferences);
      final themeService = ThemeService(
        mockSharedPreferencesService,
      );

      const themeMode = ThemeMode.dark;

      // When
      final savedTheme = themeService.getSavedThemeMode();

      // Then
      expect(savedTheme, themeMode);
    });
  });
}

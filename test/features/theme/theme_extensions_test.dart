import 'package:curex/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeModeExtension', () {
    test(
        'Given a dark mode string, '
        'when converting that string to a ThemeMode, '
        'then the correct ThemeMode should be returned', () {
      const darkModeString = ThemeConstants.darkThemeMode;
      const expectedThemeMode = ThemeMode.dark;

      final actualThemeMode = darkModeString.toThemeMode();

      expect(actualThemeMode, expectedThemeMode);
    });

    test(
        'Given a light mode string,'
        'when converting that string to a ThemeMode, '
        'then the correct ThemeMode should be returned.', () {
      const lightModeString = ThemeConstants.lightThemeMode;
      const expectedThemeMode = ThemeMode.light;

      final actualThemeMode = lightModeString.toThemeMode();

      expect(actualThemeMode, expectedThemeMode);
    });

    test(
        'Given a system mode string, '
        'when converting that string to a ThemeMode, '
        'then the correct ThemeMode should be returned', () {
      const systemModeString = ThemeConstants.systemThemeMode;
      const expectedThemeMode = ThemeMode.system;

      final actualThemeMode = systemModeString.toThemeMode();

      expect(actualThemeMode, expectedThemeMode);
    });
  });

  group('DisplayStringExtension', () {
    test(
        'Given a dark mode ThemeMode, '
        'when converting that ThemeMode to a display string, '
        'then the correct display string should be returned.', () {
      const darkMode = ThemeMode.dark;
      const expectedDisplayString = ThemeConstants.darkThemeModeDisplayString;

      final actualDisplayString = darkMode.toDisplayString();

      expect(actualDisplayString, expectedDisplayString);
    });

    test(
        'Given a light mode ThemeMode, '
        'when converting that ThemeMode to a display string, '
        'then the correct display string should be returned.', () {
      const lightMode = ThemeMode.light;
      const expectedDisplayString = ThemeConstants.lightThemeModeDisplayString;

      final actualDisplayString = lightMode.toDisplayString();

      expect(actualDisplayString, expectedDisplayString);
    });

    test(
        'Given a system mode ThemeMode, '
        'when converting that ThemeMode to a display string, '
        'then the correct display string should be returned.', () {
      const systemMode = ThemeMode.system;
      const expectedDisplayString = ThemeConstants.systemThemeModeDisplayString;

      final actualDisplayString = systemMode.toDisplayString();

      expect(actualDisplayString, expectedDisplayString);
    });
  });

  test(
    'Given a MaterialColor, '
    'when converting that MaterialColor to a display string, '
    'then the correct display string should be returned.',
    () {
      const materialColor = Colors.red;
      const expectedDisplayString = ThemeConstants.redThemeModeDisplayString;

      final actualDisplayString = materialColor.toDisplayString();

      expect(actualDisplayString, expectedDisplayString);
    },
  );

  test(
    'Given the list of primary colors, '
    'when converting each color to a display string, '
    'then the correct display string should be returned.',
    () {
      const expectedDisplayStrings = [
        ThemeConstants.redThemeModeDisplayString,
        ThemeConstants.pinkThemeModeDisplayString,
        ThemeConstants.purpleThemeModeDisplayString,
        ThemeConstants.deepPurpleThemeModeDisplayString,
        ThemeConstants.indigoThemeModeDisplayString,
        ThemeConstants.blueThemeModeDisplayString,
        ThemeConstants.lightBlueThemeModeDisplayString,
        ThemeConstants.cyanThemeModeDisplayString,
        ThemeConstants.tealThemeModeDisplayString,
        ThemeConstants.greenThemeModeDisplayString,
        ThemeConstants.lightGreenThemeModeDisplayString,
        ThemeConstants.limeThemeModeDisplayString,
        ThemeConstants.yellowThemeModeDisplayString,
        ThemeConstants.amberThemeModeDisplayString,
        ThemeConstants.orangeThemeModeDisplayString,
        ThemeConstants.deepOrangeThemeModeDisplayString,
        ThemeConstants.brownThemeModeDisplayString,
        ThemeConstants.blueGreyThemeModeDisplayString,
      ];

      final actualDisplayStrings = Colors.primaries
          .map((color) => color.toDisplayString())
          .toList(growable: false);

      expect(actualDisplayStrings, expectedDisplayStrings);
    },
  );
}

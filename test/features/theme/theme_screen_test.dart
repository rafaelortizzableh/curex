// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:curex/core/core.dart';
import 'package:curex/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/helpers.dart';

void main() {
  group('ThemeScreen', () {
    testWidgets(
        'Given a saved ThemeMode on Shared Preferences, '
        'when the screen is built, '
        'then the selected ThemeModeCard should be the saved ThemeMode.',
        (tester) async {
      SharedPreferences.setMockInitialValues({
        ThemeConstants.selectedThemeKey: ThemeConstants.darkThemeMode,
      });
      final sharedPreferences = await SharedPreferences.getInstance();
      final sharedPreferencesService = SharedPreferencesService(
        sharedPreferences,
      );

      await tester.pumpApp(
        sharedPreferencesService: sharedPreferencesService,
        ThemeScreen(),
      );

      // Find the ThemeModeCard that has isCurrentThemeMode set to true.
      final actual = find.byWidgetPredicate(
        (widget) =>
            widget is ThemeModeCard &&
            widget.isCurrentThemeMode == true &&
            widget.themeMode == ThemeMode.dark,
      );

      expect(actual, findsOneWidget);
    });

    testWidgets(
        'Given a saved MaterialColor on Shared Preferences, '
        'when the screen is built, '
        'then the equivalent ColorCard should be the selected card.',
        (tester) async {
      final redColor = Colors.primaries.first;
      SharedPreferences.setMockInitialValues({
        ThemeConstants.preferredColorKey: Colors.primaries.indexOf(redColor),
      });
      final sharedPreferences = await SharedPreferences.getInstance();
      final sharedPreferencesService = SharedPreferencesService(
        sharedPreferences,
      );

      await tester.pumpApp(
        sharedPreferencesService: sharedPreferencesService,
        ThemeScreen(),
      );

      // Find the ThemeModeCard that has isCurrentThemeMode set to true.
      final actual = find.byWidgetPredicate(
        (widget) =>
            widget is ColorCard &&
            widget.isPreferredColor == true &&
            widget.color == redColor,
      );

      expect(actual, findsOneWidget);
    });
  });

  testWidgets(
      'Given a ThemeModeController, '
      'when a ThemeMode is selected, '
      'then the brightness should be the selected ThemeMode\'s brightness.',
      (tester) async {
    final initiaThemeKey = ThemeConstants.darkThemeMode;

    SharedPreferences.setMockInitialValues({
      ThemeConstants.selectedThemeKey: initiaThemeKey,
    });
    final sharedPreferences = await SharedPreferences.getInstance();
    final sharedPreferencesService = SharedPreferencesService(
      sharedPreferences,
    );

    await tester.pumpApp(
      sharedPreferencesService: sharedPreferencesService,
      ThemeScreen(),
    );

    final allTiles = find.byType(ThemeModeCard);
    final lightModeTile = allTiles.at(1);

    await tester.tap(lightModeTile);

    await tester.pump();
    await tester.pumpAndSettle();

    final actual = sharedPreferences.getString(
      ThemeConstants.selectedThemeKey,
    )!;

    expect(actual, equals(ThemeConstants.lightThemeMode));
  });

  testWidgets(
      'Given a ColorController, '
      'when a Color is selected, '
      'then the selected color should be saved to Shared Preferences.',
      (tester) async {
    final redColorKey = 0;
    final pinkColor = Colors.primaries[1];

    SharedPreferences.setMockInitialValues({
      ThemeConstants.preferredColorKey: redColorKey,
    });
    final sharedPreferences = await SharedPreferences.getInstance();
    final sharedPreferencesService = SharedPreferencesService(
      sharedPreferences,
    );

    await tester.pumpApp(
      sharedPreferencesService: sharedPreferencesService,
      ThemeScreen(),
    );

    final pinkTile = find.byWidgetPredicate(
      (widget) => widget is ColorCard && widget.color == pinkColor,
    );

    await tester.tap(pinkTile);

    await tester.pump();
    await tester.pumpAndSettle();

    final actual = sharedPreferences.getInt(
      ThemeConstants.preferredColorKey,
    )!;

    final expectedColorKey = Colors.primaries.indexOf(pinkColor);

    expect(actual, equals(expectedColorKey));
  });
}

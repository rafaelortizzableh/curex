import 'package:flutter/material.dart';

import 'theme.dart';

extension ThemeModeExtension on String? {
  ThemeMode toThemeMode() {
    switch (this) {
      case ThemeConstants.lightThemeMode:
        return ThemeMode.light;
      case ThemeConstants.darkThemeMode:
        return ThemeMode.dark;
      case ThemeConstants.systemThemeMode:
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }
}

extension DisplayStringExtension on ThemeMode {
  String toDisplayString() {
    switch (this) {
      case ThemeMode.light:
        return ThemeConstants.lightThemeModeDisplayString;
      case ThemeMode.dark:
        return ThemeConstants.darkThemeModeDisplayString;
      case ThemeMode.system:
        return ThemeConstants.systemThemeModeDisplayString;
    }
  }
}

extension ColorDisplayStringExtension on MaterialColor {
  String toDisplayString() {
    if (!Colors.primaries.contains(this)) return 'Color';
    switch (this) {
      case Colors.red:
        return ThemeConstants.redThemeModeDisplayString;
      case Colors.pink:
        return ThemeConstants.pinkThemeModeDisplayString;
      case Colors.purple:
        return ThemeConstants.purpleThemeModeDisplayString;
      case Colors.deepPurple:
        return ThemeConstants.deepPurpleThemeModeDisplayString;
      case Colors.indigo:
        return ThemeConstants.indigoThemeModeDisplayString;
      case Colors.blue:
        return ThemeConstants.blueThemeModeDisplayString;
      case Colors.lightBlue:
        return ThemeConstants.lightBlueThemeModeDisplayString;
      case Colors.cyan:
        return ThemeConstants.cyanThemeModeDisplayString;
      case Colors.teal:
        return ThemeConstants.tealThemeModeDisplayString;
      case Colors.green:
        return ThemeConstants.greenThemeModeDisplayString;
      case Colors.lightGreen:
        return ThemeConstants.lightGreenThemeModeDisplayString;
      case Colors.lime:
        return ThemeConstants.limeThemeModeDisplayString;
      case Colors.yellow:
        return ThemeConstants.yellowThemeModeDisplayString;
      case Colors.amber:
        return ThemeConstants.amberThemeModeDisplayString;
      case Colors.orange:
        return ThemeConstants.orangeThemeModeDisplayString;
      case Colors.deepOrange:
        return ThemeConstants.deepOrangeThemeModeDisplayString;
      case Colors.brown:
        return ThemeConstants.brownThemeModeDisplayString;
      case Colors.blueGrey:
        return ThemeConstants.blueGreyThemeModeDisplayString;
      default:
        return 'Color';
    }
  }
}

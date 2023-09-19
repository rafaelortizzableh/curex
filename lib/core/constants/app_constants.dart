import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A collection of constants used across the app.
abstract class AppConstants {
  // Locale
  static const fallbackLocale = Locale('en');

  // Fallback user image
  static const fallbackUserImage =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Facebook_F8_Developer%27s_Conference_2017_%2833324520623%29.jpg/480px-Facebook_F8_Developer%27s_Conference_2017_%2833324520623%29.jpg';

  // Environment

  /// Whether the app is currently running in the test mode.
  static final isTestEnvironment = !kIsWeb &&
      Platform.environment.containsKey(
        'FLUTTER_TEST',
      );

  // Border Radius
  static const borderRadius4 = BorderRadius.all(circularRadius4);
  static const borderRadius8 = BorderRadius.all(circularRadius8);
  static const borderRadius12 = BorderRadius.all(circularRadius12);
  static const borderRadius16 = BorderRadius.all(circularRadius16);
  static const borderRadius32 = BorderRadius.all(circularRadius32);
  static const circularRadius4 = Radius.circular(4.0);
  static const circularRadius8 = Radius.circular(8.0);
  static const circularRadius12 = Radius.circular(12.0);
  static const circularRadius16 = Radius.circular(16.0);
  static const circularRadius32 = Radius.circular(32.0);

  static const roundedRectangleBorder12 = RoundedRectangleBorder(
    borderRadius: borderRadius12,
  );

  static const roundedRectangleVerticalBorder16 = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(spacing16),
    ),
  );

  // Spacing
  static const double spacing2 = 2.0;
  static const double spacing4 = 4.0;
  static const double spacing6 = 6.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing48 = 58.0;

  // Padding
  static const horizontalPadding4 = EdgeInsets.symmetric(horizontal: 4.0);
  static const horizontalPadding8 = EdgeInsets.symmetric(horizontal: 8.0);
  static const horizontalPadding12 = EdgeInsets.symmetric(horizontal: 12.0);
  static const horizontalPadding16 = EdgeInsets.symmetric(horizontal: 16.0);
  static const horizontalPadding24 = EdgeInsets.symmetric(horizontal: 24.0);
  static const horizontalPadding32 = EdgeInsets.symmetric(horizontal: 32.0);

  static const verticalPadding4 = EdgeInsets.symmetric(vertical: 4.0);
  static const verticalPadding8 = EdgeInsets.symmetric(vertical: 8.0);
  static const verticalPadding12 = EdgeInsets.symmetric(vertical: 12.0);
  static const verticalPadding16 = EdgeInsets.symmetric(vertical: 16.0);
  static const verticalPadding24 = EdgeInsets.symmetric(vertical: 24.0);
  static const verticalPadding32 = EdgeInsets.symmetric(vertical: 32.0);

  static const padding4 = EdgeInsets.all(4.0);
  static const padding8 = EdgeInsets.all(8.0);
  static const padding12 = EdgeInsets.all(12.0);
  static const padding16 = EdgeInsets.all(16.0);
  static const padding24 = EdgeInsets.all(24.0);
  static const padding32 = EdgeInsets.all(32.0);
}

import 'package:flutter/material.dart';

import 'constants.dart';

/// A collection of constant spacing widgets.
abstract class AppSpacing {
  // Empty Space
  static const emptySpace = SizedBox.shrink();

  // Horizontal Spacing
  static const horizontalSpacing2 = SizedBox(width: AppConstants.spacing2);
  static const horizontalSpacing4 = SizedBox(width: AppConstants.spacing4);
  static const horizontalSpacing8 = SizedBox(width: AppConstants.spacing8);
  static const horizontalSpacing12 = SizedBox(width: AppConstants.spacing12);
  static const horizontalSpacing16 = SizedBox(width: AppConstants.spacing16);
  static const horizontalSpacing24 = SizedBox(width: AppConstants.spacing24);

  // Vertical Spacing
  static const verticalSpacing2 = SizedBox(height: AppConstants.spacing2);
  static const verticalSpacing4 = SizedBox(height: AppConstants.spacing4);
  static const verticalSpacing8 = SizedBox(height: AppConstants.spacing8);
  static const verticalSpacing12 = SizedBox(height: AppConstants.spacing12);
  static const verticalSpacing16 = SizedBox(height: AppConstants.spacing16);
  static const verticalSpacing24 = SizedBox(height: AppConstants.spacing24);

  // Spacing
  static const spacing2 = SizedBox.square(dimension: AppConstants.spacing2);
  static const spacing4 = SizedBox.square(dimension: AppConstants.spacing4);
  static const spacing8 = SizedBox.square(dimension: AppConstants.spacing8);
  static const spacing12 = SizedBox.square(dimension: AppConstants.spacing12);
  static const spacing16 = SizedBox.square(dimension: AppConstants.spacing16);
  static const spacing24 = SizedBox.square(dimension: AppConstants.spacing24);
  static const spacing32 = SizedBox.square(dimension: AppConstants.spacing32);
  static const spacing48 = SizedBox.square(dimension: AppConstants.spacing48);
}

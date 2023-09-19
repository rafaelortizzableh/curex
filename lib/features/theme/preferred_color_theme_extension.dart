import 'package:flutter/material.dart';

@immutable
class PreferredColor extends ThemeExtension<PreferredColor> {
  const PreferredColor({
    required this.preferredColor,
  });

  final Color preferredColor;

  @override
  PreferredColor copyWith({Color? preferredColor}) {
    return PreferredColor(
      preferredColor: preferredColor ?? this.preferredColor,
    );
  }

  @override
  PreferredColor lerp(PreferredColor? other, double t) {
    if (other is! PreferredColor) {
      return this;
    }

    return PreferredColor(
      preferredColor:
          Color.lerp(preferredColor, other.preferredColor, t) ?? preferredColor,
    );
  }
}

extension PreferredColorExtension on ThemeData {
  Color get preferredColor => extension<PreferredColor>()!.preferredColor;
}

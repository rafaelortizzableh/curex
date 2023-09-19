import 'package:flutter/material.dart';

@immutable
class ForegroundColor extends ThemeExtension<ForegroundColor> {
  const ForegroundColor({
    required this.foregroundColor,
  });

  final Color? foregroundColor;

  @override
  ForegroundColor copyWith({Color? foregroundColor}) {
    return ForegroundColor(
      foregroundColor: foregroundColor ?? this.foregroundColor,
    );
  }

  @override
  ForegroundColor lerp(ForegroundColor? other, double t) {
    if (other is! ForegroundColor) {
      return this;
    }
    return ForegroundColor(
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
    );
  }
}

extension ForegroundColorExtension on ThemeData {
  Color get foregroundColor => extension<ForegroundColor>()!.foregroundColor!;
}

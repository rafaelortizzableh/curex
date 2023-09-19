import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  const AdaptiveButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.isLoading,
    required this.isDisabled,
    this.backgroundColor,
    this.padding,
    this.icon,
  });

  final VoidCallback onPressed;
  final Widget child;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final bool isLoading;
  final bool isDisabled;
  final Widget? icon;

  static const _defaultIconSize = 24.0;
  static const _defaultCupertinoPadding = EdgeInsets.all(16.0);

  factory AdaptiveButton.fromIconData(
    IconData iconData, {
    required VoidCallback onPressed,
    required Widget child,
    required bool isLoading,
    required bool isDisabled,
    Color? backgroundColor,
    EdgeInsets? padding,
  }) {
    return _AdaptiveButtonWithIcon(
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      backgroundColor: backgroundColor,
      padding: padding,
      icon: Icon(iconData),
      child: child,
    );
  }

  factory AdaptiveButton.withAssetImageIcon(
    String iconImageAsset, {
    required VoidCallback onPressed,
    required Widget child,
    required bool isLoading,
    required bool isDisabled,
    double iconSize = _defaultIconSize,
    Color? backgroundColor,
    EdgeInsets? padding,
  }) {
    return _AdaptiveButtonWithIcon(
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      backgroundColor: backgroundColor,
      padding: padding,
      icon: Image.asset(
        iconImageAsset,
        width: iconSize,
      ),
      child: child,
    );
  }
  factory AdaptiveButton.withNetworkImageIcon(
    String iconImageUrl, {
    required VoidCallback onPressed,
    required Widget child,
    required bool isLoading,
    required bool isDisabled,
    double iconSize = _defaultIconSize,
    Color? backgroundColor,
    EdgeInsets? padding,
  }) {
    return _AdaptiveButtonWithIcon(
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      backgroundColor: backgroundColor,
      padding: padding,
      icon: Image.network(
        iconImageUrl,
        width: iconSize,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final platform = theme.platform;
    final isCupertino = _isCupertino(platform);

    final child = _ButtonChild(
      icon: icon,
      child: this.child,
    );

    if (isCupertino) {
      return CupertinoButton(
        onPressed: !_isButtonDisabled ? onPressed : null,
        padding: padding,
        color: backgroundColor,
        child: child,
      );
    }

    return ElevatedButton(
      onPressed: !_isButtonDisabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        padding: padding,
        backgroundColor: backgroundColor,
      ),
      child: child,
    );
  }

  bool _isCupertino(TargetPlatform platform) {
    return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
  }

  bool get _isButtonDisabled => isDisabled || isLoading;
}

class _ButtonChild extends StatelessWidget {
  const _ButtonChild({
    required this.icon,
    required this.child,
  });

  final Widget? icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (icon == null) return child;
    final gap = _calculateGap(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon!,
        SizedBox(width: gap),
        Flexible(child: child),
      ],
    );
  }

  double _calculateGap(
    BuildContext context,
  ) {
    final scale = MediaQuery.textScaleFactorOf(context);
    final gap = scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1));
    if (gap == null) return 8.0;
    return gap.toDouble();
  }
}

class _AdaptiveButtonWithIcon extends AdaptiveButton {
  const _AdaptiveButtonWithIcon({
    super.backgroundColor,
    super.padding,
    required super.icon,
    required super.onPressed,
    required super.isLoading,
    required super.isDisabled,
    required super.child,
  });

  @override
  Widget build(BuildContext context) {
    final padding = _calculatePadding(context);
    return AdaptiveButton(
      padding: padding,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      isDisabled: isDisabled,
      isLoading: isLoading,
      icon: icon,
      key: key,
      child: child,
    );
  }

  EdgeInsets _calculatePadding(BuildContext context) {
    final isCupertino = _isCupertino(Theme.of(context).platform);
    if (isCupertino) {
      return AdaptiveButton._defaultCupertinoPadding;
    }

    final direction = Directionality.of(context);
    final scaledPadding = _calculateEdgeInsetsGeometry(context);
    return scaledPadding.resolve(direction);
  }

  EdgeInsetsGeometry _calculateEdgeInsetsGeometry(BuildContext context) {
    final useMaterial3 = Theme.of(context).useMaterial3;
    if (useMaterial3) {
      return _calculateMaterial3EdgeInsetsGeometry(context);
    }
    return _calculateDefaultEdgeInsetsGeometry(context);
  }

  EdgeInsetsGeometry _calculateMaterial3EdgeInsetsGeometry(
      BuildContext context) {
    final scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsetsDirectional.fromSTEB(16, 0, 24, 0),
      const EdgeInsetsDirectional.fromSTEB(8, 0, 12, 0),
      const EdgeInsetsDirectional.fromSTEB(4, 0, 6, 0),
      MediaQuery.textScaleFactorOf(context),
    );
    return scaledPadding;
  }

  EdgeInsetsGeometry _calculateDefaultEdgeInsetsGeometry(BuildContext context) {
    final scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsetsDirectional.fromSTEB(12, 0, 16, 0),
      const EdgeInsets.symmetric(horizontal: 8),
      const EdgeInsetsDirectional.fromSTEB(8, 0, 4, 0),
      MediaQuery.textScaleFactorOf(context),
    );
    return scaledPadding;
  }
}

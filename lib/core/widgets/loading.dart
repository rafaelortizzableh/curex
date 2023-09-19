import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/theme/theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const GenericLoader();
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});
  static const routeName = '/loading';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoadingWidget());
  }
}

class GenericLoader extends StatelessWidget {
  const GenericLoader({
    super.key,
    this.size = 32,
    this.color,
  });

  /// Size of the loading animation.
  ///
  /// Default is 32.
  final double size;

  /// Color of the loading animation.
  ///
  /// Default is based on the theme's color scheme.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final preferredColor = ref.watch(preferredColorControllerProvider);
      final loaderColor = color ?? preferredColor;
      return Center(
        child: _LoaderAnimation(
          size: size,
          color: loaderColor,
        ),
      );
    });
  }
}

class _LoaderAnimation extends StatefulWidget {
  const _LoaderAnimation({
    // ignore: unused_element
    super.key,
    this.size = 32,
    this.color = Colors.white,
  });

  /// Size of the Loading Animation
  ///
  /// Default is 32
  final double size;

  /// Color of the loading Animation
  ///
  /// Default is Colors.white
  final Color color;

  @override
  State<_LoaderAnimation> createState() => _LoaderAnimationState();
}

class _LoaderAnimationState extends State<_LoaderAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _sizeAnimation;
  static const _loaderAnimationDuration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _loaderAnimationDuration,
    )..repeat(reverse: true);

    final animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _opacityAnimation = Tween(begin: 0.25, end: 0.75).animate(animation);
    _sizeAnimation = Tween(begin: 1.0, end: 0.44).animate(animation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeValue = widget.size * _sizeAnimation.value;

    return SizedBox.fromSize(
      size: Size.square(sizeValue),
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: ScaleTransition(
          scale: _sizeAnimation,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

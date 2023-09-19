import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import '../../features/features.dart';

class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({
    super.key,
    required this.name,
  });
  final String? name;

  static const routeName = '/404';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _unknownPageTitle(
                name: name,
              ),
            ),
            AdaptiveButton.fromIconData(
              Icons.home,
              onPressed: () {
                context.go(HomeScreen.routeName);
              },
              isLoading: false,
              isDisabled: false,
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }

  String _unknownPageTitle({
    String? name,
  }) {
    if (name == null) {
      return 'Unknown Page';
    }

    return 'Unknown Page: $name';
  }
}

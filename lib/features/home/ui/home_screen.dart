import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../../features.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.monetization_on,
            ),
            AppSpacing.horizontalSpacing16,
            Text('Currency Exhange Rates'),
          ],
        ),
        actions: [
          IconButton(
            icon: const ThemeIcon(),
            onPressed: () {
              context.pushNamed(ThemeScreen.routeName);
            },
          ),
        ],
      ),
      body: const CurrencyTilesList(),
    );
  }
}

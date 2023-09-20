import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: _assignSystemUiOverlayStyle(
          theme.colorScheme.background,
        ),
        backgroundColor: theme.colorScheme.background,
        title: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: AppConstants.borderRadius8,
            color: theme.preferredColor,
          ),
          child: Padding(
            padding: AppConstants.padding8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.monetization_on_outlined),
                AppSpacing.horizontalSpacing16,
                Text(
                  'Currency Exhange Rates',
                  style: _assignAppBarTextStyle(theme),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const ThemeIcon(),
            onPressed: () => context.pushNamed(
              ThemeScreen.routeName,
            ),
          ),
        ],
      ),
      body: const CurrencyTilesList(),
    );
  }

  TextStyle? _assignAppBarTextStyle(
    ThemeData theme,
  ) {
    return theme.textTheme.titleSmall?.copyWith(
      color: theme.foregroundColor,
    );
  }

  SystemUiOverlayStyle _assignSystemUiOverlayStyle(
    Color backgroundColor,
  ) {
    return backgroundColor.computeLuminance() > 0.5
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;
  }
}

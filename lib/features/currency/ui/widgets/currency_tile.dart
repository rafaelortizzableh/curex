import 'package:curex/features/theme/foreground_color_theme_extension.dart';
import 'package:curex/features/theme/preferred_color_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../../currency.dart';

class CurrencyTile extends StatelessWidget {
  const CurrencyTile({
    super.key,
    required this.currency,
  });
  final CurrencyModel currency;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTileTheme(
      contentPadding: EdgeInsets.zero,
      child: Card(
        child: ListTile(
          onTap: () => _navigateToDetailScreen(context),
          leading: Padding(
            padding: const EdgeInsets.only(left: AppConstants.spacing8),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.preferredColor,
                borderRadius: AppConstants.borderRadius8,
              ),
              child: Padding(
                padding: AppConstants.padding8,
                child: Text(
                  currency.currencyCode,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.foregroundColor,
                  ),
                ),
              ),
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(
              right: AppConstants.spacing8,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: AppConstants.borderRadius8,
                color: _trailingColor,
              ),
              child: Padding(
                padding: AppConstants.padding8,
                child: Icon(
                  _hasDecreasedIcon,
                  color: Colors.white,
                  size: theme.textTheme.titleMedium!.fontSize! * 2,
                ),
              ),
            ),
          ),
          title: Text(
            currency.currencyName,
          ),
          subtitle: Text(
            'Exchange Rate: ${currency.currentExhangeRateLabel}',
          ),
        ),
      ),
    );
  }

  IconData get _hasDecreasedIcon {
    return currency.hasDecreased ? Icons.arrow_downward : Icons.arrow_upward;
  }

  Color get _trailingColor {
    return currency.hasDecreased ? Colors.red : Colors.green;
  }

  void _navigateToDetailScreen(BuildContext context) {
    context.pushNamed(
      CurrencyDetailScreen.routeName,
      queryParameters: {
        CurrencyDetailScreen.currencyIdParameterName: currency.currencyCode,
      },
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';
import '../../features.dart';

class CurrencyDetailScreen extends HookConsumerWidget {
  const CurrencyDetailScreen({
    super.key,
    required this.currencyId,
  });
  final String? currencyId;

  static const routeName = '/currency/detail';
  static const currencyIdParameterName = 'currencyId';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final currency = ref.watch(
      selectedCurrencyControllerProvider(currencyId).select(
        (value) => value.maybeWhen(
          data: (currency) => currency,
          orElse: () => null,
        ),
      ),
    );

    if (currency == null) {
      return const _NoCurrencyFoundError();
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        shadowColor: theme.colorScheme.background,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: const CloseButton(),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: AppConstants.circularRadius32,
            topLeft: AppConstants.circularRadius32,
          ),
        ),
        title: Text(
          currency.currencyCode,
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ColoredBox(
                  color: theme.colorScheme.background,
                ),
              ),
            ],
          ),
          RefreshIndicator(
            color: Theme.of(context).foregroundColor,
            backgroundColor: Theme.of(context).preferredColor,
            onRefresh: () async => await _onRetry(ref),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: AppConstants.padding8,
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Today\'s Exhange Rate',
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: AppConstants.padding8,
                  sliver: SliverToBoxAdapter(
                    child: AnimatedSwitcher(
                      duration: const Duration(seconds: 1),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: Text(
                        currency.currentExhangeRateLabel,
                        key: ObjectKey(
                          'currency_current_exchange_rate_${currency.currentExhangeRateLabel}',
                        ),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: AppConstants.padding8,
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Description',
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: AppConstants.padding8,
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      currency.description,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacing16,
                    vertical: AppConstants.spacing8,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Historical Exchange Rates',
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacing16,
                    vertical: AppConstants.spacing16,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: CurrencyHistoricalExchangeChart(
                      currency: currency,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onRetry(WidgetRef ref) async {
    if (currencyId == null) {
      return;
    }
    return await ref
        .read(
          selectedCurrencyControllerProvider(currencyId).notifier,
        )
        .loadSelectedCurrency();
  }
}

class _NoCurrencyFoundError extends StatelessWidget {
  const _NoCurrencyFoundError({
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: AppColors.errorRed,
        shadowColor: theme.colorScheme.background,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: const CloseButton(
          color: Colors.white,
        ),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: AppConstants.circularRadius32,
            topLeft: AppConstants.circularRadius32,
          ),
        ),
        title: const Text(
          'Error',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: GenericError(
        errorText: 'No currency found.',
        onRetry: () => Navigator.pop(context),
      ),
    );
  }
}

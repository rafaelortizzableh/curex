import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

final _currenciesListError = Provider.autoDispose<Exception?>((ref) {
  // final error = ref.watch(currencyControllerProvider.select(
  //   (value) => value.currencies.maybeWhen(
  //     error: (error, _) => error,
  //     orElse: () => null,
  //   ),
  // ));

  // return error;
  return null;
});

final _isLoadingCurrenciesProvider = Provider.autoDispose<bool>((ref) {
  // final isLoading = ref.watch(currencyControllerProvider.select(
  //   (value) => value.currencies.maybeWhen(
  //     loading: () => true,
  //     orElse: () => false,
  //   ),
  // ));

  // return isLoading;
  return false;
});

final _currenciesListProvider =
    Provider.autoDispose<List<CurrencyModel>>(((ref) {
  // final currencies = ref.watch(currencyControllerProvider.select(
  //   (value) => value.currencies.asData?.value ?? [],
  // ));

  // return currencies.toList();
  return [
    const CurrencyModel(
      currencyCode: 'USD',
      currencyName: 'United States Dollar',
      latestExchangeRate: 1.0,
      historicalExchangeRates: {},
      description: 'The US dollar',
    ),
    CurrencyModel(
      currencyCode: 'EUR',
      currencyName: 'Euro',
      historicalExchangeRates: {
        DateTime.now().subtract(const Duration(days: 1)): 0.8,
        DateTime.now().subtract(const Duration(days: 2)): 0.9,
        DateTime.now().subtract(const Duration(days: 3)): 0.7,
        DateTime.now().subtract(const Duration(days: 4)): 0.8,
        DateTime.now().subtract(const Duration(days: 5)): 0.7,
        DateTime.now().subtract(const Duration(days: 6)): 0.6,
        DateTime.now().subtract(const Duration(days: 7)): 0.65,
        DateTime.now().subtract(const Duration(days: 8)): 0.7,
        DateTime.now().subtract(const Duration(days: 9)): 0.85,
        DateTime.now().subtract(const Duration(days: 10)): 0.9,
      },
      latestExchangeRate: 0.90,
      description: 'The Euro',
    ),
  ];
}));

class CurrencyTilesList extends HookConsumerWidget {
  const CurrencyTilesList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(_isLoadingCurrenciesProvider);
    if (isLoading) {
      return const GenericLoader();
    }
    final error = ref.watch(_currenciesListError);

    if (error != null) {
      return GenericError(
        errorText: error.toString(),
        onRetry: () => _onRetry(ref),
      );
    }

    final currenciesList = ref.watch(_currenciesListProvider);

    return ListView.separated(
      padding: AppConstants.padding8,
      separatorBuilder: (_, __) => AppSpacing.verticalSpacing2,
      itemCount: currenciesList.length,
      itemBuilder: (context, index) {
        final currency = ref.watch(_currenciesListProvider)[index];
        return CurrencyTile(currency: currency);
      },
    );
  }

  void _onRetry(WidgetRef ref) {
    // ref.read(currencyControllerProvider.notifier).getCurrencies();
  }
}

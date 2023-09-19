import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

final _currenciesListError = Provider.autoDispose<Exception?>((ref) {
  final error = ref.watch(currencyControllerProvider.select(
    (value) => value.currencies.maybeWhen(
      error: (error, _) => error,
      orElse: () => null,
    ),
  ));

  if (error == null) return null;

  if (error is! Exception) return Exception(error);

  return error;
});

final _isLoadingCurrenciesProvider = Provider.autoDispose<bool>((ref) {
  final isLoading = ref.watch(currencyControllerProvider.select(
    (value) => value.currencies.maybeWhen(
      loading: () => true,
      orElse: () => false,
    ),
  ));

  return isLoading;
});

final _currenciesListProvider =
    Provider.autoDispose<List<CurrencyModel>>(((ref) {
  final currencies = ref.watch(currencyControllerProvider.select(
    (value) => value.currencies.asData?.value ?? <CurrencyModel>{},
  ));

  return currencies.toList();
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
        onRetry: () => unawaited(_onRetry(ref)),
      );
    }

    final currenciesList = ref.watch(_currenciesListProvider);

    return RefreshIndicator(
      color: Theme.of(context).foregroundColor,
      backgroundColor: Theme.of(context).preferredColor,
      onRefresh: () async => await _onRetry(ref),
      child: ListView.separated(
        padding: AppConstants.padding8,
        separatorBuilder: (_, __) => AppSpacing.verticalSpacing2,
        itemCount: currenciesList.length,
        itemBuilder: (context, index) {
          final currency = ref.watch(_currenciesListProvider)[index];
          return CurrencyTile(currency: currency);
        },
      ),
    );
  }

  Future<void> _onRetry(WidgetRef ref) async {
    return await ref.read(currencyControllerProvider.notifier).loadCurrencies();
  }
}

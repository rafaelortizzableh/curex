import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'currency.dart';

final selectedCurrencyControllerProvider = StateNotifierProvider.autoDispose
    .family<SelectedCurrencyController, AsyncValue<CurrencyModel>, String?>(
  (ref, currencyCode) {
    return SelectedCurrencyController(ref, currencyCode);
  },
);

class SelectedCurrencyController
    extends StateNotifier<AsyncValue<CurrencyModel>> {
  SelectedCurrencyController(
    this._ref,
    this._currencyCode,
  ) : super(_initialState(_ref, _currencyCode)) {
    unawaited(_loadSelectedCurrency());
  }

  final Ref _ref;
  final String? _currencyCode;

  static AsyncValue<CurrencyModel> _initialState(
      Ref ref, String? currencyCode) {
    // If currencyCode is null, then we will use the selectedCurrencyCode
    // from the CurrencyController.
    final code = currencyCode ??
        ref.read(
          currencyControllerProvider.select(
            (value) => value.selectedCurrencyCode,
          ),
        );
    final currencies = ref.read(currencyControllerProvider.select(
      (value) => value.currencies.asData?.value,
    ));

    final selectedCurrency = currencies?.firstWhere(
      (element) => element.currencyCode == code,
    );

    if (selectedCurrency == null) {
      return const AsyncValue.loading();
    }

    return AsyncValue.data(selectedCurrency);
  }

  Future<void> _loadSelectedCurrency() async {
    if (_currencyCode == null) return;
    final selectedCurrency =
        await _ref.read(currencyServiceProvider).getCurrency(
              _currencyCode!,
            );

    state = AsyncValue.data(selectedCurrency);
  }
}

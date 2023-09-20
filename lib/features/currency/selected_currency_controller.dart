import 'dart:async';

import 'package:collection/collection.dart';
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
    unawaited(loadSelectedCurrency());
  }

  final Ref _ref;
  final String? _currencyCode;

  @override
  void dispose() {
    _ref.read(currencyControllerProvider.notifier).clearSelectedCurrency();
    super.dispose();
  }

  static AsyncValue<CurrencyModel> _initialState(
    Ref ref,
    String? currencyCode,
  ) {
    // If `currencyCode` is null, then we will use the `selectedCurrencyCode`
    // from the `CurrencyController`.
    final code = currencyCode ??
        ref.read(
          currencyControllerProvider.select(
            (value) => value.selectedCurrencyCode,
          ),
        );
    final currencies = ref.read(currencyControllerProvider.select(
      (value) => value.currencies.asData?.value,
    ));

    final selectedCurrency = currencies?.firstWhereOrNull(
      (element) => element.currencyCode == code,
    );

    if (selectedCurrency == null) {
      return const AsyncValue.loading();
    }

    return AsyncValue.data(selectedCurrency);
  }

  Future<void> loadSelectedCurrency() async {
    if (_currencyCode == null) return;
    try {
      final selectedCurrency =
          await _ref.read(currencyServiceProvider).getCurrency(
                _currencyCode!,
              );
      if (!mounted) return;
      state = AsyncValue.data(selectedCurrency);
    } on RandomValuesCurrencyServiceException catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'currency.dart';

final currencyControllerProvider =
    StateNotifierProvider.autoDispose<CurrencyController, CurrencyState>(
  (ref) => CurrencyController(
    CurrencyState.loading(),
    ref,
  ),
);

class CurrencyController extends StateNotifier<CurrencyState> {
  CurrencyController(
    super.state,
    this._ref,
  ) {
    unawaited(loadCurrencies());
  }

  final Ref _ref;

  CurrencyService get _currencyService => _ref.read(currencyServiceProvider);

  Future<void> loadCurrencies() async {
    try {
      final currencies = await _currencyService.getCurrencies();
      state = CurrencyState(
        currencies: AsyncValue.data(currencies),
        selectedCurrencyCode: state.selectedCurrencyCode,
      );
    } on RandomValuesCurrencyServiceException catch (e, stackTrace) {
      state = state.copyWith(
        currencies: AsyncValue.error(e, stackTrace),
      );
    }
  }

  void setSelectedCurrencyCode(String currencyCode) {
    state = state.copyWith(
      selectedCurrencyCode: currencyCode,
    );
  }

  void clearSelectedCurrency() {
    state = state.clearSelectedCurrency();
  }
}

class CurrencyState extends Equatable {
  const CurrencyState({
    required this.currencies,
    this.selectedCurrencyCode,
  });

  final AsyncValue<Set<CurrencyModel>> currencies;
  final String? selectedCurrencyCode;

  factory CurrencyState.loading() => const CurrencyState(
        currencies: AsyncValue.loading(),
        selectedCurrencyCode: null,
      );

  CurrencyState copyWith({
    AsyncValue<Set<CurrencyModel>>? currencies,
    String? selectedCurrencyCode,
  }) {
    return CurrencyState(
      currencies: currencies ?? this.currencies,
      selectedCurrencyCode: selectedCurrencyCode ?? this.selectedCurrencyCode,
    );
  }

  CurrencyState clearSelectedCurrency() {
    return CurrencyState(
      currencies: currencies,
      selectedCurrencyCode: null,
    );
  }

  @override
  List<Object?> get props => [currencies, selectedCurrencyCode];
}

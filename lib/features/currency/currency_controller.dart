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

  Future<void> loadCurrencies() async {
    final currencies = await _ref.read(currencyServiceProvider).getCurrencies();
    state = CurrencyState(
      currencies: AsyncValue.data(currencies),
      selectedCurrencyCode: state.selectedCurrencyCode,
    );
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

  @override
  List<Object?> get props => [currencies, selectedCurrencyCode];
}

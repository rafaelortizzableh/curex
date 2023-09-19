import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'currency.dart';

/// This provider is used to provide the [CurrencyService].
final currencyServiceProvider = Provider.autoDispose<CurrencyService>(
  (ref) {
    if (!CurrencyService._shouldUseRandomValuesCurrencyService) {
      // TODO(rafaelortizzableh): Implement an alternative currency service.
      throw UnimplementedError(
        'Only the random values currency service is implemented.',
      );
    }

    return RandomValuesCurrencyService(ref);
  },
);

abstract class CurrencyService {
  Future<Set<CurrencyModel>> getCurrencies();
  Future<CurrencyModel> getCurrency(String currencyCode);

  static const _currencyServiceToUse =
      String.fromEnvironment('CURRENCY_SERVICE_TO_USE');

  static const _shouldUseRandomValuesCurrencyService =
      _currencyServiceToUse == 'random';
}

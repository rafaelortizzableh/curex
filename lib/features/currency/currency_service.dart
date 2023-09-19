import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'currency.dart';

final currencyServiceProvider = Provider.autoDispose<CurrencyService>(
  (ref) => CurrencyService(),
);

class CurrencyService {
  // TODO(rafaelortizzableh): Implement this method.
  Future<Set<CurrencyModel>> getCurrencies() async {
    return {};
  }
}

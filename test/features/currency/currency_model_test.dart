import 'package:curex/features/features.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyModel', () {
    test('can be (de)serialized from Random Exchange Rate', () {
      final mapExchangeRates = [1.32, 0.9, 1.0, 1.1];

      final map = {
        '__typename': 'ExchangeRate',
        'code': 'EUR',
        'description':
            'The euro (symbol: €; code: EUR) is the official currency of 19 out of the 27 member states of the European Union (EU). This group of states is known as the eurozone or, officially, the euro area, and includes about 340 million citizens as of 2019. The euro is divided into 100 cents.',
        'rates': [
          for (final i in mapExchangeRates) i,
        ],
      };

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final expectedCurrency = CurrencyModel(
        currencyCode: 'EUR',
        currencyName: 'The euro',
        description:
            'The euro (symbol: €; code: EUR) is the official currency of 19 out of the 27 member states of the European Union (EU). This group of states is known as the eurozone or, officially, the euro area, and includes about 340 million citizens as of 2019. The euro is divided into 100 cents.',
        latestExchangeRate: 1.1,
        historicalExchangeRates: {
          today.subtract(const Duration(days: 3)): 1.32,
          today.subtract(const Duration(days: 2)): 0.9,
          today.subtract(const Duration(days: 1)): 1.0,
        },
      );

      final newCurrency = CurrencyModel.fromRandomExchangeRate(map);

      expect(expectedCurrency, equals(newCurrency));
    });

    test(
      'Given a list of exchange rates that starts from the oldest value and ends with today\'s value, '
      'When the list is parsed, '
      'Then a map of historical exchange rates in chronological order without today`s value should be returned',
      () {
        final fakeExchangeRates = [
          9.15,
          9.14,
          9.13,
          9.12,
          9.16,
        ];

        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final expectedHistoricalExchangeRates = {
          today.subtract(const Duration(days: 4)): 9.15,
          today.subtract(const Duration(days: 3)): 9.14,
          today.subtract(const Duration(days: 2)): 9.13,
          today.subtract(const Duration(days: 1)): 9.12,
        };

        final historicalExchangeRates =
            CurrencyModel.parseHistoricalExchangeRates(
          fakeExchangeRates,
        );

        expect(
          historicalExchangeRates,
          equals(expectedHistoricalExchangeRates),
        );
      },
    );

    test(
      'Given a long description with a parenthesis, '
      'when the description is parsed, '
      'then, the currency name should be returned',
      () {
        const description =
            'The euro (symbol: €; code: EUR) is the official currency of 19 out of the 27 member states of the European Union (EU). This group of states is known as the eurozone or, officially, the euro area, and includes about 340 million citizens as of 2019. The euro is divided into 100 cents.';

        final currencyName = CurrencyModel.parseCurrencyName(
          description,
          'EUR',
        );

        expect(currencyName, equals('The euro'));
      },
    );

    test(
      'Given a long description without a parenthesis, '
      'when the description is parsed, '
      'then, the currency code should be returned',
      () {
        const description =
            'The Swiss franc is the currency and legal tender of Switzerland and Liechtenstein. It is also legal tender in the Italian exclave of Campione d\'Italia which is surrounded by Swiss territory. The Swiss National Bank (SNB) issues banknotes and the federal mint Swissmint issues coins.';

        final currencyName = CurrencyModel.parseCurrencyName(
          description,
          'CHF',
        );

        expect(currencyName, equals('CHF'));
      },
    );
  });
}

import 'package:curex/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group(
    'CurrencyController',
    () {
      test(
        'Given a currency service, '
        'when the controller is created, '
        'then the currencies should be fetched',
        () async {
          final fakeCurrenciesList = [
            CurrencyModel(
              currencyCode: 'COP',
              currencyName: 'Colombian Peso',
              description: 'Colombian Peso',
              latestExchangeRate: 0.00026,
              historicalExchangeRates: {
                DateTime(2023, 1, 1): 1.0,
                DateTime(2023, 1, 2): 1.1,
                DateTime(2023, 1, 3): 0.9,
              },
            ),
            CurrencyModel(
              currencyCode: 'EUR',
              currencyName: 'Euro',
              description: 'European Euro',
              latestExchangeRate: 0.8,
              historicalExchangeRates: {
                DateTime(2023, 1, 1): 0.8,
                DateTime(2023, 1, 2): 0.9,
                DateTime(2023, 1, 3): 0.7,
              },
            ),
          ];

          final mockCurrencyService = MockCurrencyService();

          when(() => mockCurrencyService.getCurrencies())
              .thenAnswer((invocation) => Future.value(
                    fakeCurrenciesList.toSet(),
                  ));

          final container = ProviderContainer(
            overrides: [
              currencyControllerProvider.overrideWith(
                (ref) {
                  // Keep the provider alive so that we can test it.
                  ref.keepAlive();
                  return CurrencyController(CurrencyState.loading(), ref);
                },
              ),
              currencyServiceProvider.overrideWithValue(mockCurrencyService),
            ],
          );

          addTearDown(container.dispose);

          final controller =
              container.read(currencyControllerProvider.notifier);
          final initialState = container.read(currencyControllerProvider);

          expect(
            initialState,
            isA<CurrencyState>(),
          );

          final state = await controller.stream.firstWhere(
            (state) => state.currencies is AsyncData,
          );

          final expectedCurrencies = state.currencies.asData?.value.toList();

          expect(
            expectedCurrencies,
            fakeCurrenciesList,
          );
        },
      );
    },
  );
}

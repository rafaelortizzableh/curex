import 'package:curex/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group(
    'SelectedCurrencyController',
    () {
      test(
        'Given a currency and no previously fetched currencies, '
        'when the controller is created, '
        'then the currency should be fetched',
        () async {
          final fakeCurrency = CurrencyModel(
            currencyCode: 'EUR',
            currencyName: 'Euro',
            description: 'European Euro',
            latestExchangeRate: 0.8,
            historicalExchangeRates: {
              DateTime(2023, 1, 1): 0.8,
              DateTime(2023, 1, 2): 0.9,
              DateTime(2023, 1, 3): 0.7,
            },
          );

          final mockCurrencyService = MockCurrencyService();

          when(() => mockCurrencyService.getCurrency(
                'EUR',
              )).thenAnswer((invocation) => Future.value(
                fakeCurrency,
              ));

          when(() => mockCurrencyService.getCurrencies())
              .thenAnswer((invocation) => Future.value(
                    {},
                  ));

          final container = ProviderContainer(
            overrides: [
              selectedCurrencyControllerProvider.overrideWith(
                (ref, _) {
                  // Keep the provider alive so that we can test it.
                  ref.keepAlive();
                  return SelectedCurrencyController(ref, 'EUR');
                },
              ),
              currencyServiceProvider.overrideWithValue(mockCurrencyService),
            ],
          );

          final controller = container.read(
            selectedCurrencyControllerProvider('EUR').notifier,
          );

          final initialState = container.read(
            selectedCurrencyControllerProvider('EUR'),
          );

          expect(
            initialState,
            const AsyncValue<CurrencyModel>.loading(),
          );

          final state = await controller.stream.firstWhere(
            (state) => state is AsyncData,
          );

          final expectedCurrency = state.asData?.value;

          expect(expectedCurrency, fakeCurrency);
        },
      );

      test(
        'Given a currencyCode and previously fetched currencies, '
        'when the controller is created, '
        'the initial value from the fetched currencies should show, and then the currency should be fetched',
        () async {
          final previouslyFetchedFakeCurrency = CurrencyModel(
            currencyCode: 'EUR',
            currencyName: 'Euro',
            description: 'European Euro',
            latestExchangeRate: 0.9,
            historicalExchangeRates: {
              DateTime(2023, 1, 1): 0.8,
              DateTime(2023, 1, 2): 0.9,
              DateTime(2023, 1, 3): 0.6,
            },
          );

          final fakeCurrency = CurrencyModel(
            currencyCode: 'EUR',
            currencyName: 'Euro',
            description: 'European Euro',
            latestExchangeRate: 0.8,
            historicalExchangeRates: {
              DateTime(2023, 1, 1): 0.8,
              DateTime(2023, 1, 2): 0.9,
              DateTime(2023, 1, 3): 0.7,
            },
          );

          final mockCurrencyService = MockCurrencyService();

          when(() => mockCurrencyService.getCurrency(
                'EUR',
              )).thenAnswer((invocation) => Future.value(
                fakeCurrency,
              ));

          final mockCurrencyController = MockCurrencyController(
            CurrencyState(
              currencies: AsyncValue.data({
                previouslyFetchedFakeCurrency,
              }),
              selectedCurrencyCode: fakeCurrency.currencyCode,
            ),
          );

          final container = ProviderContainer(
            overrides: [
              currencyControllerProvider
                  .overrideWith((ref) => mockCurrencyController),
              selectedCurrencyControllerProvider.overrideWith(
                (ref, _) {
                  // Keep the provider alive so that we can test it.
                  ref.keepAlive();
                  return SelectedCurrencyController(ref, 'EUR');
                },
              ),
              currencyServiceProvider.overrideWithValue(mockCurrencyService),
            ],
          );

          final controller = container.read(
            selectedCurrencyControllerProvider('EUR').notifier,
          );

          final initialState = container.read(
            selectedCurrencyControllerProvider('EUR'),
          );

          expect(
            initialState,
            AsyncValue<CurrencyModel>.data(
              previouslyFetchedFakeCurrency,
            ),
          );

          final state = await controller.stream.firstWhere(
            (state) => state != initialState,
          );

          final expectedCurrency = state.asData?.value;

          expect(expectedCurrency, fakeCurrency);
        },
      );
    },
  );
}

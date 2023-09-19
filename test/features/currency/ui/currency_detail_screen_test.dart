import 'package:curex/core/core.dart';
import 'package:curex/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('CurrencyDetailScreen', () {
    group(
      'Correct currency is provided',
      () {
        late CurrencyModel currency;
        late MockSelectedCurrencyController controller;

        setUpAll(() {
          currency = CurrencyModel(
            currencyCode: 'COP',
            currencyName: 'Colombian Peso',
            description: 'Colombian Peso',
            latestExchangeRate: 0.00026,
            historicalExchangeRates: {
              DateTime(2023, 1, 1): 1.0,
              DateTime(2023, 1, 2): 1.1,
              DateTime(2023, 1, 3): 0.9,
            },
          );
        });

        setUp(() {
          controller = MockSelectedCurrencyController(
            AsyncValue.data(currency),
          );
        });

        testWidgets(
          'Given a currency, '
          'When the widget is rendered, '
          'Then the currency description should be displayed',
          (tester) async {
            await tester.pumpApp(
              CurrencyDetailScreen(
                currencyId: currency.currencyCode,
              ),
              overrides: [
                selectedCurrencyControllerProvider.overrideWith(
                  (ref, _) => controller,
                ),
              ],
            );

            expect(find.text(currency.description), findsOneWidget);
          },
        );

        testWidgets(
          'Given a currency, '
          'When the widget is rendered, '
          'Then the currency code should be displayed',
          (tester) async {
            await tester.pumpApp(
              CurrencyDetailScreen(
                currencyId: currency.currencyCode,
              ),
              overrides: [
                selectedCurrencyControllerProvider.overrideWith(
                  (ref, _) => controller,
                ),
              ],
            );

            expect(find.text(currency.currencyCode), findsOneWidget);
          },
        );

        testWidgets(
          'Given a currency, '
          'When the widget is rendered, '
          'Then the currenct exchange rate should be displayed',
          (tester) async {
            await tester.pumpApp(
              CurrencyDetailScreen(
                currencyId: currency.currencyCode,
              ),
              overrides: [
                selectedCurrencyControllerProvider.overrideWith(
                  (ref, _) => controller,
                ),
              ],
            );

            expect(
              find.text(currency.currentExhangeRateLabel),
              findsOneWidget,
            );
          },
        );

        testWidgets(
          'Given a currency, '
          'When the widget is rendered, '
          'Then a graph with the historical exchange rates should be displayed',
          (tester) async {
            await tester.pumpApp(
              CurrencyDetailScreen(
                currencyId: currency.currencyCode,
              ),
              overrides: [
                selectedCurrencyControllerProvider.overrideWith(
                  (ref, _) => controller,
                ),
              ],
            );

            expect(
                find.byType(CurrencyHistoricalExchangeChart), findsOneWidget);
          },
        );
      },
    );

    group('No currencyCode is provided', () {
      late MockSelectedCurrencyController controller;

      setUp(() {
        controller = MockSelectedCurrencyController(
          AsyncValue.error(Exception('No currency code'), StackTrace.empty),
        );
      });
      testWidgets(
        'Given no currencyCode, '
        'When the widget is rendered, '
        'Then a GenericError should be displayed',
        (tester) async {
          await tester.pumpApp(
            const CurrencyDetailScreen(
              currencyId: null,
            ),
            overrides: [
              selectedCurrencyControllerProvider
                  .overrideWith((_, __) => controller)
            ],
          );

          expect(find.byType(GenericError), findsOneWidget);
        },
      );
    });
  });
}

import 'package:curex/core/core.dart';
import 'package:curex/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../helpers/helpers.dart';

void main() {
  group(
    'CurrencyTilesList',
    () {
      testWidgets(
        'Given a list of currencies, '
        'When the widget is rendered, '
        'Then the list of currencies should be displayed',
        (tester) async {
          final currencies = <CurrencyModel>{
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
                }),
          };

          final controller = MockCurrencyController(
            CurrencyState(
              currencies: AsyncValue.data(currencies),
            ),
          );

          await tester.pumpApp(
            const CurrencyTilesList(),
            overrides: [
              currencyControllerProvider.overrideWith((ref) => controller)
            ],
          );

          expect(find.byType(CurrencyTile), findsNWidgets(2));
        },
      );

      testWidgets(
        'Given an error, '
        'When the widget is rendered, '
        'Then the error should be displayed',
        (tester) async {
          final error = Exception('Error');

          final controller = MockCurrencyController(
            CurrencyState(
              currencies: AsyncValue.error(error, StackTrace.empty),
            ),
          );

          await tester.pumpApp(
            const CurrencyTilesList(),
            overrides: [
              currencyControllerProvider.overrideWith((ref) => controller)
            ],
          );

          expect(find.byType(GenericError), findsOneWidget);
        },
      );

      testWidgets(
        'Given no data, '
        'When the widget is rendered, '
        'Then the loading indicator should be displayed',
        (tester) async {
          final controller = MockCurrencyController(
            const CurrencyState(
              currencies: AsyncValue.loading(),
            ),
          );

          await tester.pumpApp(
            const CurrencyTilesList(),
            overrides: [
              currencyControllerProvider.overrideWith((ref) => controller)
            ],
          );

          expect(find.byType(GenericLoader), findsOneWidget);
        },
      );
    },
  );
}

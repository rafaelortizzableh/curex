import 'package:curex/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/helpers.dart';

void main() {
  group(
    'CurrencyTile',
    () {
      testWidgets(
        'Given a currency, '
        'When the widget is rendered, '
        'Then the currency should be displayed',
        (tester) async {
          final currency = CurrencyModel(
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

          await tester.pumpApp(
            CurrencyTile(
              currency: currency,
            ),
          );

          expect(find.text(currency.currencyCode), findsOneWidget);
        },
      );

      testWidgets(
        'Given a currency, '
        'When the widget is rendered, '
        'Then the currency code should be displayed',
        (tester) async {
          final currency = CurrencyModel(
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

          await tester.pumpApp(
            CurrencyTile(
              currency: currency,
            ),
          );

          expect(find.text(currency.currencyCode), findsOneWidget);
        },
      );

      testWidgets(
        'Given a currency, '
        'When the widget is rendered, '
        'Then the currency name should be displayed',
        (tester) async {
          final currency = CurrencyModel(
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

          await tester.pumpApp(
            CurrencyTile(
              currency: currency,
            ),
          );

          expect(find.text(currency.currencyName), findsOneWidget);
        },
      );

      testWidgets(
        'Given a currency, '
        'When the widget is rendered, '
        'Then the currency exchange rate should be displayed',
        (tester) async {
          final currency = CurrencyModel(
            currencyCode: 'COP',
            currencyName: 'Colombian Peso',
            description: 'Colombian Peso',
            latestExchangeRate: 1.35,
            historicalExchangeRates: {
              DateTime(2023, 1, 1): 1.0,
              DateTime(2023, 1, 2): 1.1,
              DateTime(2023, 1, 3): 0.9,
            },
          );

          await tester.pumpApp(
            CurrencyTile(
              currency: currency,
            ),
          );

          expect(
            find.text('Exchange Rate: ${currency.currentExhangeRateLabel}'),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Given a currency that has decreased, '
        'When the widget is rendered, '
        'Then an icon with a downward arrow should be displayed',
        (tester) async {
          final currency = CurrencyModel(
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

          await tester.pumpApp(
            CurrencyTile(
              currency: currency,
            ),
          );

          expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
        },
      );

      testWidgets(
        'Given a currency that has increased, '
        'When the widget is rendered, '
        'Then an icon with an upward arrow should be displayed',
        (tester) async {
          final currency = CurrencyModel(
            currencyCode: 'COP',
            currencyName: 'Colombian Peso',
            description: 'Colombian Peso',
            latestExchangeRate: 1.5,
            historicalExchangeRates: {
              DateTime(2023, 1, 1): 1.0,
              DateTime(2023, 1, 2): 1.1,
              DateTime(2023, 1, 3): 0.9,
            },
          );

          await tester.pumpApp(
            CurrencyTile(
              currency: currency,
            ),
          );

          expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
        },
      );
    },
  );
}

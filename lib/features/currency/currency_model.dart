import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CurrencyModel extends Equatable {
  const CurrencyModel({
    required this.currencyCode,
    required this.currencyName,
    required this.latestExchangeRate,
    required this.historicalExchangeRates,
    required this.description,
  });

  final String currencyCode;
  final String currencyName;
  final double latestExchangeRate;
  final Map<DateTime, double> historicalExchangeRates;
  final String description;

  bool get hasDecreased {
    final historicalExchangeRates = this.historicalExchangeRates;
    if (historicalExchangeRates.isEmpty) return false;

    final latestExchangeRate = this.latestExchangeRate;
    final previousExchangeRate = historicalExchangeRates.values.last;
    return latestExchangeRate < previousExchangeRate;
  }

  String get currentExhangeRateLabel => latestExchangeRate.toStringAsFixed(2);

  @override
  List<Object?> get props => [
        currencyCode,
        currencyName,
        latestExchangeRate,
        historicalExchangeRates,
        description,
      ];

  factory CurrencyModel.fromRandomExchangeRate(
    Map<String, dynamic> exchangeRate,
  ) {
    final currencyCode = exchangeRate['code'] as String?;

    final description = exchangeRate['description'] as String?;
    final allExchangeRatesList = exchangeRate['rates'] as List?;

    final isInvalid = currencyCode == null ||
        description == null ||
        allExchangeRatesList == null ||
        allExchangeRatesList.isEmpty;

    if (isInvalid) {
      throw Exception('Invalid exchange rate');
    }

    final currencyName = parseCurrencyName(description, currencyCode);

    final latestExchangeRate =
        (allExchangeRatesList.last as num).abs().toDouble();

    final historicalExchangeRates = parseHistoricalExchangeRates(
      allExchangeRatesList,
    );

    return CurrencyModel(
      currencyCode: currencyCode,
      currencyName: currencyName,
      latestExchangeRate: latestExchangeRate,
      historicalExchangeRates: historicalExchangeRates,
      description: description,
    );
  }

  @visibleForTesting
  static String parseCurrencyName(String description, String currencyCode) {
    if (description.isEmpty) return currencyCode;

    final hasFirstSentence = description.contains('.');
    if (!hasFirstSentence) return currencyCode;
    final firstSentence = description.split('.').first;
    if (firstSentence.isEmpty) return currencyCode;

    if (!firstSentence.contains('(')) return currencyCode;

    final currencyName = description.split('(').first.trim();
    if (currencyName.isEmpty) return currencyCode;
    return currencyName;
  }

  @visibleForTesting
  static Map<DateTime, double> parseHistoricalExchangeRates(
    List allExchangeRatesList,
  ) {
    final historicExchangeRatesList =
        [...allExchangeRatesList].reversed.toList();
    final historicExchangeRatesLength = historicExchangeRatesList.length;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final historicalExchangeRates = <DateTime, double>{
      for (var i = 0; i < historicExchangeRatesLength; i++) ...{
        today.subtract(Duration(days: i)):
            (historicExchangeRatesList[i] as num).abs().toDouble(),
      },
    };

    // Remove the last item, which is the latest exchange rate.
    historicalExchangeRates.remove(today);
    return historicalExchangeRates;
  }
}

extension RandomExchangeServiceExtension on CurrencyModel {}

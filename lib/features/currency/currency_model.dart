import 'package:equatable/equatable.dart';

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

  static CurrencyModel fromRandomExchangeRate(
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

    final currencyName = _parseCurrencyName(description, currencyCode);

    final latestExchangeRate =
        (allExchangeRatesList.last as num).abs().toDouble();

    final historicalExchangeRates = _parseHistoricalExchangeRates(
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

  static String _parseCurrencyName(String description, String currencyCode) {
    if (description.isEmpty) return currencyCode;

    final hasFirstSentence = description.contains('.');
    if (!hasFirstSentence) return currencyCode;
    final firstSentence = description.split('.').first;
    if (firstSentence.isEmpty) return currencyCode;

    if (!firstSentence.contains('(')) return currencyCode;

    final currencyName = description.split('(').first;
    if (currencyName.isEmpty) return currencyCode;
    return currencyName;
  }

  static Map<DateTime, double> _parseHistoricalExchangeRates(
    List allExchangeRatesList,
  ) {
    final historicExchangeRatesList = [
      ...allExchangeRatesList.where(
        (element) => element != allExchangeRatesList.last,
      ),
    ];

    final now = DateTime.now();
    final historicalExchangeRates = <DateTime, double>{
      for (var i = 0; i < historicExchangeRatesList.length; i++) ...{
        now.subtract(Duration(days: i)):
            (historicExchangeRatesList[i] as num).abs().toDouble(),
      },
    };
    return historicalExchangeRates;
  }
}

extension RandomExchangeServiceExtension on CurrencyModel {}

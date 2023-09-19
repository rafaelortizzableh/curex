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
  final num latestExchangeRate;
  final Map<DateTime, num> historicalExchangeRates;
  final String description;

  bool get hasDecreased {
    final historicalExchangeRates = this.historicalExchangeRates;
    if (historicalExchangeRates.isEmpty) return false;

    final latestExchangeRate = this.latestExchangeRate;
    final previousExchangeRate = historicalExchangeRates.values.last;
    return latestExchangeRate < previousExchangeRate;
  }

  @override
  List<Object?> get props => [
        currencyCode,
        currencyName,
        latestExchangeRate,
        historicalExchangeRates,
        description,
      ];
}

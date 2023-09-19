import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../features.dart';

class CurrencyHistoricalExchangeChart extends StatelessWidget {
  const CurrencyHistoricalExchangeChart({
    super.key,
    required this.currency,
  });

  final CurrencyModel currency;

  @override
  Widget build(BuildContext context) {
    final tooltip = TooltipBehavior(
      enable: true,
      header: '',
      canShowMarker: false,
      format: 'point.x : point.y',
    );

    final maxExchangeRate = currency.historicalExchangeRates.values
        .toList()
        .reduce(
          math.max,
        )
        .toDouble();

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.33,
      child: Card(
        child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(
            intervalType: DateTimeIntervalType.days,
            interval: 1,
            majorGridLines: const MajorGridLines(width: 0),
            minimum: DateTime.now().subtract(
              const Duration(days: 15),
            ),
            maximum: DateTime.now(),
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: maxExchangeRate * 1.25,
            interval: 10,
          ),
          title: ChartTitle(text: 'Historical Exchange Rates'),
          tooltipBehavior: tooltip,
          series: <ChartSeries<_ChartData, DateTime>>[
            AreaSeries<_ChartData, DateTime>(
              color: Theme.of(context).preferredColor,
              opacity: 0.66,
              dataSource: {
                _ChartData(
                  DateTime.now().toString(),
                  currency.latestExchangeRate.toDouble(),
                ),
                ...currency.historicalExchangeRates.entries.map(
                  (e) => _ChartData(
                    e.key.toString(),
                    e.value.toDouble(),
                  ),
                ),
              }.toList(),
              xValueMapper: (_ChartData sales, _) => DateTime.parse(
                sales.x,
              ),
              yValueMapper: (_ChartData sales, _) => sales.y,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}

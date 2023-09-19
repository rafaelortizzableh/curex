import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/core.dart';
import '../../features.dart';

class CurrencyDetailScreen extends HookConsumerWidget {
  const CurrencyDetailScreen({
    super.key,
    required this.currencyId,
  });
  final String? currencyId;

  static const routeName = '/currency/detail';
  static const currencyIdParameterName = 'currencyId';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        _navigateTo404IfNeeded(context);
        return null;
      },
      [this.currencyId],
    );
    // This should never happen, as the router should have redirected to 404.
    // However, to avoid using a nullable type, we return empty space.
    final currencyId = this.currencyId;
    if (currencyId == null) return AppSpacing.emptySpace;

    final theme = Theme.of(context);

    final currency = ref.watch(
      selectedCurrencyControllerProvider(currencyId).select(
        (value) => value.maybeWhen(
          data: (currency) => currency,
          orElse: () => null,
        ),
      ),
    );

    if (currency == null) {
      return Scaffold(
        body: GenericError(
          errorText: 'No currency found with id: $currencyId',
          onRetry: () => Navigator.pop(context),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        shadowColor: theme.colorScheme.background,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: const CloseButton(),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: AppConstants.circularRadius32,
            topLeft: AppConstants.circularRadius32,
          ),
        ),
        title: Text(
          currencyId,
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ColoredBox(
                  color: theme.colorScheme.background,
                ),
              ),
            ],
          ),
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: AppConstants.padding8,
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Current Exhange Rate',
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
              ),
              SliverPadding(
                padding: AppConstants.padding8,
                sliver: SliverToBoxAdapter(
                  child: AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    transitionBuilder: (child, animation) {
                      // SlideTransition
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: Text(
                      currency.currentExhangeRateLabel,
                      key: ObjectKey(
                        'currency_current_exchange_rate_${currency.currentExhangeRateLabel}',
                      ),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: AppConstants.padding8,
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Description',
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
              ),
              SliverPadding(
                padding: AppConstants.padding8,
                sliver: SliverToBoxAdapter(
                  child: Text(
                    currency.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacing16,
                  vertical: AppConstants.spacing8,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Historical Exchange Rates',
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacing16,
                  vertical: AppConstants.spacing16,
                ),
                sliver: SliverToBoxAdapter(
                  child: CurrencyHistoricalExchangeChart(
                    currency: currency,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Replace with 404 if currencyId is null
  void _navigateTo404IfNeeded(BuildContext context) {
    if (currencyId != null) {
      return;
    }
    context.pushReplacementNamed(
      UnknownRouteScreen.routeName,
      queryParameters: {
        'name': routeName,
      },
    );
  }
}

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

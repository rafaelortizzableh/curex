import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/core.dart';
import 'currency.dart';

/// This provider is used to provide the [GraphQLClient] to the [RandomValuesCurrencyService].
final _graphQlClientProvider = Provider.autoDispose<GraphQLClient>(
  (ref) {
    final link = HttpLink(
      'http://localhost:4000/graphql',
    );

    return GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  },
);

/// This is an implementation of the [CurrencyService] that uses random values from
/// a local GraphQL server.
class RandomValuesCurrencyService implements CurrencyService {
  const RandomValuesCurrencyService(this._ref);

  final Ref _ref;
  static const _tag = 'RandomValuesCurrencyService';

  GraphQLClient get _graphQLClient => _ref.read(_graphQlClientProvider);
  LoggerService get _loggerService => _ref.read(loggerServiceProvider);

  @override
  Future<Set<CurrencyModel>> getCurrencies() async {
    const query = '''
query {
  exchangeRates {
    code
    description
    rates
  }
}
''';
    try {
      final queryResult = await _graphQLClient.query(
        QueryOptions(document: gql(query)),
      );
      if (queryResult.hasException) {
        throw queryResult.exception!;
      }

      final resultMap = queryResult.data!['exchangeRates'] as List;

      return {
        for (final currency in resultMap)
          CurrencyModel.fromRandomExchangeRate(currency as Map<String, dynamic>)
      };
    } catch (e, stackTrace) {
      _loggerService.captureException(e, stackTrace: stackTrace, tag: _tag);
      Error.throwWithStackTrace(
        RandomValuesCurrencyServiceException(
          'Error while fetching currencies: $e\n$stackTrace',
        ),
        stackTrace,
      );
    }
  }

  @override
  Future<CurrencyModel> getCurrency(String currencyCode) async {
    const query = '''
query exchangeRate(\$code: String!)
 {
  exchangeRate(code: \$code) {
    code
    description
    rates
  },
}
''';
    final variables = {
      'code': currencyCode,
    };
    try {
      final queryResult = await _graphQLClient.query(
        QueryOptions(document: gql(query), variables: variables),
      );
      if (queryResult.hasException) {
        throw queryResult.exception!;
      }

      final currency = queryResult.data!['exchangeRate'] as Map;

      return CurrencyModel.fromRandomExchangeRate(
        currency as Map<String, dynamic>,
      );
    } catch (e, stackTrace) {
      _loggerService.captureException(e, stackTrace: stackTrace, tag: _tag);
      Error.throwWithStackTrace(
        RandomValuesCurrencyServiceException(
          'Error while fetching currency with currencyCode: $currencyCode: $e',
        ),
        stackTrace,
      );
    }
  }
}

class RandomValuesCurrencyServiceException implements Exception {
  const RandomValuesCurrencyServiceException(this.message);

  final String message;

  @override
  String toString() => 'RandomValuesCurrencyServiceException: $message';
}

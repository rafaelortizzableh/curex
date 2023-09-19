import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'currency.dart';

final currencyServiceProvider = Provider.autoDispose<CurrencyService>(
  (ref) => RandomValuesCurrencyService(ref),
);

abstract class CurrencyService {
  Future<Set<CurrencyModel>> getCurrencies();
  Future<CurrencyModel> getCurrency(String currencyCode);
}

class RandomValuesCurrencyService implements CurrencyService {
  const RandomValuesCurrencyService(this._ref);

  final Ref _ref;

  GraphQLClient get _graphQLClient => _ref.read(_graphQlClientProvider);

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
  }

  @override
  Future<CurrencyModel> getCurrency(String currencyCode) async {
    // Based on this model get the currency from the server. There's a String argument (code):
//     export class ExchangeRate {
//     @Field(() => String)
//     public code!: string;

//     @Field(() => String)
//     public description!: string;

//     @Field(() => [Number])
//     public rates!: number[];
// }

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
  }
}

final _graphQlClientProvider = Provider.autoDispose<GraphQLClient>((ref) {
  final link = HttpLink(
    'http://localhost:4000/graphql',
  );

  return GraphQLClient(
    cache: GraphQLCache(),
    link: link,
  );
});

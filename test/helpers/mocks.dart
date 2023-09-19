import 'package:curex/core/core.dart';
import 'package:curex/features/features.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockLoggerService extends Mock implements LoggerService {}

class MockSharedPreferencesService extends Mock
    implements SharedPreferencesService {}

enum ConnectivityCase { error, success }

class MockCurrencyService extends Mock implements CurrencyService {}

class MockCurrencyController extends StateNotifier<CurrencyState>
    with Mock
    implements CurrencyController {
  MockCurrencyController(super.state);

  void setState(CurrencyState state) => this.state = state;
}

class MockSelectedCurrencyController
    extends StateNotifier<SelectedCurrencyState>
    with Mock
    implements SelectedCurrencyController {
  MockSelectedCurrencyController(super.state);

  void setState(SelectedCurrencyState state) => this.state = state;
}

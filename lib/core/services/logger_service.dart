import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final loggerServiceProvider = Provider<LoggerService>(
  (ref) => DebugLoggerService(),
);

abstract class LoggerService {
  Future<void> identifyUser({required String uid, String? tag});
  void captureMessage(String message, {String? tag});
  void captureException(
    Object exception, {
    StackTrace? stackTrace,
    String? tag,
  });
}

class DebugLoggerService implements LoggerService {
  @override
  void captureException(
    Object exception, {
    StackTrace? stackTrace,
    String? tag,
  }) {
    log('EXCEPTION on [$tag]: $exception. StackTrace: $stackTrace');
  }

  @override
  void captureMessage(
    String message, {
    String? tag,
  }) {
    log('MESSAGE on [$tag]: $message');
  }

  @override
  Future<void> identifyUser({
    required String uid,
    String? tag,
  }) async {
    log('USER IDENTIFIED ON [$tag]: uid: $uid');
  }
}

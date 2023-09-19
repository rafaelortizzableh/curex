import 'dart:core';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A provider of the [SharedPreferencesService].
///
/// Needs to be overriden after [SharedPreferences] instance has been initialized.
final sharedPreferencesServiceProvider = Provider<SharedPreferencesService>(
  (ref) => throw UnimplementedError(),
);

class SharedPreferencesService {
  SharedPreferencesService(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  /// Fetch a string from Local Storage ([SharedPreferences]).
  ///
  /// If you're getting an object don't forget to convert it with a fromJson method.
  String? getStringFromSharedPreferences(String key) {
    return _sharedPreferences.getString(key);
  }

  /// Fetch a list of strings from Local Storage ([SharedPreferences]).
  List<String>? getListOfStringsFromSharedPreferences(String key) {
    return _sharedPreferences.getStringList(key);
  }

  /// Fetch a bool from Local Storage ([SharedPreferences]).
  bool? getBoolFromSharedPreferences(String key) {
    return _sharedPreferences.getBool(key);
  }

  /// Fetch an int from Local Storage ([SharedPreferences]).
  int? getIntFromSharedPreferences(String key) {
    return _sharedPreferences.getInt(key);
  }

  /// Fetch a double from Local Storage ([SharedPreferences]).
  double? getDoubleFromSharedPreferences(String key) {
    return _sharedPreferences.getDouble(key);
  }

  /// Content can be either a string, list of type string, bool, int or double.
  ///
  /// If you want to save a different type, try saving it with a `toJson` method.
  Future<bool> save<T>(String key, T value) async {
    if (value is String) {
      return await _sharedPreferences.setString(key, value);
    }

    if (value is bool) {
      return await _sharedPreferences.setBool(key, value);
    }

    if (value is int) {
      return await _sharedPreferences.setInt(key, value);
    }

    if (value is double) {
      return await _sharedPreferences.setDouble(key, value);
    }

    if (value is List<String>) {
      return await _sharedPreferences.setStringList(key, value);
    }

    throw Exception(
      'Can\'t save content of type ${value.runtimeType}. Content should of types String, bool, int, double or List<String>. Try passing the object as a JSON encoded String with a toJson method',
    );
  }

  /// Removes the values of a given key
  /// from Local Storage ([SharedPreferences]).
  Future<bool> removeFromSharedPreferences(String key) {
    return _sharedPreferences.remove(key);
  }

  /// Removes all keys from Local Storage ([SharedPreferences]).
  Future<bool> clearSharedPreferences() {
    return _sharedPreferences.clear();
  }
}

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_locale_repository.g.dart';

@riverpod
AuthLocaleRepository authLocaleRepository(Ref ref) {
  return AuthLocaleRepository();
}

class AuthLocaleRepository {
  late SharedPreferences _sharedPreferences;
  final Completer<void> _initCompleter = Completer<void>();

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _initCompleter.complete();
  }

  Future<void> setToken(String? token) async {
    await _initCompleter.future;
    if (token != null) {
      await _sharedPreferences.setString('user-token', token);
    }
  }

  Future<String?> getToken() async {
    await _initCompleter.future;
    return _sharedPreferences.getString('user-token');
  }
}

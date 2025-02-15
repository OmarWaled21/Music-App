import 'dart:convert';

import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/error/failure.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<http.Response> _postRequest(
    String endPoint,
    Map<String, dynamic> body,
  ) async {
    try {
      return await http.post(
        Uri.parse('${ServerConstant.serverUrl}/auth/$endPoint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<Failure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _postRequest(
        'signup',
        {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        return Left(Failure(resBodyMap['detail']));
      }
      return Right(
        UserModel.fromMap(resBodyMap),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _postRequest(
        'login',
        {
          'email': email,
          'password': password,
        },
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(Failure(resBodyMap['detail']));
      }
      return Right(UserModel.fromMap(resBodyMap['user'])
          .copyWith(token: resBodyMap['token']));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

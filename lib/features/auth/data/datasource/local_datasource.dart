import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/error/failure.dart';
import '../../domain/entity/auth_response.dart';
import '../model/response/auth_response_model.dart';

const String _tokenKey = 'TOKENKEY';
const String _authKey = 'AUTHKEY';

abstract class AuthLocalDataSource {
  Future<bool> cacheAuthResponseModel(AuthResponseModel model);
  Future<bool> clearCache();

  String? get cachedAuthToken;
  AuthResponse? get cachedAuthResponse;
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _sharedPreferences;

  const AuthLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<bool> clearCache() => _sharedPreferences.clear();

  @override
  String? get cachedAuthToken {
    final token = _sharedPreferences.getString(_tokenKey);

    return token;
  }

  @override
  Future<bool> cacheAuthResponseModel(AuthResponseModel authResponseModel) async {
    final token = authResponseModel.token;

    if (token == null) throw Failure(message: 'Token is null', code: 400);

    final authResponseModelMap = authResponseModel.toJson();
    final authResponseModelString = json.encode(authResponseModelMap);

    final tokenCache = await _sharedPreferences.setString(_tokenKey, token);
    final authResponseModelCache = await _sharedPreferences.setString(_authKey, authResponseModelString);

    return tokenCache && authResponseModelCache;
  }

  @override
  AuthResponse? get cachedAuthResponse {
    // get the cached auth response model
    final authResponseModelString = _sharedPreferences.getString(_authKey);

    if (authResponseModelString == null) return null;

    // decode the json string to a map
    final authResponseModelMap = json.decode(authResponseModelString) as Map<String, dynamic>;
    // convert the map to a model
    final authResponseModel = AuthResponseModel.fromJson(authResponseModelMap);

    final authResponse = AuthResponse.fromModel(authResponseModel);

    // return the auth response
    return authResponse;
  }
}

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/error/exception.dart';
import '../../../../core/presentation/resource/string.dart';
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
  Future<bool> clearCache() async {
    try {
      await _sharedPreferences.remove(_tokenKey);
      await _sharedPreferences.remove(_authKey);
      await _sharedPreferences.clear();
      return true;
    } catch (e) {
      throw CacheException(message: ErrorMessages.failedToCacheToken, code: ErrorCodes.cacheFailed);
    }
  }

  @override
  Future<bool> cacheAuthResponseModel(AuthResponseModel authResponseModel) async {
    final token = authResponseModel.token;

    if (token == null) {
      throw CacheException(message: ErrorMessages.failedToGetTokenFromCache, code: ErrorCodes.cacheFailed);
    }

    try {
      final authResponseModelMap = authResponseModel.toJson();
      final authResponseModelString = json.encode(authResponseModelMap);

      final tokenCache = await _sharedPreferences.setString(_tokenKey, token);
      final authResponseModelCache = await _sharedPreferences.setString(_authKey, authResponseModelString);
      return tokenCache && authResponseModelCache;
    } catch (_) {
      throw CacheException(message: ErrorMessages.failedToCacheAuthResponse, code: ErrorCodes.cacheFailed);
    }
  }

  @override
  String? get cachedAuthToken {
    try {
      final token = _sharedPreferences.getString(_tokenKey);
      return token;
    } on Exception {
      throw CacheException(message: ErrorMessages.failedToGetTokenFromCache, code: ErrorCodes.cacheFailed);
    }
  }

  @override
  AuthResponse? get cachedAuthResponse {
    try {
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
    } catch (_) {
      throw CacheException(message: ErrorMessages.failedToGetAuthResponseFromCache, code: ErrorCodes.cacheFailed);
    }
  }
}

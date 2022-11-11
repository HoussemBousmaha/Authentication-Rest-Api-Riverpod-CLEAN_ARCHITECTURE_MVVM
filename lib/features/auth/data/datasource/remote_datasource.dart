import 'package:dio/dio.dart';
import 'package:flutter/material.dart' show immutable;

import '../../../../core/data/error/exception.dart';
import '../../../../core/presentation/resource/constant.dart';
import '../../../../core/presentation/resource/string.dart';
import '../model/response/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login({required String phone});
  Future<AuthResponseModel> postUserName({required String name});
  Future<bool> checkToken();
}

@immutable
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  const AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<AuthResponseModel> login({required String phone}) async {
    try {
      const url = '${ApiConstants.baseUrl}/${AppStrings.login}';

      final response = await _dio.post<Map<String, dynamic>>(
        url,
        data: {AppStrings.otp: ApiConstants.otpValue, AppStrings.phone: phone},
      );

      final responseData = response.data;

      if (responseData == null) return throw DioError(requestOptions: RequestOptions(path: url));

      final data = {
        AuthResponseKeys.code: response.statusCode,
        AuthResponseKeys.message: responseData[AuthResponseKeys.message],
        AuthResponseKeys.token: responseData[AuthResponseKeys.token],
        AuthResponseKeys.userStatus: responseData[AuthResponseKeys.userStatus],
        AuthResponseKeys.name: responseData[AuthResponseKeys.name],
        AuthResponseKeys.phone: responseData[AuthResponseKeys.phone],
      };

      return AuthResponseModel.fromJson(data);
    } on DioError catch (e) {
      final message = e.message;
      final code = e.response?.statusCode;
      throw ServerException(message: message, code: code);
    }
  }

  @override
  Future<bool> checkToken() async {
    try {
      const url = '${ApiConstants.baseUrl}/${AppStrings.token}';
      final response = await _dio.get<Map<String, dynamic>>(url);

      final data = response.data;

      if (data == null) throw DioError(requestOptions: RequestOptions(path: url));

      return true;
    } on DioError catch (e) {
      final message = e.message;
      final code = e.response?.statusCode;
      throw ServerException(message: message, code: code);
    }
  }

  @override
  Future<AuthResponseModel> postUserName({required String name}) async {
    try {
      const url = '${ApiConstants.baseUrl}/${AppStrings.name}';

      final response = await _dio.post<Map<String, dynamic>>(
        url,
        data: {AppStrings.name: name},
      );

      final responseData = response.data;

      if (responseData == null) return throw DioError(requestOptions: RequestOptions(path: url));

      final data = {
        AuthResponseKeys.code: response.statusCode,
        AuthResponseKeys.message: responseData[AuthResponseKeys.message],
        AuthResponseKeys.token: responseData[AuthResponseKeys.token],
        AuthResponseKeys.userStatus: responseData[AuthResponseKeys.userStatus],
        AuthResponseKeys.name: responseData[AuthResponseKeys.name],
        AuthResponseKeys.phone: responseData[AuthResponseKeys.phone],
      };

      return AuthResponseModel.fromJson(data);
    } on DioError catch (e) {
      final message = e.message;
      final code = e.response?.statusCode;
      throw ServerException(message: message, code: code);
    }
  }
}

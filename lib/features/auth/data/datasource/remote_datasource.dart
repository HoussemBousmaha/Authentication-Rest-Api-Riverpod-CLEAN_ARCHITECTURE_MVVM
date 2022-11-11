import 'package:dio/dio.dart';
import 'package:flutter/material.dart' show immutable;

import '../../../../core/constant/constant.dart';
import '../../../../core/constant/string.dart';
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
    const url = '${ApiConstants.baseUrl}/${AppStrings.login}';

    final response = await _dio.post<Map<String, dynamic>>(
      url,
      data: {AppStrings.otp: ApiConstants.otpValue, AppStrings.phone: phone},
    );

    final responseData = response.data;

    if (responseData == null) return throw DioError(requestOptions: RequestOptions(path: url));

    final data = {
      ResponseKeys.code: response.statusCode,
      ResponseKeys.message: responseData[ResponseKeys.message],
      ResponseKeys.token: responseData[ResponseKeys.token],
      ResponseKeys.userStatus: responseData[ResponseKeys.userStatus],
      ResponseKeys.name: responseData[ResponseKeys.name],
      ResponseKeys.phone: responseData[ResponseKeys.phone],
    };

    return AuthResponseModel.fromJson(data);
  }

  @override
  Future<bool> checkToken() async {
    const url = '${ApiConstants.baseUrl}/${AppStrings.token}';
    final response = await _dio.get<Map<String, dynamic>>(url);

    final data = response.data;

    if (data == null) throw DioError(requestOptions: RequestOptions(path: url));

    final isTokenValid = data[ResponseKeys.success] as bool;

    return isTokenValid;
  }

  @override
  Future<AuthResponseModel> postUserName({required String name}) async {
    const url = '${ApiConstants.baseUrl}/${AppStrings.name}';

    final response = await _dio.post<Map<String, dynamic>>(
      url,
      data: {AppStrings.name: name},
    );

    final responseData = response.data;

    // print(responseData);

    if (responseData == null) return throw DioError(requestOptions: RequestOptions(path: url));

    final data = {
      ResponseKeys.code: response.statusCode,
      ResponseKeys.message: responseData[ResponseKeys.message],
      ResponseKeys.token: responseData[ResponseKeys.token],
      ResponseKeys.userStatus: responseData[ResponseKeys.userStatus],
      ResponseKeys.name: responseData[ResponseKeys.name],
      ResponseKeys.phone: responseData[ResponseKeys.phone],
    };

    // print(data);

    return AuthResponseModel.fromJson(data);
  }
}

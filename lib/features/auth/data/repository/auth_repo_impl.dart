import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/data/error/failure.dart';
import '../../../../core/data/network/network_info.dart';
import '../../../../core/domain/enum/user_status.dart';
import '../../domain/entity/auth_response.dart';
import '../../domain/repository/auth_repo.dart';
import '../datasource/local_datasource.dart';
import '../datasource/remote_datasource.dart';
import '../model/response/auth_response_model.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final NetworkInfo _networkInfo;

  AuthRepoImpl(this._authRemoteDataSource, this._authLocalDataSource, this._networkInfo);

  @override
  Future<Either<Failure, AuthResponse>> login({required String phone}) async {
    // check if the device is connected to the internet
    if (await _networkInfo.isConnected) {
      try {
        // get the response from the remote data source
        // this can throw a dio error if the request fails
        final response = await _authRemoteDataSource.login(phone: phone);

        // cache the response model

        // we need to update the dio options with the new token

        final cached = await _authLocalDataSource.cacheAuthResponseModel(response);

        if (cached) return Right(AuthResponse.fromModel(response));

        log('Failed to cache user token: $response');

        // if the response model was not cached, return a failure
        return Left(Failure(message: 'Failed to cache response model', code: 500));
      } on DioError catch (error) {
        // the request failed and threw a dio error
        // this can be a server error or a network error
        final code = error.response?.statusCode ?? 400;
        final message = error.response?.statusMessage ?? 'Something went wrong';
        // return a failure based on the error code

        return Left(Failure(message: message, code: code));
      } catch (error) {
        // the request failed and threw an unknown error
        // return a failure with a generic message
        return Left(Failure(message: '$error', code: 400));
      }
    } else {
      // the device is not connected to the internet
      return Left(Failure(message: 'No Internet Connection', code: 502));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> checkToken() async {
    if (await _networkInfo.isConnected) {
      try {
        final isTokenValid = await _authRemoteDataSource.checkToken();
        final authResponse = _authLocalDataSource.cachedAuthResponse;

        // the token is valid

        if (isTokenValid) return Right(authResponse!);

        return Left(Failure(message: 'Token is invalid', code: 401));
      } on DioError catch (error) {
        final code = error.response?.statusCode ?? 400;
        final message = error.response?.statusMessage ?? 'Something went wrong';

        // return a failure based on the error code
        return Left(Failure(message: message, code: code));
      } catch (error) {
        // the request failed and threw an unknown error
        return Left(Failure(message: '$error', code: 400));
      }
    } else {
      // the device is not connected to the internet
      return Left(Failure(message: 'No Internet Connection', code: 502));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(await _authLocalDataSource.clearCache());
  }

  @override
  Future<Either<Failure, AuthResponse>> postUserName({required String name}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.postUserName(name: name);

        final cachedAuthResponseModel = _authLocalDataSource.cachedAuthResponse;

        final authResponseModel = AuthResponseModel(
          code: response.code,
          message: response.message,
          // same token
          token: cachedAuthResponseModel!.token,
          // updateUser status to old user
          userStatus: UserStatus.oldUser.toString(),
          // get the new name
          name: response.name,
          // get the new phone
          phone: response.phone,
        );

        final cached = await _authLocalDataSource.cacheAuthResponseModel(authResponseModel);

        if (cached) return Right(AuthResponse.fromModel(authResponseModel));

        log('Failed to cache user token: $response');

        return Left(Failure(message: 'Failed to cache response model', code: 500));
      } on DioError catch (error) {
        final code = error.response?.statusCode ?? 400;
        final message = error.response?.statusMessage ?? 'Something went wrong';
        log('Dio error: $error');

        return Left(Failure(message: message, code: code));
      } catch (error) {
        log('Unknown error: $error');
        return Left(Failure(message: '$error', code: 400));
      }
    } else {
      return Left(Failure(message: 'No Internet Connection', code: 502));
    }
  }
}

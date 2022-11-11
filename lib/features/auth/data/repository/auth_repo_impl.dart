import 'package:dartz/dartz.dart';

import '../../../../core/data/error/exception.dart';
import '../../../../core/data/network/network_info.dart';
import '../../../../core/presentation/resource/enum/user_status.dart';
import '../../../../core/presentation/resource/string.dart';
import '../../domain/entity/auth_failure.dart';
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
  Future<Either<AuthFailure, AuthResponse>> login({required String phone}) async {
    // check if the device is connected to the internet
    if (await _networkInfo.isConnected) {
      try {
        // call the remote data source to login
        final response = await _authRemoteDataSource.login(phone: phone);

        // call the local data source to save the auth response model
        await _authLocalDataSource.cacheAuthResponseModel(response);

        // turn the auth response model into auth response
        final authResponse = AuthResponse.fromModel(response);

        return Right(authResponse);
      } on CacheException catch (error) {
        final message = error.message;
        final code = error.code;

        return Left(AuthFailure(message: message, code: code));
      } on ServerException catch (error) {
        final message = error.message;
        final code = error.code;

        return Left(AuthFailure(message: message, code: code));
      } catch (error) {
        const message = ErrorMessages.somethingWentWrong;
        const code = ErrorCodes.somethingWentWrong;

        return Left(AuthFailure(message: message, code: code));
      }
    } else {
      const message = ErrorMessages.noInternetConnection;
      const code = ErrorCodes.noInternetConnection;

      return Left(AuthFailure(message: message, code: code));
    }
  }

  @override
  Future<Either<AuthFailure, AuthResponse>> checkToken() async {
    if (await _networkInfo.isConnected) {
      try {
        // call the remote data source to check if the token is valid
        await _authRemoteDataSource.checkToken();

        // if the token is valid
        // call the local data source to get the auth response model
        final authResponse = _authLocalDataSource.cachedAuthResponse;

        return Right(authResponse!);
      } on CacheException catch (error) {
        final message = error.message;
        final code = error.code;

        return Left(AuthFailure(message: message, code: code));
      } on ServerException catch (error) {
        final message = error.message;
        final code = error.code;

        return Left(AuthFailure(message: message, code: code));
      } catch (error) {
        const message = ErrorMessages.somethingWentWrong;
        const code = ErrorCodes.somethingWentWrong;

        return Left(AuthFailure(message: message, code: code));
      }
    } else {
      const message = ErrorMessages.noInternetConnection;
      const code = ErrorCodes.noInternetConnection;

      return Left(AuthFailure(message: message, code: code));
    }
  }

  @override
  Future<Either<AuthFailure, bool>> logout() async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      // call the local data source to delete the auth response model
      await _authLocalDataSource.clearCache();

      return const Right(true);
    } on CacheException catch (error) {
      final message = error.message;
      final code = error.code;

      return Left(AuthFailure(message: message, code: code));
    } catch (error) {
      const message = ErrorMessages.somethingWentWrong;
      const code = ErrorCodes.somethingWentWrong;

      return Left(AuthFailure(message: message, code: code));
    }
  }

  @override
  Future<Either<AuthFailure, AuthResponse>> postUserName({required String name}) async {
    if (await _networkInfo.isConnected) {
      try {
        // call the remote data source to post the user name
        final response = await _authRemoteDataSource.postUserName(name: name);

        // call the local data source to get the current auth response
        final cachedAuthResponseModel = _authLocalDataSource.cachedAuthResponse;

        // create a new auth response model with :
        // 1) the new user name and the new phone
        // 2) the old token
        // 3) set the user status as old user
        final authResponseModel = AuthResponseModel(
          code: response.code,
          message: response.message,
          token: cachedAuthResponseModel!.token,
          userStatus: UserStatus.oldUser.toString(),
          name: response.name,
          phone: response.phone,
        );

        // call the local data source to save the new auth response model
        await _authLocalDataSource.cacheAuthResponseModel(authResponseModel);

        // turn the auth response model into auth response
        final authResponse = AuthResponse.fromModel(authResponseModel);

        return Right(authResponse);
      } on CacheException catch (error) {
        final message = error.message;
        final code = error.code;

        return Left(AuthFailure(message: message, code: code));
      } on ServerException catch (error) {
        final message = error.message;
        final code = error.code;

        return Left(AuthFailure(message: message, code: code));
      } catch (error) {
        const message = ErrorMessages.somethingWentWrong;
        const code = ErrorCodes.somethingWentWrong;

        return Left(AuthFailure(message: message, code: code));
      }
    } else {
      const message = ErrorMessages.noInternetConnection;
      const code = ErrorCodes.noInternetConnection;

      return Left(AuthFailure(message: message, code: code));
    }
  }
}

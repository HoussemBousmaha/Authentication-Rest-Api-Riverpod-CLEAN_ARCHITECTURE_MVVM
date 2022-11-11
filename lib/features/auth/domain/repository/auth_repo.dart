import 'package:dartz/dartz.dart';

import '../entity/auth_failure.dart';
import '../entity/auth_response.dart';

abstract class AuthRepo {
  Future<Either<AuthFailure, AuthResponse>> login({required String phone});
  Future<Either<AuthFailure, AuthResponse>> postUserName({required String name});
  Future<Either<AuthFailure, bool>> logout();

  Future<Either<AuthFailure, AuthResponse>> checkToken();
}

import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failure.dart';
import '../entity/auth_response.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthResponse>> login({required String phone});
  Future<Either<Failure, AuthResponse>> postUserName({required String name});
  Future<Either<Failure, bool>> logout();

  Future<Either<Failure, AuthResponse>> checkToken();
}

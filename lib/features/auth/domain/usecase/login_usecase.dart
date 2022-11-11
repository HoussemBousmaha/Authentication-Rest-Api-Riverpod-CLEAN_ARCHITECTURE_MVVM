import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../entity/auth_failure.dart';
import '../entity/auth_response.dart';
import '../repository/auth_repo.dart';

class LoginUseCase extends BaseUseCase<AuthResponse, LoginUseCaseInputs, AuthFailure> {
  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  @override
  Future<Either<AuthFailure, AuthResponse>> call(LoginUseCaseInputs params) async {
    return await _authRepo.login(phone: params.phone);
  }
}

class LoginUseCaseInputs {
  final String phone;
  LoginUseCaseInputs(this.phone);
}

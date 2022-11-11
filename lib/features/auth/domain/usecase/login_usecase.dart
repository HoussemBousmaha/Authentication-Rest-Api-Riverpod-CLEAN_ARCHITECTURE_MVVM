import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failure.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../entity/auth_response.dart';
import '../repository/auth_repo.dart';

class LoginUseCase extends BaseUseCase<AuthResponse, LoginUseCaseInputs> {
  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  @override
  Future<Either<Failure, AuthResponse>> call(LoginUseCaseInputs params) async {
    return await _authRepo.login(phone: params.phone);
  }
}

class LoginUseCaseInputs {
  final String phone;
  LoginUseCaseInputs(this.phone);
}

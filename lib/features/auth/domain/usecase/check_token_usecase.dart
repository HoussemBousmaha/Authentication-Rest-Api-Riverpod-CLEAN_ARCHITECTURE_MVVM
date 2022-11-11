import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../entity/auth_failure.dart';
import '../entity/auth_response.dart';
import '../repository/auth_repo.dart';

class CheckTokenUseCase extends BaseUseCase<AuthResponse, NoParams, AuthFailure> {
  final AuthRepo _authRepo;

  CheckTokenUseCase(this._authRepo);

  @override
  Future<Either<AuthFailure, AuthResponse>> call(NoParams params) async {
    return await _authRepo.checkToken();
  }
}

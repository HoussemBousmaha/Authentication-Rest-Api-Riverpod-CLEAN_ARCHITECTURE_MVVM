import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../entity/auth_failure.dart';
import '../repository/auth_repo.dart';

class LogoutUseCase extends BaseUseCase<bool, NoParams, AuthFailure> {
  final AuthRepo _authRepo;

  LogoutUseCase(this._authRepo);

  @override
  Future<Either<AuthFailure, bool>> call(NoParams params) async {
    return await _authRepo.logout();
  }
}

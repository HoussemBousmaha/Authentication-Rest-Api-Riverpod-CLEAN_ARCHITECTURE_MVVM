import 'package:quiz_u/core/data/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:quiz_u/core/domain/usecase/base_usecase.dart';

import '../repository/auth_repo.dart';

class LogoutUseCase extends BaseUseCase<bool, NoParams> {
  final AuthRepo _authRepo;

  LogoutUseCase(this._authRepo);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await _authRepo.logout();
  }
}

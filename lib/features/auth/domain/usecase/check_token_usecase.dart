import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failure.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../entity/auth_response.dart';
import '../repository/auth_repo.dart';

class CheckTokenUseCase extends BaseUseCase<AuthResponse, NoParams> {
  final AuthRepo _authRepo;

  CheckTokenUseCase(this._authRepo);

  @override
  Future<Either<Failure, AuthResponse>> call(NoParams params) async {
    return await _authRepo.checkToken();
  }
}

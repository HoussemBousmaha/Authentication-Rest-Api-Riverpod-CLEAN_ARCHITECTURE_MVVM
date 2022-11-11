import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failure.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../entity/auth_response.dart';
import '../repository/auth_repo.dart';

class PostUserNameUseCase extends BaseUseCase<AuthResponse, PostUserNameUseCaseInputs> {
  final AuthRepo _authRepo;

  PostUserNameUseCase(this._authRepo);

  @override
  Future<Either<Failure, AuthResponse>> call(PostUserNameUseCaseInputs params) async {
    return await _authRepo.postUserName(name: params.name);
  }
}

class PostUserNameUseCaseInputs {
  final String name;

  PostUserNameUseCaseInputs(this.name);
}

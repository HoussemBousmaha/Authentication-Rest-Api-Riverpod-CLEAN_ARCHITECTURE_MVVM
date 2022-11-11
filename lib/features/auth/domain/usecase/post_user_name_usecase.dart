import 'package:dartz/dartz.dart';
import 'package:quiz_u/features/auth/domain/entity/auth_failure.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../entity/auth_response.dart';
import '../repository/auth_repo.dart';

class PostUserNameUseCase extends BaseUseCase<AuthResponse, PostUserNameUseCaseInputs, AuthFailure> {
  final AuthRepo _authRepo;

  PostUserNameUseCase(this._authRepo);

  @override
  Future<Either<AuthFailure, AuthResponse>> call(PostUserNameUseCaseInputs params) async {
    return await _authRepo.postUserName(name: params.name);
  }
}

class PostUserNameUseCaseInputs {
  final String name;

  PostUserNameUseCaseInputs(this.name);
}

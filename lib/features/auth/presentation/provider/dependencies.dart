import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/presentation/dependency/dependencies.dart';
import '../../data/datasource/local_datasource.dart';
import '../../data/datasource/remote_datasource.dart';
import '../../data/repository/auth_repo_impl.dart';
import '../../domain/repository/auth_repo.dart';
import '../../domain/usecase/check_token_usecase.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../../domain/usecase/post_user_name_usecase.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.refresh(dioProvider);

  return AuthRemoteDataSourceImpl(dio);
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final sharedPrefs = ref.refresh(sharedPrefsProvider);
  return AuthLocalDataSourceImpl(sharedPrefs);
});

final authRepositoryProvider = Provider<AuthRepo>((ref) {
  final networkInfo = ref.refresh(networkInfoProvider);
  final remoteDataSource = ref.refresh(authRemoteDataSourceProvider);
  final localDataSource = ref.refresh(authLocalDataSourceProvider);
  return AuthRepoImpl(remoteDataSource, localDataSource, networkInfo);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final authRepository = ref.refresh(authRepositoryProvider);
  return LoginUseCase(authRepository);
});

final checkTokenUseCaseProvider = Provider<CheckTokenUseCase>((ref) {
  final authRepository = ref.refresh(authRepositoryProvider);
  return CheckTokenUseCase(authRepository);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final authRepository = ref.refresh(authRepositoryProvider);
  return LogoutUseCase(authRepository);
});

final postUserNameUseCaseProvider = Provider<PostUserNameUseCase>((ref) {
  final authRepository = ref.refresh(authRepositoryProvider);
  return PostUserNameUseCase(authRepository);
});

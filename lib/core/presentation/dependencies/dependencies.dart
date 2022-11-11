import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/auth/data/datasource/local_datasource.dart';
import '../../../features/auth/data/datasource/remote_datasource.dart';
import '../../../features/auth/data/repository/auth_repo_impl.dart';
import '../../../features/auth/domain/repository/auth_repo.dart';
import '../../../features/auth/domain/usecase/check_token_usecase.dart';
import '../../../features/auth/domain/usecase/login_usecase.dart';
import '../../../features/auth/domain/usecase/logout_usecase.dart';
import '../../../features/auth/domain/usecase/post_user_name_usecase.dart';
import '../../data/network/network_info.dart';

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return const NetworkInfo();
});

final dioProvider = Provider<Dio>((ref) {
  // to get the token from the local storage
  final localDataSource = ref.refresh(authLocalDataSourceProvider);
  final token = localDataSource.cachedAuthToken;

  final dio = Dio();

  if (token != null) dio.options.headers['Authorization'] = token;

  // print(dio.options.headers);

  return dio;
});

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.refresh(dioProvider);

  return AuthRemoteDataSourceImpl(dio);
});

final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw 'No shared preferences instance provided';
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

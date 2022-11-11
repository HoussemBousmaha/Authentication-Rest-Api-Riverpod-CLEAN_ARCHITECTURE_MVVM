import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/auth/presentation/provider/dependencies.dart';
import '../../data/network/network_info.dart';
import '../resource/constant.dart';
import '../resource/string.dart';

final networkInfoProvider = Provider<NetworkInfo>(
  (ref) => const NetworkInfo(),
);

final dioProvider = Provider<Dio>((ref) {
  // to get the token from the local storage
  final localDataSource = ref.refresh(authLocalDataSourceProvider);
  final token = localDataSource.cachedAuthToken;

  final dio = Dio();

  // to add the token to the header of the request
  if (token != null) dio.options.headers[ApiConstants.authorization] = token;

  return dio;
});

final sharedPrefsProvider = Provider<SharedPreferences>(
  (ref) => throw ErrorMessages.sharedPrefIsNotInitialized,
);

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/presentation/dependencies/dependencies.dart';
import '../../../../core/presentation/enum/view_state.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/post_user_name_usecase.dart';
import 'auth_state.dart';
import 'auth_state_notifier_provider.dart';

typedef AsyncAuthState = AsyncValue<AuthState>;

abstract class AuthStateNotifier extends AsyncNotifier<AuthState> {
  Future<void> login(String phone);

  Future<void> logout();

  Future<AsyncAuthState> checkToken();

  Future<void> postUserName(String name);
}

class AuthStateNotifierImpl extends AuthStateNotifier {
  @override
  FutureOr<AuthState> build() async {
    state = await checkToken();
    return state.requireValue;
  }

  @override
  Future<void> login(String phone) async {
    ref.read(viewStateProvider.notifier).state = ViewState.loading;

    final loginResult = await ref.refresh(loginUseCaseProvider)(LoginUseCaseInputs(phone));

    state = await loginResult.fold(
      (failure) async {
        if (kDebugMode) {
          print('failure login : $failure');
        }
        ref.read(viewStateProvider.notifier).state = ViewState.failure;

        return await AsyncAuthState.guard(() async => AuthState.failure(failure));
      },
      (authResponse) async {
        if (kDebugMode) {
          print('success login');
        }
        ref.read(viewStateProvider.notifier).state = ViewState.success;

        return await AsyncAuthState.guard(() async => AuthState.success(authResponse));
      },
    );
  }

  @override
  Future<void> logout() async {
    ref.read(viewStateProvider.notifier).state = ViewState.loading;

    final logoutResult = await ref.refresh(logoutUseCaseProvider)(NoParams());

    state = await logoutResult.fold(
      (failure) async {
        if (kDebugMode) {
          print('failure logout : $failure');
        }
        ref.read(viewStateProvider.notifier).state = ViewState.failure;

        return await AsyncAuthState.guard(() async => AuthState.failure(failure));
      },
      (_) async {
        if (kDebugMode) {
          print('success logout');
        }
        ref.read(viewStateProvider.notifier).state = ViewState.success;

        return await AsyncAuthState.guard(() async => AuthState.initial());
      },
    );
  }

  @override
  Future<AsyncAuthState> checkToken() async {
    // set loading state

    state = const AsyncAuthState.loading();

    // get the response from the use case
    final checkTokenResult = await ref.refresh(checkTokenUseCaseProvider)(NoParams());

    return await AsyncAuthState.guard(
      () async => checkTokenResult.fold(
        (failure) {
          if (kDebugMode) {
            print('failure check token : $failure');
          }
          ref.read(viewStateProvider.notifier).state = ViewState.failure;

          return AuthState.failure(failure);
        },
        (authResponse) {
          if (kDebugMode) {
            print('success check token : $authResponse');
          }
          ref.read(viewStateProvider.notifier).state = ViewState.success;

          return AuthState.success(authResponse);
        },
      ),
    );
  }

  @override
  Future<void> postUserName(String name) async {
    // set loading state
    ref.read(viewStateProvider.notifier).state = ViewState.loading;

    // get the response from the use case
    final postUserNameResult = await ref.refresh(postUserNameUseCaseProvider)(PostUserNameUseCaseInputs(name));

    // check if the response is a failure or a success
    state = await postUserNameResult.fold(
      (failure) async {
        if (kDebugMode) {
          print('failure post user name : $failure');
        }
        ref.read(viewStateProvider.notifier).state = ViewState.failure;

        return await AsyncAuthState.guard(() async => AuthState.failure(failure));
      },
      (authResponse) async {
        if (kDebugMode) {
          print('success post user name');
        }
        ref.read(viewStateProvider.notifier).state = ViewState.success;

        return await AsyncAuthState.guard(() async => AuthState.success(authResponse));
      },
    );
  }
}

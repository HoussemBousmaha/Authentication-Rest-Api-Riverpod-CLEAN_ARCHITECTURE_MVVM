import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../features/auth/presentation/provider/auth_state_notifier_provider.dart';
import '../../../features/auth/presentation/view/confirm_otp.dart';
import '../../../features/auth/presentation/view/home.dart';
import '../../../features/auth/presentation/view/login.dart';
import '../../../features/auth/presentation/view/post_user_name.dart';
import '../resource/constant.dart';
import '../resource/enum/user_status.dart';
import '../view/splash.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authenticated = ref.watch(isAuthenticatedProvider);

  final authState = ref.watch(authStateNotifierProvider);
  final loading = authState.isLoading;

  return GoRouter(
    // refreshListenable: ,
    redirect: (BuildContext context, GoRouterState state) {
      // location where we are going
      final location = state.location;

      if (loading) return RoutePaths.splash;

      // log('calling the main redirect\n\n');

      // log('location: $location');

      // log('authenticated: $authenticated');

      // if we are going to splash view
      final goingToSplash = location == RoutePaths.splash;

      // log('going to splash: $goingToSplash');

      if (goingToSplash) return authenticated ? RoutePaths.home : RoutePaths.login;

      // if we are going to the login page
      final goingToLogin = location == RoutePaths.login;

      // log('going to login: $goingToLogin');

      if (goingToLogin) return authenticated ? RoutePaths.home : null;

      // if we are going to the home page
      final goingToHome = location == RoutePaths.home;

      // log('going to home: $goingToHome');

      if (goingToHome) return authenticated ? null : RoutePaths.home;

      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.home,
        name: RouteNames.home,
        builder: (context, state) => HomeView(key: state.pageKey),
        redirect: ((context, state) {
          final userStatus = ref.watch(authStateNotifierProvider).requireValue.authResponse?.userStatus;

          return userStatus == UserStatus.newUser ? RoutePaths.postUserName : null;
        }),
      ),
      GoRoute(
        path: RoutePaths.postUserName,
        name: RouteNames.postUserName,
        builder: (context, state) => PostUserNameView(key: state.pageKey),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => LoginView(key: state.pageKey),
        routes: [
          GoRoute(
            path: RoutePaths.confirmOtp,
            name: RouteNames.confirmOtp,
            builder: (context, state) {
              final phone = state.params['phone'] as String;
              return ConfirmOtpView(key: state.pageKey, phone);
            },
          ),
        ],
      ),
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => SplashView(key: state.pageKey),
      ),
    ],
    initialLocation: RoutePaths.splash,
  );
});

typedef GoRouterRedirectFunction = String? Function(BuildContext context, GoRouterState state);

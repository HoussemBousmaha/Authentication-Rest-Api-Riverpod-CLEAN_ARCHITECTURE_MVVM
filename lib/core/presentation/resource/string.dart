class AuthResponseKeys {
  static const String success = 'success';
  static const String code = 'code';
  static const String message = 'message';
  static const String token = 'token';
  static const String userStatus = 'user_status';
  static const String name = 'name';
  static const String phone = 'mobile';

  AuthResponseKeys._();
}

class AppStrings {
  static const String otp = 'OTP';
  static const String phone = 'mobile';
  static const String newUser = 'new';

  static const String login = 'login';
  static const String token = 'token';
  static const String name = 'name';

  AppStrings._();
}

class ErrorMessages {
  static const String somethingWentWrong = 'Something went wrong';
  static const String noInternetConnection = 'No Internet Connection';
  static const String failedToCacheToken = 'Failed to cache token';
  static const String failedToCacheAuthResponse = 'Failed to cache auth response';
  static const String failedToGetTokenFromCache = 'Failed to get token from cache';
  static const String failedToGetAuthResponseFromCache = 'Failed to get auth response from cache';
  static const String sharedPrefIsNotInitialized = 'Shared pref is not initialized';

  ErrorMessages._();
}

class ErrorCodes {
  static const int somethingWentWrong = 400;
  static const int noInternetConnection = 502;
  static const int cacheFailed = 500;
  static const int serverError = 500;

  ErrorCodes._();
}

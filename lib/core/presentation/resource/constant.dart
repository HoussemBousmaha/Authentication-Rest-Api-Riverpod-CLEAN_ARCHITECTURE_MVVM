class RouteNames {
  static const String home = 'home';
  static const String login = 'login';
  static const String splash = 'splash';
  static const String confirmOtp = 'confirmOtp';
  static const String postUserName = 'postUserName';

  RouteNames._();
}

class RoutePaths {
  static const String home = '/home';
  static const String login = '/login';
  static const String splash = '/splash';
  static const String confirmOtp = 'confirmOtp/:phone';
  static const String postUserName = '/postUserName';

  RoutePaths._();
}

class ApiConstants {
  static const String baseUrl = 'https://quizu.okoul.com';
  static const otpValue = '0000';
  static const String authorization = 'Authorization';

  ApiConstants._();
}

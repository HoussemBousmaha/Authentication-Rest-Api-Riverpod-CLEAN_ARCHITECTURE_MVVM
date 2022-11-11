import '../../../../core/data/error/failure.dart';

class AuthFailure extends BaseFailure {
  AuthFailure({required String message, int? code}) : super(message: message, code: code);
}

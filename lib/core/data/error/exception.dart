abstract class BaseException implements Exception {
  final String message;
  final int? code;

  BaseException({required this.message, this.code});
}

class CacheException extends BaseException {
  CacheException({required String message, int? code}) : super(message: message, code: code);
}

class ServerException extends BaseException {
  ServerException({required String message, int? code}) : super(message: message, code: code);
}

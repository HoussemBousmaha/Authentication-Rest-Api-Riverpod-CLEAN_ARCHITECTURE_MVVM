abstract class BaseFailure {
  final String message;
  final int? code;

  BaseFailure({required this.message, this.code});

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

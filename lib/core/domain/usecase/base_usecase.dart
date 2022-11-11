import 'package:dartz/dartz.dart';

abstract class BaseUseCase<Result, Params, Error> {
  Future<Either<Error, Result>> call(Params params);
}

class NoParams {}

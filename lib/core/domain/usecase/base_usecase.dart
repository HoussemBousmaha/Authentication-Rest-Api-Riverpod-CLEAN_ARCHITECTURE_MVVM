import 'package:dartz/dartz.dart';

import '../../data/error/failure.dart';

abstract class BaseUseCase<Result, Params> {
  Future<Either<Failure, Result>> call(Params params);
}

class NoParams {}

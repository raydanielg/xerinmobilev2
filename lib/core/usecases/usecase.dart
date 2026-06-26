import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

/// Base UseCase class for features without parameters.
abstract class UseCase<T> {
  Future<Either<Failure, T>> call();
}

/// Base UseCase class for features that require parameters.
abstract class UseCaseWithParams<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Helper class when a UseCase doesn't need any parameters.
class NoParams {
  const NoParams();
}

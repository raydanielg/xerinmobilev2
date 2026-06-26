import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

/// Base UseCase class for features without parameters.
abstract class UseCase<Type> {
  Future<Either<Failure, Type>> call();
}

/// Base UseCase class for features that require parameters.
abstract class UseCaseWithParams<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Helper class when a UseCase doesn't need any parameters.
class NoParams {
  const NoParams();
}

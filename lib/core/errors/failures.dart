import 'package:equatable/equatable.dart';

/// Base class for all failures in the app.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure from server / remote source.
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Failure from local cache / storage.
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Failure from unexpected errors.
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

/// Failure from validation / business logic.
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

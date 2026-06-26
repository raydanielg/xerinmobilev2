/// Base class for all exceptions in the app.
class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

/// Exception from server / remote source.
class ServerException extends AppException {
  const ServerException(super.message);
}

/// Exception from local cache / storage.
class CacheException extends AppException {
  const CacheException(super.message);
}

/// Exception from validation / business logic.
class ValidationException extends AppException {
  const ValidationException(super.message);
}

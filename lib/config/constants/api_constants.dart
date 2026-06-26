/// API-related constants.
abstract class ApiConstants {
  // TODO: Replace with your production base URL.
  static const String baseUrl = 'https://api.example.com';

  static const String apiVersion = 'v1';

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';

  // Common headers
  static const String contentType = 'application/json';
  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer';
}

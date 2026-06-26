/// General app constants.
abstract class AppConstants {
  static const String appName = 'XerinMarket';
  static const String appVersion = '1.0.0';

  // Routes
  static const String splashRoute = '/splash';
  static const String onboardingRoute = '/onboarding';
  static const String signInRoute = '/sign-in';
  static const String registerRoute = '/register';
  static const String verifyOtpRoute = '/verify-otp';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String homeRoute = '/';
  static const String sellerDashboardRoute = '/seller-dashboard';

  // Timeouts
  static const int connectionTimeoutSeconds = 30;
  static const int receiveTimeoutSeconds = 30;

  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'app_theme';

  // UI
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const double buttonHeight = 48.0;
}

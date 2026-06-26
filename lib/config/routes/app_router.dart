import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/registration_success_page.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/verify_otp_page.dart';
import '../../features/customer/presentation/pages/categories_page.dart';
import '../../features/customer/presentation/pages/category_products_page.dart';
import '../../features/customer/presentation/pages/customer_dashboard.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/seller/presentation/pages/seller_dashboard.dart';
import '../../features/seller/presentation/pages/seller_details_page.dart';
import '../../features/seller/presentation/pages/seller_onboarding_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../constants/app_constants.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppConstants.splashRoute,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppConstants.splashRoute,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppConstants.onboardingRoute,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppConstants.signInRoute,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: AppConstants.registerRoute,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppConstants.verifyOtpRoute,
        builder: (context, state) => const VerifyOtpPage(),
      ),
      GoRoute(
        path: AppConstants.forgotPasswordRoute,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppConstants.homeRoute,
        builder: (context, state) => const CustomerDashboard(),
      ),
      GoRoute(
        path: AppConstants.categoriesRoute,
        builder: (context, state) => const CategoriesPage(),
      ),
      GoRoute(
        path: AppConstants.categoryProductsRoute,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return CategoryProductsPage(
            category: extra?['category'] as String? ?? 'All',
          );
        },
      ),
      GoRoute(
        path: AppConstants.sellerDashboardRoute,
        builder: (context, state) => const SellerDashboard(),
      ),
      GoRoute(
        path: AppConstants.sellerOnboardingRoute,
        builder: (context, state) => const SellerOnboardingPage(),
      ),
      GoRoute(
        path: AppConstants.sellerDetailsRoute,
        builder: (context, state) => const SellerDetailsPage(),
      ),
      GoRoute(
        path: AppConstants.registrationSuccessRoute,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return RegistrationSuccessPage(
            isSeller: extra?['isSeller'] as bool? ?? true,
            shopName: extra?['shopName'] as String? ?? 'XerinMart Store',
          );
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri.path}'),
      ),
    ),
  );
}

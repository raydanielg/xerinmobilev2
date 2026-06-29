import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../core/storage/token_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final tokenStorage = GetIt.instance<TokenStorage>();
    final prefs = GetIt.instance<SharedPreferences>();
    final isLoggedIn = tokenStorage.hasTokens;
    final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;

    if (isLoggedIn) {
      context.go(AppConstants.homeRoute);
    } else if (hasSeenOnboarding) {
      context.go(AppConstants.signInRoute);
    } else {
      context.go(AppConstants.onboardingRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Full colored logo - plain on white background
            SvgPicture.asset(
              'assets/logo/full_named_logo.svg',
              width: 260,
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 48),
            // Loading indicator
            SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[600]!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

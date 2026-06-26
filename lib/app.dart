import 'package:flutter/material.dart';

import 'config/routes/app_router.dart';
import 'config/theme/app_theme.dart';

/// Root app widget.
class XerinApp extends StatelessWidget {
  const XerinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'XerinMarket',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}

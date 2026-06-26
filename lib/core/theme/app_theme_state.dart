part of 'app_theme_cubit.dart';

class AppThemeState extends Equatable {
  final ThemeMode themeMode;

  const AppThemeState(this.themeMode);

  bool get isLight => themeMode == ThemeMode.light;
  bool get isDark => themeMode == ThemeMode.dark;
  bool get isSystem => themeMode == ThemeMode.system;

  IconData get icon {
    switch (themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  String get label {
    switch (themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  @override
  List<Object?> get props => [themeMode];
}

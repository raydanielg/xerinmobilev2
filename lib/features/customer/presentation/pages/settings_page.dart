import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(Icons.arrow_back_rounded, color: colorScheme.primary, size: 22),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('Settings',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _buildSection('Appearance', colorScheme),
              const SizedBox(height: 12),
              BlocBuilder<AppThemeCubit, AppThemeState>(
                builder: (context, themeState) {
                  final isDark = themeState.themeMode == ThemeMode.dark ||
                      (themeState.themeMode == ThemeMode.system &&
                          MediaQuery.platformBrightnessOf(context) == Brightness.dark);
                  return _buildSettingTile(
                    icon: Icons.dark_mode_rounded,
                    iconColor: const Color(0xFF8B5CF6),
                    title: 'Dark Mode',
                    subtitle: isDark ? 'Enabled' : 'Disabled',
                    trailing: Switch(
                      value: isDark,
                      onChanged: (_) => context.read<AppThemeCubit>().toggleTheme(),
                      activeTrackColor: colorScheme.primary.withValues(alpha: 0.5),
                      activeThumbColor: colorScheme.primary,
                    ),
                    colorScheme: colorScheme,
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildSection('Notifications', colorScheme),
              const SizedBox(height: 12),
              _buildSettingTile(
                icon: Icons.shopping_bag_rounded,
                iconColor: const Color(0xFF3B82F6),
                title: 'Order Updates',
                subtitle: 'Get notified about order status',
                trailing: Switch(value: true, onChanged: (v) {}, activeThumbColor: colorScheme.primary),
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 8),
              _buildSettingTile(
                icon: Icons.local_offer_rounded,
                iconColor: const Color(0xFFF59E0B),
                title: 'Promotions & Deals',
                subtitle: 'Receive offers and discounts',
                trailing: Switch(value: true, onChanged: (v) {}, activeThumbColor: colorScheme.primary),
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 8),
              _buildSettingTile(
                icon: Icons.payment_rounded,
                iconColor: const Color(0xFF22C55E),
                title: 'Payment Notifications',
                subtitle: 'Transaction alerts',
                trailing: Switch(value: false, onChanged: (v) {}, activeThumbColor: colorScheme.primary),
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 24),
              _buildSection('Account', colorScheme),
              const SizedBox(height: 12),
              _buildSettingTile(
                icon: Icons.language_rounded,
                iconColor: const Color(0xFF3B82F6),
                title: 'Language',
                subtitle: 'English',
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: colorScheme.onSurface.withValues(alpha: 0.3)),
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 8),
              _buildSettingTile(
                icon: Icons.monetization_on_rounded,
                iconColor: const Color(0xFFF59E0B),
                title: 'Currency',
                subtitle: 'TZS - Tanzanian Shilling',
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: colorScheme.onSurface.withValues(alpha: 0.3)),
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 24),
              _buildSection('About', colorScheme),
              const SizedBox(height: 12),
              _buildSettingTile(
                icon: Icons.info_outline_rounded,
                iconColor: colorScheme.primary,
                title: 'App Version',
                subtitle: '1.0.0',
                trailing: const SizedBox.shrink(),
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 8),
              _buildSettingTile(
                icon: Icons.description_outlined,
                iconColor: colorScheme.primary,
                title: 'Terms of Service',
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: colorScheme.onSurface.withValues(alpha: 0.3)),
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 8),
              _buildSettingTile(
                icon: Icons.shield_outlined,
                iconColor: colorScheme.primary,
                title: 'Privacy Policy',
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: colorScheme.onSurface.withValues(alpha: 0.3)),
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, ColorScheme colorScheme) {
    return Text(title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: colorScheme.primary,
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    Widget? trailing,
    required ColorScheme colorScheme,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colorScheme.onSurface),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle,
                    style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withValues(alpha: 0.4)),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}

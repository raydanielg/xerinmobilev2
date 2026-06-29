import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/constants/app_constants.dart';
import '../../../../auth/presentation/cubit/auth_cubit.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';

class CustomerProfilePage extends StatelessWidget {
  const CustomerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final menuItems = [
      {'icon': Icons.person_outline_rounded, 'label': 'Personal Info'},
      {'icon': Icons.location_on_outlined, 'label': 'Addresses'},
      {'icon': Icons.payment_rounded, 'label': 'Payment Methods'},
      {'icon': Icons.shopping_bag_outlined, 'label': 'Order History'},
      {'icon': Icons.notifications_outlined, 'label': 'Notifications'},
      {'icon': Icons.settings_outlined, 'label': 'Settings'},
      {'icon': Icons.help_outline_rounded, 'label': 'Help & Support'},
      {'icon': Icons.logout_rounded, 'label': 'Logout', 'color': const Color(0xFFE53935)},
    ];

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, homeState) {
        final user = homeState is HomeLoaded ? homeState.user : null;
        final displayName = user?.fullName ?? 'Guest';
        final displayEmail = user?.email ?? '';

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.primary.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    backgroundImage: const AssetImage('assets/images/avatar.png'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    displayName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (displayEmail.isNotEmpty) ...[  
                    const SizedBox(height: 4),
                    Text(
                      displayEmail,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: colorScheme.onSurface.withValues(alpha: 0.06),
                ),
              ),
              child: Column(
                children: menuItems.map((item) {
                  final color = item['color'] as Color? ?? colorScheme.onSurface;
                  return ListTile(
                    leading: Icon(
                      item['icon'] as IconData,
                      color: color.withValues(alpha: 0.7),
                      size: 22,
                    ),
                    title: Text(
                      item['label'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                    onTap: () {
                        if ((item['label'] as String) == 'Logout') {
                          context.read<AuthCubit>().logout();
                          context.go(AppConstants.signInRoute);
                        }
                      },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
      },
    );
  }
}

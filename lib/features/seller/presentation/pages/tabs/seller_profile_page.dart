import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/constants/app_constants.dart';

class SellerProfilePage extends StatelessWidget {
  const SellerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final menuItems = [
      {
        'icon': Icons.verified_user_outlined,
        'label': 'KYC Verification',
        'route': AppConstants.sellerKycRoute,
      },
      {
        'icon': Icons.store_outlined,
        'label': 'Shop Details',
        'route': AppConstants.sellerShopDetailsRoute,
      },
      {
        'icon': Icons.local_shipping_outlined,
        'label': 'Shipping Options',
        'route': AppConstants.sellerShippingOptionsRoute,
      },
      {
        'icon': Icons.payment_outlined,
        'label': 'Payouts',
        'route': AppConstants.sellerPayoutsRoute,
      },
      {
        'icon': Icons.bar_chart_outlined,
        'label': 'Reports',
        'route': AppConstants.sellerReportsRoute,
      },
      {
        'icon': Icons.support_agent_outlined,
        'label': 'Seller Support',
        'route': AppConstants.sellerSupportRoute,
      },
      {
        'icon': Icons.logout_rounded,
        'label': 'Logout',
        'color': const Color(0xFFE53935),
      },
    ];

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
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.store_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'XerinMart Store',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'seller@xerinmart.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatBadge('4.9', 'Rating', colorScheme),
                      const SizedBox(width: 12),
                      _buildStatBadge('1.2k', 'Reviews', colorScheme),
                    ],
                  ),
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
                      final route = item['route'] as String?;
                      if (route != null) {
                        context.go(route);
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
  }

  Widget _buildStatBadge(String value, String label, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

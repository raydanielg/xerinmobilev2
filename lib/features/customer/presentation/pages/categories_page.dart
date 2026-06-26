import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/constants/app_constants.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  final List<_CategoryItem> _categories = const [
    _CategoryItem(icon: Icons.devices_rounded, label: 'Electronics', color: Color(0xFF3B82F6)),
    _CategoryItem(icon: Icons.checkroom_rounded, label: 'Fashion', color: Color(0xFFEC4899)),
    _CategoryItem(icon: Icons.home_rounded, label: 'Home', color: Color(0xFFF59E0B)),
    _CategoryItem(icon: Icons.directions_car_rounded, label: 'Auto', color: Color(0xFF6366F1)),
    _CategoryItem(icon: Icons.sports_soccer_rounded, label: 'Sports', color: Color(0xFF22C55E)),
    _CategoryItem(icon: Icons.book_rounded, label: 'Books', color: Color(0xFF8B5CF6)),
    _CategoryItem(icon: Icons.health_and_safety_rounded, label: 'Health', color: Color(0xFF14B8A6)),
    _CategoryItem(icon: Icons.restaurant_rounded, label: 'Food', color: Color(0xFFF97316)),
    _CategoryItem(icon: Icons.more_horiz_rounded, label: 'More', color: Color(0xFF64748B)),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go(AppConstants.homeRoute);
                      }
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: colorScheme.primary,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'All Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Browse products by category',
                style: TextStyle(
                  fontSize: 15,
                  color: colorScheme.onSurface.withValues(alpha: 0.45),
                ),
              ),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  return GestureDetector(
                    onTap: () => context.go(
                      AppConstants.categoryProductsRoute,
                      extra: {'category': cat.label},
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cat.color.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: cat.color.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: cat.color.withValues(alpha: 0.15),
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                cat.icon,
                                color: cat.color,
                                size: 24,
                              ),
                            ),
                          ),
                          Text(
                            cat.label,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryItem {
  final IconData icon;
  final String label;
  final Color color;
  const _CategoryItem({
    required this.icon,
    required this.label,
    required this.color,
  });
}

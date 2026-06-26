import 'package:flutter/material.dart';

class CustomerExplorePage extends StatelessWidget {
  const CustomerExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Explore',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Discover new products and deals',
              style: TextStyle(
                fontSize: 15,
                color: colorScheme.onSurface.withValues(alpha: 0.45),
              ),
            ),
            const SizedBox(height: 24),
            _buildSearchBar(colorScheme),
            const SizedBox(height: 24),
            _buildSectionTitle('Popular Deals', colorScheme),
            const SizedBox(height: 16),
            _buildDealsGrid(colorScheme),
            const SizedBox(height: 24),
            _buildSectionTitle('Trending Now', colorScheme),
            const SizedBox(height: 16),
            _buildTrendingList(colorScheme),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(ColorScheme colorScheme) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(Icons.search_rounded,
              color: colorScheme.onSurface.withValues(alpha: 0.35)),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products, brands...',
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: 0.3),
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, ColorScheme colorScheme) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
    );
  }

  Widget _buildDealsGrid(ColorScheme colorScheme) {
    final deals = [
      {'label': 'Flash Sale', 'icon': Icons.flash_on_rounded, 'color': const Color(0xFFF59E0B)},
      {'label': 'New Arrivals', 'icon': Icons.new_releases_rounded, 'color': const Color(0xFF3B82F6)},
      {'label': 'Best Rated', 'icon': Icons.star_rounded, 'color': const Color(0xFF22C55E)},
      {'label': 'Clearance', 'icon': Icons.local_offer_rounded, 'color': const Color(0xFFE53935)},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: deals.length,
      itemBuilder: (context, index) {
        final deal = deals[index];
        final color = deal['color'] as Color;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(deal['icon'] as IconData, color: color, size: 28),
              const Spacer(),
              Text(
                deal['label'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTrendingList(ColorScheme colorScheme) {
    final items = List.generate(4, (i) => {
      'name': 'Trending Product ${i + 1}',
      'price': '\$${(i + 2) * 10}.99',
      'sold': '${(i + 1) * 120} sold',
    });

    return Column(
      children: items.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.onSurface.withValues(alpha: 0.06),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.local_fire_department_rounded,
                    color: colorScheme.primary, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      item['sold'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                item['price'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

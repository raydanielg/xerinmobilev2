import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/constants/app_constants.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  final _searchCtrl = TextEditingController();
  final _searchNode = FocusNode();
  String _searchQuery = '';
  String? _selectedCategory;
  String? _selectedRegion;
  String? _selectedPriceRange;

  final List<_CategoryItem> _categories = const [
    _CategoryItem(icon: Icons.devices_rounded, label: 'Electronics'),
    _CategoryItem(icon: Icons.checkroom_rounded, label: 'Fashion'),
    _CategoryItem(icon: Icons.home_rounded, label: 'Home'),
    _CategoryItem(icon: Icons.directions_car_rounded, label: 'Auto'),
    _CategoryItem(icon: Icons.sports_soccer_rounded, label: 'Sports'),
    _CategoryItem(icon: Icons.book_rounded, label: 'Books'),
    _CategoryItem(icon: Icons.health_and_safety_rounded, label: 'Health'),
    _CategoryItem(icon: Icons.more_horiz_rounded, label: 'More'),
  ];

  final List<Map<String, dynamic>> _featured = List.generate(
    4,
    (i) => {
      'name': 'Product ${i + 1}',
      'price': '\$${(i + 1) * 15}.99',
      'rating': 4.5 + (i * 0.1),
      'image': Icons.shopping_bag_rounded,
    },
  );

  final List<Map<String, dynamic>> _allProducts = const [
    {'name': 'Wireless Headphones', 'price': '\$129.99', 'category': 'Electronics', 'region': 'Dar es Salaam', 'icon': Icons.headphones_rounded},
    {'name': 'Smart Watch Series 5', 'price': '\$249.00', 'category': 'Electronics', 'region': 'Arusha', 'icon': Icons.watch_rounded},
    {'name': 'Running Shoes Pro', 'price': '\$89.50', 'category': 'Sports', 'region': 'Mwanza', 'icon': Icons.directions_run_rounded},
    {'name': 'Laptop Stand', 'price': '\$45.99', 'category': 'Electronics', 'region': 'Dar es Salaam', 'icon': Icons.laptop_rounded},
    {'name': 'Organic Coffee Beans', 'price': '\$24.99', 'category': 'Food', 'region': 'Kilimanjaro', 'icon': Icons.coffee_rounded},
    {'name': 'Cotton T-Shirt', 'price': '\$19.99', 'category': 'Fashion', 'region': 'Dar es Salaam', 'icon': Icons.checkroom_rounded},
    {'name': 'Bluetooth Speaker', 'price': '\$79.99', 'category': 'Electronics', 'region': 'Arusha', 'icon': Icons.speaker_rounded},
    {'name': 'Yoga Mat', 'price': '\$34.50', 'category': 'Sports', 'region': 'Mwanza', 'icon': Icons.self_improvement_rounded},
    {'name': 'Kitchen Blender', 'price': '\$59.99', 'category': 'Home', 'region': 'Dar es Salaam', 'icon': Icons.blender_rounded},
    {'name': 'Car Phone Holder', 'price': '\$15.99', 'category': 'Auto', 'region': 'Arusha', 'icon': Icons.directions_car_rounded},
    {'name': 'Novel Book', 'price': '\$12.99', 'category': 'Books', 'region': 'Mwanza', 'icon': Icons.book_rounded},
    {'name': 'Sunscreen Lotion', 'price': '\$18.50', 'category': 'Health', 'region': 'Dar es Salaam', 'icon': Icons.health_and_safety_rounded},
  ];

  final List<String> _regions = const [
    'Dar es Salaam',
    'Arusha',
    'Mwanza',
    'Kilimanjaro',
    'Dodoma',
    'Zanzibar',
  ];

  @override
  void initState() {
    super.initState();
    _searchNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _searchNode.dispose();
    super.dispose();
  }

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
            _buildHeader(colorScheme),
            const SizedBox(height: 20),
            _buildSearchBar(colorScheme),
            const SizedBox(height: 24),
            if (_searchQuery.isNotEmpty) ...[
              _buildSearchResults(colorScheme),
              const SizedBox(height: 24),
            ] else ...[
              _buildSectionTitle(
                'Categories',
                'See all',
                colorScheme,
                onActionTap: () => context.go(AppConstants.categoriesRoute),
              ),
              const SizedBox(height: 14),
              _buildCategories(colorScheme),
              const SizedBox(height: 24),
              _buildSectionTitle('Featured', 'See all', colorScheme),
              const SizedBox(height: 14),
              _buildFeaturedProducts(colorScheme),
              const SizedBox(height: 24),
              _buildSectionTitle('Recent Orders', '', colorScheme),
              const SizedBox(height: 14),
              _buildRecentOrders(colorScheme),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.primary.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.primary,
                        colorScheme.primary.withValues(alpha: 0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning 👋',
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurface.withValues(alpha: 0.45),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            _iconBadge(
              Icons.notifications_outlined,
              badge: '3',
              colorScheme: colorScheme,
              onTap: () => _showNotificationsPopup(context, colorScheme),
            ),
            const SizedBox(width: 8),
            _iconBadge(
              Icons.favorite_outline_rounded,
              badge: '2',
              colorScheme: colorScheme,
              onTap: () => _showWishlistPopup(context, colorScheme),
            ),
          ],
        ),
      ],
    );
  }

  Widget _iconBadge(
    IconData icon, {
    required String badge,
    required ColorScheme colorScheme,
    required VoidCallback onTap,
  }) {
    final hasBadge = badge.isNotEmpty;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 34,
        height: 34,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Icon(
                icon,
                color: colorScheme.onSurface.withValues(alpha: 0.75),
                size: 26,
              ),
            ),
            if (hasBadge)
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53935),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: colorScheme.surface,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE53935).withValues(alpha: 0.5),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showNotificationsPopup(BuildContext context, ColorScheme colorScheme) {
    final notifications = [
      {'title': 'Order shipped', 'body': 'Your order #ORD-2024001 is on the way', 'time': '2m ago'},
      {'title': 'Flash Sale!', 'body': 'Get 50% off on electronics today', 'time': '1h ago'},
      {'title': 'New arrival', 'body': 'New running shoes are now available', 'time': '3h ago'},
      {'title': 'Order delivered', 'body': 'Your order #ORD-2023998 was delivered', 'time': '5h ago'},
    ];
    _showIconPopup(
      context: context,
      colorScheme: colorScheme,
      title: 'Notifications',
      icon: Icons.notifications_outlined,
      items: notifications,
      itemBuilder: (notification) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.notifications_rounded, color: colorScheme.primary, size: 18),
        ),
        title: Text(
          notification['title']!,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          '${notification['body']} • ${notification['time']}',
          style: TextStyle(
            fontSize: 11,
            color: colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  void _showWishlistPopup(BuildContext context, ColorScheme colorScheme) {
    final items = [
      {'name': 'Wireless Headphones', 'price': '\$129.99'},
      {'name': 'Smart Watch Series 5', 'price': '\$249.00'},
      {'name': 'Running Shoes Pro', 'price': '\$89.50'},
      {'name': 'Laptop Stand', 'price': '\$45.99'},
    ];
    _showIconPopup(
      context: context,
      colorScheme: colorScheme,
      title: 'Wishlist',
      icon: Icons.favorite_rounded,
      items: items,
      itemBuilder: (item) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFE53935).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.favorite_rounded, color: Color(0xFFE53935), size: 18),
        ),
        title: Text(
          item['name']!,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        trailing: Text(
          item['price']!,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }

  void _showIconPopup<T>({
    required BuildContext context,
    required ColorScheme colorScheme,
    required String title,
    required IconData icon,
    required List<T> items,
    required Widget Function(T) itemBuilder,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, _, _) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: double.infinity,
              margin: const EdgeInsets.only(left: 0),
              padding: const EdgeInsets.only(
                top: 16,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 24,
                    offset: const Offset(-4, 0),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(icon, color: colorScheme.primary, size: 22),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: colorScheme.onSurface.withValues(alpha: 0.06),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              size: 20,
                              color: colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: items.map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: itemBuilder(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, _, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          )),
          child: child,
        );
      },
    );
  }

  Widget _buildSearchBar(ColorScheme colorScheme) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _searchNode.hasFocus
              ? colorScheme.primary
              : colorScheme.onSurface.withValues(alpha: 0.08),
          width: _searchNode.hasFocus ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(
              alpha: _searchNode.hasFocus ? 0.15 : 0.05,
            ),
            blurRadius: _searchNode.hasFocus ? 16 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(
            Icons.search_rounded,
            color: _searchNode.hasFocus
                ? colorScheme.primary
                : colorScheme.onSurface.withValues(alpha: 0.35),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchCtrl,
              focusNode: _searchNode,
              onChanged: (v) => setState(() => _searchQuery = v.trim().toLowerCase()),
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: 0.3),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchCtrl.clear();
                setState(() => _searchQuery = '');
              },
              child: Icon(
                Icons.close_rounded,
                color: colorScheme.onSurface.withValues(alpha: 0.4),
                size: 20,
              ),
            ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _showFilterSheet(context, colorScheme),
            child: Container(
              margin: const EdgeInsets.all(6),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.primary.withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.tune_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(ColorScheme colorScheme) {
    final results = _allProducts.where((p) {
      final matchesQuery = _searchQuery.isEmpty ||
          (p['name'] as String).toLowerCase().contains(_searchQuery);
      final matchesCategory = _selectedCategory == null ||
          p['category'] == _selectedCategory;
      final matchesRegion = _selectedRegion == null ||
          p['region'] == _selectedRegion;
      final matchesPrice = _selectedPriceRange == null ||
          _matchesPriceRange(p['price'] as String);
      return matchesQuery && matchesCategory && matchesRegion && matchesPrice;
    }).toList();

    if (results.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: colorScheme.onSurface.withValues(alpha: 0.06),
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 48,
                color: colorScheme.onSurface.withValues(alpha: 0.2),
              ),
              const SizedBox(height: 12),
              Text(
                'No products found',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search Results',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              '${results.length} found',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Column(
          children: results.map((product) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
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
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      product['icon'] as IconData,
                      color: colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${product['category']} • ${product['region']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: colorScheme.onSurface.withValues(alpha: 0.45),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    product['price'] as String,
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
        ),
      ],
    );
  }

  void _showFilterSheet(BuildContext context, ColorScheme colorScheme) {
    final priceRanges = const [
      'All',
      '0 - 100k',
      '100k - 250k',
      '250k - 500k',
      '500k+',
    ];

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, _, _) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Align(
              alignment: Alignment.centerRight,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.88,
                  height: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(28),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 24,
                        offset: const Offset(-4, 0),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(Icons.tune_rounded,
                                      color: colorScheme.primary, size: 22),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Filter Products',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: colorScheme.onSurface.withValues(alpha: 0.06),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 20,
                                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFilterSection(
                                  'Category',
                                  _categories.map((cat) => cat.label).toList(),
                                  _selectedCategory,
                                  (value) => setModalState(() {
                                    _selectedCategory =
                                        _selectedCategory == value ? null : value;
                                  }),
                                  colorScheme,
                                ),
                                const SizedBox(height: 24),
                                _buildFilterSection(
                                  'Region / Location',
                                  _regions,
                                  _selectedRegion,
                                  (value) => setModalState(() {
                                    _selectedRegion =
                                        _selectedRegion == value ? null : value;
                                  }),
                                  colorScheme,
                                ),
                                const SizedBox(height: 24),
                                _buildFilterSection(
                                  'Price Range (TZS)',
                                  priceRanges,
                                  _selectedPriceRange,
                                  (value) => setModalState(() {
                                    _selectedPriceRange =
                                        _selectedPriceRange == value ? null : value;
                                  }),
                                  colorScheme,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              _showFilterLoadingDialog(context, colorScheme);
                              await Future.delayed(const Duration(seconds: 2));
                              if (!context.mounted) return;
                              Navigator.pop(context);
                              setState(() {
                                _searchQuery = _searchCtrl.text.trim().toLowerCase();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Apply Filters',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              setModalState(() {
                                _selectedCategory = null;
                                _selectedRegion = null;
                                _selectedPriceRange = null;
                              });
                            },
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  colorScheme.onSurface.withValues(alpha: 0.6),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'Clear Filters',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      transitionBuilder: (_, animation, _, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          )),
          child: child,
        );
      },
    );
  }

  Widget _buildFilterSection(
    String title,
    List<String> options,
    String? selectedValue,
    ValueChanged<String> onSelected,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: options.map((option) {
            final isSelected = selectedValue == option;
            return GestureDetector(
              onTap: () => onSelected(option),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colorScheme.primary.withValues(alpha: 0.08)
                      : colorScheme.onSurface.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: 0.08),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: isSelected ? colorScheme.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check_rounded,
                              color: colorScheme.onPrimary,
                              size: 16,
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.75),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  bool _matchesPriceRange(String price) {
    if (_selectedPriceRange == null || _selectedPriceRange == 'All') return true;
    final priceValue = double.tryParse(
          price.replaceAll('\$', '').replaceAll(',', ''),
        ) ??
        0;
    final tzs = priceValue * 2500;

    switch (_selectedPriceRange) {
      case '0 - 100k':
        return tzs >= 0 && tzs <= 100000;
      case '100k - 250k':
        return tzs > 100000 && tzs <= 250000;
      case '250k - 500k':
        return tzs > 250000 && tzs <= 500000;
      case '500k+':
        return tzs > 500000;
      default:
        return true;
    }
  }

  Widget _buildSectionTitle(
    String title,
    String action,
    ColorScheme colorScheme, {
    VoidCallback? onActionTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        if (action.isNotEmpty)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              action,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCategories(ColorScheme colorScheme) {
    return SizedBox(
      height: 82,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return GestureDetector(
            onTap: () => context.go(
              AppConstants.categoryProductsRoute,
              extra: {'category': cat.label},
            ),
            child: SizedBox(
              width: 64,
              child: Column(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    padding: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primary,
                          colorScheme.primary.withValues(alpha: 0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withValues(alpha: 0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          cat.icon,
                          color: colorScheme.primary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cat.label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedProducts(ColorScheme colorScheme) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _featured.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final product = _featured[index];
          return Container(
            width: 150,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: colorScheme.onSurface.withValues(alpha: 0.06),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.06),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(18)),
                  ),
                  child: Center(
                    child: Icon(
                      product['image'] as IconData,
                      size: 44,
                      color: colorScheme.primary.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            product['price'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.star_rounded,
                              size: 14,
                              color: Colors.amber.shade600),
                          const SizedBox(width: 2),
                          Text(
                            product['rating'].toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 11,
                              color: colorScheme.onSurface
                                  .withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentOrders(ColorScheme colorScheme) {
    final orders = List.generate(3, (i) => {
      'id': '#ORD-${2024000 + i}',
      'name': 'Product Item ${i + 1}',
      'status': ['Completed', 'Processing', 'Shipped'][i],
      'price': '\$${(i + 2) * 12}.50',
      'date': 'Jun ${20 + i}, 2026',
    });

    return Column(
      children: orders.map((order) {
        final statusColor = order['status'] == 'Completed'
            ? const Color(0xFF22C55E)
            : order['status'] == 'Processing'
                ? const Color(0xFFF59E0B)
                : colorScheme.primary;
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
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.inventory_2_rounded,
                  color: colorScheme.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['name'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      order['id'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    order['price'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      order['status'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _CategoryItem {
  final IconData icon;
  final String label;
  const _CategoryItem({required this.icon, required this.label});
}

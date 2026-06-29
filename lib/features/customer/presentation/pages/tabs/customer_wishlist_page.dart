import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/constants/app_constants.dart';
import '../../../../../config/di/service_locator.dart';
import '../../data/models/wishlist_item_model.dart';
import '../../cubit/wishlist_cubit.dart';
import '../../cubit/wishlist_state.dart';

class CustomerWishlistPage extends StatefulWidget {
  const CustomerWishlistPage({super.key});

  @override
  State<CustomerWishlistPage> createState() => _CustomerWishlistPageState();
}

class _CustomerWishlistPageState extends State<CustomerWishlistPage> {
  late final WishlistCubit _wishlistCubit;

  @override
  void initState() {
    super.initState();
    _wishlistCubit = sl<WishlistCubit>()..loadWishlist();
  }

  @override
  void dispose() {
    _wishlistCubit.close();
    super.dispose();
  }

  const CustomerWishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final items = List.generate(5, (i) => {
      'name': 'Wishlist Item ${i + 1}',
      'price': '\$${(i + 2) * 15}.99',
      'rating': 4.0 + (i * 0.2),
    });

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wishlist',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${items.length} saved items',
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
                childAspectRatio: 0.78,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: colorScheme.onSurface.withValues(alpha: 0.06),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.06),
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(18)),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.favorite_rounded,
                              size: 40,
                              color: colorScheme.primary.withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  item['price'] as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                const Spacer(),
                                Icon(Icons.star_rounded,
                                    size: 14, color: Colors.amber.shade600),
                                const SizedBox(width: 2),
                                Text(
                                  (item['rating'] as double).toStringAsFixed(1),
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
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

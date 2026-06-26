import 'package:flutter/material.dart';

class SellerOrdersPage extends StatelessWidget {
  const SellerOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final orders = [
      {'name': 'Wireless Headphones', 'id': '#ORD-2024001', 'status': 'Completed', 'amount': '\$129.99', 'customer': 'Sarah M.', 'date': 'Today, 10:23 AM'},
      {'name': 'Running Shoes', 'id': '#ORD-2024002', 'status': 'Processing', 'amount': '\$89.50', 'customer': 'John K.', 'date': 'Today, 09:15 AM'},
      {'name': 'Smart Watch', 'id': '#ORD-2024003', 'status': 'Shipped', 'amount': '\$249.00', 'customer': 'Alice W.', 'date': 'Yesterday'},
      {'name': 'Laptop Stand', 'id': '#ORD-2024004', 'status': 'Pending', 'amount': '\$45.99', 'customer': 'Bob T.', 'date': 'Yesterday'},
      {'name': 'Coffee Beans', 'id': '#ORD-2024005', 'status': 'Completed', 'amount': '\$24.99', 'customer': 'Emma R.', 'date': 'Jun 24'},
    ];

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Orders',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${orders.length} orders today',
                    style: TextStyle(
                      fontSize: 15,
                      color: colorScheme.onSurface.withValues(alpha: 0.45),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildFilterChip('All', true, colorScheme),
                      const SizedBox(width: 8),
                      _buildFilterChip('Pending', false, colorScheme),
                      const SizedBox(width: 8),
                      _buildFilterChip('Shipped', false, colorScheme),
                      const SizedBox(width: 8),
                      _buildFilterChip('Completed', false, colorScheme),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: orders.map((order) {
                      final statusColor = order['status'] == 'Completed'
                          ? const Color(0xFF22C55E)
                          : order['status'] == 'Processing'
                              ? const Color(0xFFF59E0B)
                              : order['status'] == 'Shipped'
                                  ? const Color(0xFF3B82F6)
                                  : const Color(0xFF9CA3AF);
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: colorScheme.onSurface.withValues(alpha: 0.06),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    order['name'] as String,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                ),
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
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.person_outline_rounded,
                                    size: 14,
                                    color: colorScheme.onSurface.withValues(alpha: 0.4)),
                                const SizedBox(width: 4),
                                Text(
                                  order['customer'] as String,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  order['id'] as String,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorScheme.onSurface.withValues(alpha: 0.4),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order['date'] as String,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorScheme.onSurface.withValues(alpha: 0.4),
                                  ),
                                ),
                                Text(
                                  order['amount'] as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isActive, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isActive
            ? colorScheme.primary
            : colorScheme.onSurface.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isActive ? colorScheme.onPrimary : colorScheme.onSurface,
        ),
      ),
    );
  }
}

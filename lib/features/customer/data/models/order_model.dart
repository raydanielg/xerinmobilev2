class OrderModel {
  final String id;
  final String orderNumber;
  final double total;
  final String currency;
  final String status;
  final String? statusLabel;
  final int itemCount;
  final String? createdAt;
  final List<OrderItemModel> items;

  const OrderModel({
    required this.id,
    required this.orderNumber,
    required this.total,
    this.currency = 'TZS',
    required this.status,
    this.statusLabel,
    this.itemCount = 0,
    this.createdAt,
    this.items = const [],
  });

  String get formattedTotal {
    final formatted = total.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return '$currency $formatted';
  }

  String get displayStatus => statusLabel ?? status;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>? ?? [];
    return OrderModel(
      id: json['id']?.toString() ?? '',
      orderNumber: json['order_number'] as String? ?? json['id']?.toString() ?? '',
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'TZS',
      status: json['status'] as String? ?? 'pending',
      statusLabel: json['status_label'] as String?,
      itemCount: (json['item_count'] as num?)?.toInt() ?? itemsList.length,
      createdAt: json['created_at'] as String?,
      items: itemsList
          .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class OrderItemModel {
  final String id;
  final String productName;
  final String? productImage;
  final int quantity;
  final double price;
  final String currency;

  const OrderItemModel({
    required this.id,
    required this.productName,
    this.productImage,
    this.quantity = 1,
    required this.price,
    this.currency = 'TZS',
  });

  String get formattedPrice {
    final formatted = price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return '$currency $formatted';
  }

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        id: json['id']?.toString() ?? '',
        productName: json['product_name'] as String? ?? json['name'] as String? ?? '',
        productImage: json['product_image'] as String? ?? json['image'] as String?,
        quantity: (json['quantity'] as num?)?.toInt() ?? 1,
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        currency: json['currency'] as String? ?? 'TZS',
      );
}

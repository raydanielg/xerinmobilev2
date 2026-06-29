import 'product_model.dart';

class WishlistItemModel {
  final String id;
  final String productId;
  final String name;
  final String? description;
  final double price;
  final double? salePrice;
  final String currency;
  final String? imageUrl;
  final String? categoryName;
  final double rating;
  final bool inStock;
  final int stockQuantity;
  final String? createdAt;

  const WishlistItemModel({
    required this.id,
    required this.productId,
    required this.name,
    this.description,
    required this.price,
    this.salePrice,
    this.currency = 'TZS',
    this.imageUrl,
    this.categoryName,
    this.rating = 0.0,
    this.inStock = true,
    this.stockQuantity = 0,
    this.createdAt,
  });

  bool get hasDiscount => salePrice != null && salePrice! < price;

  String get formattedPrice {
    final formatted = price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return '$currency $formatted';
  }

  String? get formattedSalePrice {
    if (salePrice == null) return null;
    final formatted = salePrice!.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return '$currency $formatted';
  }

  int? get discountPercent {
    if (!hasDiscount) return null;
    return ((1 - salePrice! / price) * 100).toInt();
  }

  ProductModel toProductModel() {
    return ProductModel(
      id: productId,
      sellerId: '',
      categoryId: '',
      sku: '',
      name: name,
      slug: '',
      description: description,
      price: price,
      salePrice: salePrice,
      currency: currency,
      status: inStock ? 'active' : 'inactive',
      isActive: inStock,
      categoryName: categoryName,
      rating: rating,
      images: imageUrl != null ? [imageUrl!] : const [],
    );
  }

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>?;
    final productId = product != null
        ? product['id']?.toString() ?? json['product_id']?.toString() ?? ''
        : json['product_id']?.toString() ?? '';
    final productName = product != null
        ? product['name'] as String? ?? json['name'] as String? ?? ''
        : json['name'] as String? ?? '';
    final productPrice = _parsePrice(product?['price'] ?? json['price']);
    final productSalePrice = product?['sale_price'] != null || json['sale_price'] != null
        ? _parsePrice(product?['sale_price'] ?? json['sale_price'])
        : null;
    final rawImages = product?['images'] ?? json['images'];
    String? firstImage;
    if (rawImages is List && rawImages.isNotEmpty) {
      final first = rawImages.first;
      if (first is String) {
        firstImage = first;
      } else if (first is Map) {
        firstImage = first['image_url'] ?? first['url'] ?? first['src'];
      }
    }
    final productImage = product?['thumbnail_url'] ?? json['thumbnail_url'] ?? firstImage;
    final stockQuantity = product?['stock_quantity'] ?? json['stock_quantity'];
    final inStock = product?['in_stock'] ?? json['in_stock'] ?? (stockQuantity != null && (stockQuantity as num) > 0);

    return WishlistItemModel(
      id: json['id']?.toString() ?? '',
      productId: productId,
      name: productName,
      description: product?['description'] as String? ?? json['description'] as String?,
      price: productPrice,
      salePrice: productSalePrice,
      currency: product?['currency'] as String? ?? json['currency'] as String? ?? 'TZS',
      imageUrl: productImage as String?,
      categoryName: product?['category_name'] as String? ?? json['category_name'] as String?,
      rating: (product?['rating'] as num?)?.toDouble() ?? (json['rating'] as num?)?.toDouble() ?? 0.0,
      inStock: inStock is bool ? inStock : true,
      stockQuantity: (stockQuantity as num?)?.toInt() ?? (inStock == true ? 1 : 0),
      createdAt: json['created_at'] as String?,
    );
  }

  static double _parsePrice(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value.replaceAll(',', '')) ?? 0.0;
    }
    return 0.0;
  }
}

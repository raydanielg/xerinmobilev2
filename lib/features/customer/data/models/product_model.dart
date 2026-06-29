class ProductModel {
  final String id;
  final String name;
  final String? description;
  final double price;
  final String currency;
  final String? categoryId;
  final String? categoryName;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final String? status;
  final int stockQuantity;

  const ProductModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.currency = 'TZS',
    this.categoryId,
    this.categoryName,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.images = const [],
    this.status,
    this.stockQuantity = 0,
  });

  String get formattedPrice {
    final formatted = price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return '$currency $formatted';
  }

  String? get thumbnailUrl => images.isNotEmpty ? images.first : null;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rawImages = json['images'];
    List<String> imageUrls = [];
    if (rawImages is List) {
      for (final img in rawImages) {
        if (img is String) {
          imageUrls.add(img);
        } else if (img is Map) {
          final url = img['url'] ?? img['image_url'] ?? img['src'];
          if (url is String) imageUrls.add(url);
        }
      }
    }

    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'TZS',
      categoryId: json['category_id']?.toString(),
      categoryName: json['category_name'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['review_count'] as int?) ?? 0,
      images: imageUrls,
      status: json['status'] as String?,
      stockQuantity: (json['stock_quantity'] as int?) ?? 0,
    );
  }
}

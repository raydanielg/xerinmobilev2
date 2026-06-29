class CategoryModel {
  final String id;
  final String name;
  final String? description;
  final int productCount;

  const CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.productCount = 0,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id']?.toString() ?? '',
        name: json['name'] as String,
        description: json['description'] as String?,
        productCount: (json['product_count'] as int?) ?? 0,
      );
}

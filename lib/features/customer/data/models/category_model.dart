class CategoryModel {
  final String id;
  final String? parentId;
  final String name;
  final String slug;
  final String? createdAt;

  const CategoryModel({
    required this.id,
    this.parentId,
    required this.name,
    required this.slug,
    this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id']?.toString() ?? '',
        parentId: json['parent_id']?.toString(),
        name: json['name'] as String,
        slug: json['slug'] as String,
        createdAt: json['created_at'] as String?,
      );
}

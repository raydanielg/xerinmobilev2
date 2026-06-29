import 'package:equatable/equatable.dart';

import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

class ProductsLoaded extends ProductsState {
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final List<ProductModel> trending;
  final bool isLoadingMore;
  final String? error;

  const ProductsLoaded({
    this.categories = const [],
    this.products = const [],
    this.trending = const [],
    this.isLoadingMore = false,
    this.error,
  });

  ProductsLoaded copyWith({
    List<CategoryModel>? categories,
    List<ProductModel>? products,
    List<ProductModel>? trending,
    bool? isLoadingMore,
    String? error,
  }) =>
      ProductsLoaded(
        categories: categories ?? this.categories,
        products: products ?? this.products,
        trending: trending ?? this.trending,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        error: error,
      );

  @override
  List<Object?> get props =>
      [categories, products, trending, isLoadingMore, error];
}

class ProductsError extends ProductsState {
  final String message;
  const ProductsError({required this.message});
  @override
  List<Object?> get props => [message];
}

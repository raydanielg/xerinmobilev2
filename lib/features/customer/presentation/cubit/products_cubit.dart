import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../data/datasources/product_remote_datasource.dart';
import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRemoteDataSource _productDs;
  final Logger _logger;

  ProductsCubit({
    required ProductRemoteDataSource productDataSource,
    required this._logger,
  })  : _productDs = productDataSource,
        super(const ProductsInitial());

  Future<void> loadCategories() async {
    emit(const ProductsLoading());
    try {
      final categories = await _productDs.getCategories();
      _logger.i('📂 Categories loaded: ${categories.length}');
      emit(ProductsLoaded(categories: categories));
    } catch (e) {
      _logger.e('❌ Categories load error: $e');
      emit(const ProductsError(message: 'Failed to load categories'));
    }
  }

  Future<void> loadProducts({
    String? categoryId,
    String? search,
    int limit = 50,
  }) async {
    emit(const ProductsLoading());
    try {
      final products = await _productDs.getProducts(
        categoryId: categoryId,
        search: search,
        limit: limit,
        isActive: true,
      );
      _logger.i('🛍️ Products loaded: ${products.length}');
      emit(ProductsLoaded(products: products));
    } catch (e) {
      _logger.e('❌ Products load error: $e');
      emit(const ProductsError(message: 'Failed to load products'));
    }
  }

  Future<void> loadTrending({int limit = 10}) async {
    emit(const ProductsLoading());
    try {
      final trending = await _productDs.getProducts(
        limit: limit,
        sortBy: 'created_at',
        isActive: true,
      );
      _logger.i('🔥 Trending loaded: ${trending.length}');
      emit(ProductsLoaded(trending: trending));
    } catch (e) {
      _logger.e('❌ Trending load error: $e');
      emit(const ProductsError(message: 'Failed to load trending products'));
    }
  }

  Future<void> loadAll({int productLimit = 50}) async {
    emit(const ProductsLoading());
    try {
      final catFuture = _productDs.getCategories().then<dynamic>((v) => v).catchError((_) => null);
      final prodFuture = _productDs.getProducts(limit: productLimit, isActive: true).then<dynamic>((v) => v).catchError((_) => null);
      final results = await Future.wait([catFuture, prodFuture]);
      final categories = results[0] is List ? (results[0] as List).whereType<CategoryModel>().toList() : <CategoryModel>[];
      final products = results[1] is List ? (results[1] as List).whereType<ProductModel>().toList() : <ProductModel>[];
      _logger.i(
        '✅ Products page loaded — categories: ${categories.length}, products: ${products.length}',
      );
      emit(ProductsLoaded(
        categories: categories,
        products: products,
      ));
    } catch (e) {
      _logger.e('❌ Products page load error: $e');
      emit(const ProductsError(message: 'Failed to load products'));
    }
  }
}

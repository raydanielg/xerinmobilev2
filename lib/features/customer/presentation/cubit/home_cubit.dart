import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../auth/data/datasources/auth_remote_datasource.dart';
import '../../data/datasources/product_remote_datasource.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ProductRemoteDataSource _productDs;
  final AuthRemoteDataSource _authDs;
  final Logger _logger;

  HomeCubit({
    required ProductRemoteDataSource productDataSource,
    required AuthRemoteDataSource authDataSource,
    required Logger logger,
  })  : _productDs = productDataSource,
        _authDs = authDataSource,
        _logger = logger,
        super(const HomeInitial());

  Future<void> loadHome() async {
    emit(const HomeLoading());
    try {
      final results = await Future.wait([
        _authDs.getMyProfile().catchError((_) => null),
        _productDs.getCategories().catchError((_) => <dynamic>[]),
        _productDs
            .getProducts(perPage: 10)
            .catchError((_) => <dynamic>[]),
      ]);

      final user = results[0];
      final categories = results[1];
      final featured = results[2];

      _logger.i(
        '✅ Home loaded — user: ${user?.fullName ?? "guest"}, '
        'categories: ${(categories as List).length}, '
        'featured: ${(featured as List).length}',
      );

      emit(HomeLoaded(
        user: results[0],
        categories: (results[1] as List).cast(),
        featuredProducts: (results[2] as List).cast(),
      ));
    } on ServerException catch (e) {
      _logger.e('❌ Home load error: ${e.message}');
      emit(HomeError(message: e.message));
    } catch (e) {
      _logger.e('❌ Home load unexpected error: $e');
      emit(HomeError(message: 'Failed to load home data'));
    }
  }

  Future<void> searchProducts(String query) async {
    final current = state;
    if (current is! HomeLoaded) return;
    if (query.isEmpty) {
      emit(current.copyWith(searchResults: [], isSearching: false));
      return;
    }
    emit(current.copyWith(isSearching: true));
    try {
      final results = await _productDs.getProducts(search: query, perPage: 30);
      _logger.i('🔍 Search "$query" → ${results.length} results');
      if (isClosed) return;
      final refreshed = state is HomeLoaded ? state as HomeLoaded : current;
      emit(refreshed.copyWith(searchResults: results, isSearching: false));
    } on ServerException catch (e) {
      _logger.e('❌ Search error: ${e.message}');
      if (isClosed) return;
      emit(current.copyWith(isSearching: false));
    } catch (_) {
      if (isClosed) return;
      emit(current.copyWith(isSearching: false));
    }
  }

  Future<void> loadByCategory(String categoryId) async {
    final current = state;
    if (current is! HomeLoaded) return;
    emit(current.copyWith(isSearching: true));
    try {
      final results = await _productDs.getProducts(
          categoryId: categoryId, perPage: 30);
      _logger.i('📂 Category $categoryId → ${results.length} products');
      if (isClosed) return;
      final refreshed = state is HomeLoaded ? state as HomeLoaded : current;
      emit(refreshed.copyWith(searchResults: results, isSearching: false));
    } catch (_) {
      if (isClosed) return;
      emit(current.copyWith(isSearching: false));
    }
  }
}

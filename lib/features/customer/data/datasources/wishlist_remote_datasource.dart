import 'package:dio/dio.dart';

import '../../../../config/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/wishlist_item_model.dart';

class WishlistRemoteDataSource {
  final ApiClient _client;

  const WishlistRemoteDataSource(this._client);

  Future<List<WishlistItemModel>> getWishlist() async {
    try {
      final response = await _client.get(ApiConstants.wishlist);
      final data = response.data;
      List<dynamic> list;
      if (data is List) {
        list = data;
      } else if (data is Map && data['items'] != null) {
        list = data['items'] as List;
      } else if (data is Map && data['data'] != null) {
        list = data['data'] as List;
      } else {
        list = [];
      }
      return list
          .map((e) => WishlistItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(_client.getErrorMessage(e));
    }
  }

  Future<WishlistItemModel> addToWishlist({required String productId}) async {
    try {
      final response = await _client.post(
        ApiConstants.wishlist,
        data: {'product_id': productId},
      );
      return WishlistItemModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(_client.getErrorMessage(e));
    }
  }

  Future<void> removeFromWishlist({required String wishlistItemId}) async {
    try {
      await _client.delete(ApiConstants.wishlistById(wishlistItemId));
    } on DioException catch (e) {
      throw ServerException(_client.getErrorMessage(e));
    }
  }

  Future<bool> toggleWishlistItem({required String productId}) async {
    try {
      final response = await _client.post(
        ApiConstants.toggleWishlistItem(productId),
      );
      final data = response.data;
      if (data is Map && data['is_wishlisted'] is bool) {
        return data['is_wishlisted'] as bool;
      }
      return true;
    } on DioException catch (e) {
      throw ServerException(_client.getErrorMessage(e));
    }
  }
}

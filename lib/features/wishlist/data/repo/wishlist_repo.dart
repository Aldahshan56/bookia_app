import 'dart:developer';

import 'package:bookia_app/core/service/local/app_local_storage.dart';
import 'package:bookia_app/core/service/remote/dio_provider.dart';
import 'package:bookia_app/core/service/remote/endpoints.dart';
import 'package:bookia_app/features/home/data/models/get_arrivals_books_response/get_arrivals_books_response.dart';
import 'package:bookia_app/features/wishlist/data/models/get_wishlist_response/get_wishlist_response.dart';

class WishlistRepo {
  static Future<GetWishlistResponse?> getWishlist() async {
    try {
      var response = await DioProvider.get(
          endpoint: AppEndpoints.getWishlist,
          headers: {
            "Authorization":
                "Bearer ${AppLocalStorage.getData(AppLocalStorage.token)}"
          });
      if (response.statusCode == 200) {
        return GetWishlistResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> addToWishlist({required int productId}) async {
    try {
      var response = await DioProvider.post(
          data: {"product_id": productId},
          endpoint: AppEndpoints.addWishlist,
          headers: {
            "Authorization":
                "Bearer ${AppLocalStorage.getData(AppLocalStorage.token)}"
          });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> removeFromWishlist({required int productId}) async {
    try {
      var response = await DioProvider.post(
          data: {"product_id": productId},
          endpoint: AppEndpoints.removeWishlist,
          headers: {
            "Authorization":
                "Bearer ${AppLocalStorage.getData(AppLocalStorage.token)}"
          });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}

import 'dart:developer';

import 'package:bookia_app/core/service/local/app_local_storage.dart';
import 'package:bookia_app/core/service/remote/dio_provider.dart';
import 'package:bookia_app/core/service/remote/endpoints.dart';
import 'package:bookia_app/features/home/data/models/get_arrivals_books_response/get_arrivals_books_response.dart';
import 'package:bookia_app/features/wishlist/data/models/get_wishlist_response/get_wishlist_response.dart';
import '../models/request/place_order_params.dart';
import '../models/response/get_cart_response/get_cart_response.dart';

class CartListRepo {
  static Future<GetCartResponse?> getCart() async {
    try {
      var response = await DioProvider.get(
          endpoint: AppEndpoints.getCartList,
          headers: {
            "Authorization":
                "Bearer ${AppLocalStorage.getData(AppLocalStorage.token)}"
          });
      if (response.statusCode == 200) {
        return GetCartResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> addToCart({required int productId}) async {
    try {
      var response = await DioProvider.post(
          data: {"product_id": productId},
          endpoint: AppEndpoints.addCartList,
          headers: {
            "Authorization":
                "Bearer ${AppLocalStorage.getData(AppLocalStorage.token)}"
          });
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("------------------------------");
      log(e.toString());
      return false;
    }
  }

  static Future<bool> removeFromCart({required int cartItemId}) async {
    try {
      var response = await DioProvider.post(
          data: {"cart_item_id": cartItemId},
          endpoint: AppEndpoints.removeCartList,
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

  static Future<GetCartResponse?> updateCartItemQuantity(
      {required int cartItemId, required int quantity}) async {
    try {
      var response = await DioProvider.post(
          data: {"cart_item_id": cartItemId, "quantity": quantity},
          endpoint: AppEndpoints.updateCartList,
          headers: {
            "Authorization":
                "Bearer ${AppLocalStorage.getData(AppLocalStorage.token)}"
          });
      if (response.statusCode == 201) {
        return GetCartResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> checkOut() async {
    try {
      var response = await DioProvider.get(
          endpoint: AppEndpoints.checkOut,
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
      log("------------------------------");
      log(e.toString());
      return false;
    }
  }

  static Future<bool> placeOrderParams(
      {required PlaceOrderParams params}) async {
    try {
      var response = await DioProvider.post(
          data: params.toJson(),
          endpoint: AppEndpoints.placeOrder,
          headers: {
            "Authorization":
                "Bearer ${AppLocalStorage.getData(AppLocalStorage.token)}"
          });
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("------------------------------");
      log(e.toString());
      return false;
    }
  }
}

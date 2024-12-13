import 'dart:developer';

import 'package:bookia_app/core/service/remote/dio_provider.dart';
import 'package:bookia_app/core/service/remote/endpoints.dart';
import 'package:bookia_app/features/home/data/models/get_arrivals_books_response/get_arrivals_books_response.dart';
import 'package:bookia_app/features/home/data/models/get_sliders_books_response/get_sliders_response.dart';

class HomeRepo {
  static Future<GetArrivalsBooksResponse?> getNewArrivalsBooks() async {
    try {
      var response =
          await DioProvider.get(endpoint: AppEndpoints.newArrivalsBooks);
      if (response.statusCode == 200) {
        return GetArrivalsBooksResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<GetSlidersResponse?> getSliders() async {
    try {
      var response = await DioProvider.get(endpoint: AppEndpoints.sliders);
      if (response.statusCode == 200) {
        return GetSlidersResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

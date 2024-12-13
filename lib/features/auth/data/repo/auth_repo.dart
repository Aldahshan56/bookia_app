import 'dart:developer';

import 'package:bookia_app/core/service/remote/dio_provider.dart';
import 'package:bookia_app/core/service/remote/endpoints.dart';
import 'package:bookia_app/features/auth/data/model/request/user_model_params.dart';
import 'package:bookia_app/features/auth/data/model/response/user_model_response/user_model_response.dart';

class AuthRepo {
  static Future<UserModelResponse?> register(UserModelParams params) async {
    try {
      log(params.toJson().toString());
      log("--------------------------++++test++++-----------------------");
      var response = await DioProvider.post(
          endpoint: AppEndpoints.register, data: params.toJson());
      if (response.statusCode == 201) {
        log("--------------------------1-----------------------");
        return UserModelResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<UserModelResponse?> login(UserModelParams params) async {
    try {
      log(params.toJson().toString());
      log("--------------------------++++testLogin++++-----------------------");
      var response = await DioProvider.post(
          endpoint: AppEndpoints.login, data: params.toJson());
      if (response.statusCode == 200) {
        log("--------------------------1-----------------------");
        return UserModelResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }
}

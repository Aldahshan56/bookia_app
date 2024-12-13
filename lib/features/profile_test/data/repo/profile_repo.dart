import 'dart:developer';

import 'package:bookia_app/core/service/remote/dio_provider.dart';
import 'package:bookia_app/core/service/remote/endpoints.dart';
import 'package:dio/dio.dart';
import '../../../../core/service/local/app_local_storage.dart';
import '../model/request/edit_user_model_params.dart';
import '../model/response/get_profile_response/get_profile_response.dart';

class ProfileRepo {
  static Future<GetProfileResponse?>getProfile()async{
    try{
      var response=await DioProvider.get(
          endpoint: AppEndpoints.getProfile,
        headers: {
            "Authorization":"Bearer ${AppLocalStorage.getData(AppLocalStorage.token)}"
        }
      );
      if(response.statusCode==200){
        return GetProfileResponse.fromJson(response.data);
      }else{
        return null;
      }
    }catch(e){
      log(e.toString());
    }
    return null;
  }

  static Future<bool> updateProfile(EditUserModelParams model) async {
    try {
      var response = await DioProvider.post(
        endpoint: AppEndpoints.updateProfile,
        data: FormData.fromMap({
          if(model.name !=null) "name":model.name,
          if(model.phone !=null)  "phone":model.phone,
          if(model.address !=null)  "address":model.address,
          if(model.image !=null)
            "image":MultipartFile.fromFile(
                model.image?? " ",
                filename: model.image?.split('/').last
            ),
        }),
        headers: {
          "Authorization":
          "Bearer ${AppLocalStorage.getData(AppLocalStorage.token)}"
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return true;
    }
  }

  static Future<bool> logout() async {
    try {
      log('=============6554==============');
      var response = await DioProvider.post(
          endpoint: AppEndpoints.logout,
          headers: {
            "Authorization":
            "Bearer ${AppLocalStorage.getData(AppLocalStorage.token)}"
          });
      log('====1=2==23=32==32==32=');
      if (response.statusCode == 200) {
        log('200200200200202000200200202');
        return true;
      } else {
        log("111111111111111111111111111111111");
        return false;
      }
    } catch (e) {
      log("--------------------34324343553----------");
      log(e.toString());
      return false;
    }
  }
}

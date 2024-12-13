

import 'dart:developer';

import 'package:bookia_app/features/profile_test/presentation/bloc/profile_event.dart';
import 'package:bookia_app/features/profile_test/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/local/app_local_storage.dart';
import '../../data/model/response/get_profile_response/get_profile_response.dart';
import '../../data/repo/profile_repo.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfileEvent>(getProfile);
    on<UpdateProfileEvent>(updateProfile);
    on<LogoutEvent>(logOut);
  }

  GetProfileResponse? profileResponse;

  Future<void> getProfile(
      GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(GetProfileLoadingState());

    try {
      await ProfileRepo.getProfile().then(
        (value) {
          if (value != null) {
            profileResponse = value;
            emit(GetProfileSuccessState());
          } else {
            emit(ProfileErrorState(
                massage: "Unexpected Error occur, please try again"));
          }
        },
      );
    } on Exception {
      emit(ProfileErrorState(
          massage: "Unexpected Error occur, please try again"));
    }
  }

  Future<void> updateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(UpdateProfileLoadingState());

    try {
      await ProfileRepo.updateProfile(event.params).then(
            (value) {
          if (value ) {

            emit(UpdateProfileSuccessState());
          } else {
            emit(ProfileErrorState(
                massage: "Unexpected Error occur, please try again"));
          }
        },
      );
    } on Exception {
      emit(ProfileErrorState(
          massage: "Unexpected Error occur, please try again"));
    }
  }

  Future<void> logOut(LogoutEvent event, Emitter<ProfileState> emit) async {
    emit(LogOutLoadingState());
    try {
      await ProfileRepo.logout().then((value) {
        String? currentToken = AppLocalStorage.getData(AppLocalStorage.token);
        log("قيمة التوكن الحالية: $currentToken");
        if (value == true) {
          log("1=1=1==1==1==1==1=1=1==1==1===1==1==1=1=1");
          AppLocalStorage.remove(AppLocalStorage.token);
          log("++++++++++++++++++++++++++++++++++++++++++++++++++");
          emit(LogOutLoadedState());
          log("++++++++++++++++++++++++++++++++++++++++++++++++++");
          log("تم تسجيل الخروج بنجاح");
          bool? tokenAfterLogout = AppLocalStorage.getData(AppLocalStorage.token);
          log("قيمة التوكن بعد الخروج: $tokenAfterLogout");
          log('2-2---2-2--2--2--2----2--2--2--2--2');

          log('3-3--3--3-----3----3--3--3--3--3-3--3-3-');
        } else {
          emit(ProfileErrorState(
              massage: "Unexpected Error occur, please try again"));
          log("4444444444444444444444444444444444");
        }
      });
    } on Exception catch (e) {
      emit(ProfileErrorState(massage: "Unexpected Error occur, please try again"));
      log("Error: $e");
    }
  }

}

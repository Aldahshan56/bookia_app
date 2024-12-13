class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileLoadingState extends ProfileState {}

class GetProfileSuccessState extends ProfileState {}


class UpdateProfileLoadingState extends ProfileState {}

class UpdateProfileSuccessState extends ProfileState {}

//LogOut
class LogOutLoadingState extends ProfileState {}

class LogOutLoadedState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String massage;

  ProfileErrorState({required this.massage});
}

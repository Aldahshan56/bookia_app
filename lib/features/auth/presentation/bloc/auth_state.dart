class AuthState {}

class AuthInitialState extends AuthState {}

//Login
class AuthLoginLoadingState extends AuthState {}

class AuthLoginSuccessState extends AuthState {}

//Register
class AuthRegisterLoadingState extends AuthState {}

class AuthRegisterSuccessState extends AuthState {}

//Error
class AuthErrorState extends AuthState {
  String message;
  AuthErrorState({required this.message});
}

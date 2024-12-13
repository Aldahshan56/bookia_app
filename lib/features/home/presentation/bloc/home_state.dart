class HomeState {}

class HomeInitialState extends HomeState {}

//New Arrivals
class NewArrivalsBooksLoadingState extends HomeState {}

class NewArrivalsBooksLoadedState extends HomeState {}

// Sliders
class GetSlidersLoadingState extends HomeState {}

class GetSlidersLoadedState extends HomeState {}

// wishList
class GetWishlistLoadingState extends HomeState {}

class GetWishlistLoadedState extends HomeState {}

class AddWishlistLoadingState extends HomeState {}

class AddWishlistLoadedState extends HomeState {}

class RemoveFromWishlistLoadingState extends HomeState {}

class RemoveFromWishlistLoadedState extends HomeState {}

//Cart
class GetCartLoadingState extends HomeState {}

class GetCartLoadedState extends HomeState {}

class AddCartLoadingState extends HomeState {}

class AddCartLoadedState extends HomeState {}

class RemoveFromCartLoadingState extends HomeState {}

class RemoveFromCartLoadedState extends HomeState {}

class UpdateFromCartLoadingState extends HomeState {}

class UpdateFromCartLoadedState extends HomeState {}

//CheckOut
class CheckOutLoadingState extends HomeState {}

class CheckOutLoadedState extends HomeState {}

//PlaceOrder
class PlaceOrderLoadingState extends HomeState {}

class PlaceOrderLoadedState extends HomeState {}

//Error
class HomeErrorState extends HomeState {
  String message;
  HomeErrorState({required this.message});
}


import 'package:bookia_app/features/cart/data/models/request/place_order_params.dart';

class HomeEvent {}

class GetNewArrivalsBookEvent extends HomeEvent {}

class GetSlidersEvent extends HomeEvent {}

class GetWishlistEvent extends HomeEvent {}

class AddWishlistEvent extends HomeEvent {
  final int productId;
  AddWishlistEvent({required this.productId});
}

class RemoveWishlistEvent extends HomeEvent {
  final int productId;
  RemoveWishlistEvent({required this.productId});
}

class GetCartEvent extends HomeEvent {}

class AddCartEvent extends HomeEvent {
  final int productId;
  AddCartEvent({required this.productId});
}

class RemoveCartEvent extends HomeEvent {
  final int cartItemId;
  RemoveCartEvent({required this.cartItemId});
}

class UpdateCartEvent extends HomeEvent {
  final int cartItemId;
  final int quantity;
  UpdateCartEvent({required this.cartItemId, required this.quantity});
}

class CheckOutEvent extends HomeEvent {}

class PlaceOrderEvent extends HomeEvent {
  final PlaceOrderParams params;
  PlaceOrderEvent({required this.params});
}

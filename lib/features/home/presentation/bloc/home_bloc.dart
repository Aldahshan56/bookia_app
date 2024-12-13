import 'dart:developer';

import 'package:bookia_app/features/auth/data/model/response/user_model_response/data.dart';
import 'package:bookia_app/features/cart/data/repo/cart_repo.dart';
import 'package:bookia_app/features/home/data/models/get_arrivals_books_response/get_arrivals_books_response.dart';
import 'package:bookia_app/features/home/data/models/get_arrivals_books_response/product.dart';
import 'package:bookia_app/features/home/data/models/get_sliders_books_response/get_sliders_response.dart';
import 'package:bookia_app/features/home/data/models/get_sliders_books_response/slider.dart';
import 'package:bookia_app/features/home/data/repo/home_repo.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_state.dart';
import 'package:bookia_app/features/wishlist/data/models/get_wishlist_response/get_wishlist_response.dart';
import 'package:bookia_app/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/data/models/response/get_cart_response/get_cart_response.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<GetNewArrivalsBookEvent>(getNewArrivals);
    on<GetSlidersEvent>(getSliders);
    on<GetWishlistEvent>(getWishlist);
    on<AddWishlistEvent>(addToWishlist);
    on<RemoveWishlistEvent>(removeFromWishlist);
    on<GetCartEvent>(getCart);
    on<AddCartEvent>(addToCart);
    on<RemoveCartEvent>(removeCart);
    on<UpdateCartEvent>(updateCart);
    on<CheckOutEvent>(checkOut);
    on<PlaceOrderEvent>(placeOrder);
  }
  List<Product> newArrivalBooks = [];
  List<Slider> sliders = [];
  List<Product> wishlist = [];
  GetCartResponse? cartResponse;
  Future<void> getNewArrivals(
      GetNewArrivalsBookEvent event, Emitter<HomeState> emit) async {
    emit(NewArrivalsBooksLoadingState());
    try {
      await HomeRepo.getNewArrivalsBooks().then((value) {
        if (value != null) {
          newArrivalBooks = value.data?.products ?? [];
          emit(NewArrivalsBooksLoadedState());
        } else {
          emit(HomeErrorState(
              message: "Unexpected Error occur,please try again"));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: "Unexpected Error occur,please try again"));
    }
  }

  //Sliders

  Future<void> getSliders(
      GetSlidersEvent event, Emitter<HomeState> emit) async {
    emit(GetSlidersLoadingState());
    try {
      await HomeRepo.getSliders().then((value) {
        if (value != null) {
          sliders = value.data?.sliders ?? [];
          emit(GetSlidersLoadedState());
        } else {
          emit(HomeErrorState(
              message: "Unexpected Error occur,please try again"));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: "Unexpected Error occur,please try again"));
    }
  }

  //wishlist
  Future<void> getWishlist(
      GetWishlistEvent event, Emitter<HomeState> emit) async {
    emit(GetWishlistLoadingState());
    try {
      await WishlistRepo.getWishlist().then((value) {
        if (value != null) {
          wishlist = value.data?.data ?? [];
          emit(GetWishlistLoadedState());
        } else {
          emit(HomeErrorState(
              message: "Unexpected Error occur,please try again"));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: "Unexpected Error occur,please try again"));
    }
  }

  Future<void> addToWishlist(
      AddWishlistEvent event, Emitter<HomeState> emit) async {
    emit(AddWishlistLoadingState());
    try {
      await WishlistRepo.addToWishlist(productId: event.productId)
          .then((value) {
        if (value == true) {
          emit(AddWishlistLoadedState());
        } else {
          emit(HomeErrorState(
              message: "Unexpected Error occur,please try again"));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: "Unexpected Error occur,please try again"));
    }
  }

  Future<void> removeFromWishlist(
      RemoveWishlistEvent event, Emitter<HomeState> emit) async {
    emit(RemoveFromWishlistLoadingState());
    try {
      await WishlistRepo.removeFromWishlist(productId: event.productId)
          .then((value) {
        if (value == true) {
          emit(RemoveFromWishlistLoadedState());
        } else {
          emit(HomeErrorState(
              message: "Unexpected Error occur,please try again"));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: "Unexpected Error occur,please try again"));
    }
  }

  //cart
  Future<void> getCart(GetCartEvent event, Emitter<HomeState> emit) async {
    emit(GetCartLoadingState());
    try {
      await CartListRepo.getCart().then((value) {
        if (value != null) {
          cartResponse = value;
          emit(GetCartLoadedState());
        } else {
          emit(HomeErrorState(
              message: "Unexpected Error occur,please try again"));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: "Unexpected Error occur,please try again"));
    }
  }

  Future<void> addToCart(AddCartEvent event, Emitter<HomeState> emit) async {
    emit(AddCartLoadingState());
    try {
      await CartListRepo.addToCart(productId: event.productId).then((value) {
        if (value == true) {
          log("==================true===============");
          emit(AddCartLoadedState());
        } else {
          emit(HomeErrorState(
              message: "Unexpected Error occur,please try again"));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: "Unexpected Error occur,please try again"));
    }
  }

  Future<void> updateCart(
      UpdateCartEvent event, Emitter<HomeState> emit) async {
    emit(UpdateFromCartLoadingState());
    try {
      await CartListRepo.updateCartItemQuantity(
              cartItemId: event.cartItemId, quantity: event.quantity)
          .then((value) {
        if (value != null) {
          cartResponse = value;
          emit(UpdateFromCartLoadedState());
        } else {
          emit(HomeErrorState(
              message: "Unexpected Error occur,please try again"));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: "Unexpected Error occur,please try again"));
    }
  }

  Future<void> removeCart(
      RemoveCartEvent event, Emitter<HomeState> emit) async {
    emit(RemoveFromCartLoadingState());
    try {
      await CartListRepo.removeFromCart(cartItemId: event.cartItemId)
          .then((value) {
        if (value == true) {
          log("==========loaded=========0");
          emit(RemoveFromCartLoadedState());
          log("==========loaded=========1");
        } else {
          emit(HomeErrorState(
              message: "Unexpected Error occur,please try again"));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: "Unexpected Error occur,please try again"));
    }
  }

  Future<void> checkOut(CheckOutEvent event, Emitter<HomeState> emit) async {
    emit(CheckOutLoadingState());
    try {
      await CartListRepo.checkOut().then((value) {
        if (value == true) {
          log("==========loaded=========0");
          emit(CheckOutLoadedState());
          log("==========loaded=========1");
        } else {
          emit(HomeErrorState(
              message: "Unexpected Error occur,please try again"));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: "Unexpected Error occur,please try again"));
    }
  }

  Future<void> placeOrder(
      PlaceOrderEvent event, Emitter<HomeState> emit) async {
    emit(PlaceOrderLoadingState());
    try {
      await CartListRepo.placeOrderParams(params: event.params).then((value) {
        if (value == true) {
          log("==========loaded=========0");
          emit(PlaceOrderLoadedState());
          log("==========loaded=========1");
        } else {
          emit(HomeErrorState(
              message: "Unexpected Error occur,please try again"));
        }
      });
    } on Exception {
      emit(HomeErrorState(message: "Unexpected Error occur,please try again"));
    }
  }
}

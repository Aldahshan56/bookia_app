class AppEndpoints {
  static const String baseUrl = 'https://codingarabic.online/api';

  // auth
  static const String login = '/login';
  static const String register = '/register';

  // home

  static const String newArrivalsBooks = '/products-new-arrivals';

  // Sliders
  static const String sliders = '/sliders';

  // wishlist
  static const String addWishlist = '/add-to-wishlist';
  static const String getWishlist = '/wishlist';
  static const String removeWishlist = '/remove-from-wishlist';

  //Cart
  static const String addCartList = '/add-to-cart';
  static const String getCartList = '/cart';
  static const String removeCartList = '/remove-from-cart';
  static const String updateCartList = '/update-cart';

  //checkOut
  static const String checkOut = '/checkout';

  //PlaceOrder
  static const String placeOrder = '/place-order';

  //Profile
  static const String getProfile = '/profile';
  //Profile
  static const String updateProfile = '/update-profile';
  //logout
  static const String logout = '/logout';
}

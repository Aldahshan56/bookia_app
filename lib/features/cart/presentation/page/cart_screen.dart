import 'dart:developer';

import 'package:bookia_app/core/constants/app_icons.dart';
import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/dialogs.dart';
import 'package:bookia_app/core/functions/navigation.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_style.dart';
import 'package:bookia_app/core/widgets/custom_elevated_button.dart';
import 'package:bookia_app/features/cart/presentation/page/checkout_screen.dart';
import 'package:bookia_app/features/cart/presentation/widgets/cart_item.dart';
import 'package:bookia_app/features/cart/presentation/widgets/empty_cartlist_widget.dart';
import 'package:bookia_app/features/home/data/models/get_arrivals_books_response/product.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_event.dart';
import 'package:bookia_app/features/wishlist/presentation/widgets/empty_wishlist_widget.dart';
import 'package:bookia_app/features/wishlist/presentation/widgets/wishlist_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../home/presentation/bloc/home_bloc.dart';
import '../../../home/presentation/bloc/home_state.dart';
import '../../data/models/response/get_cart_response/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is GetCartLoadingState ||
            state is RemoveFromCartLoadingState ||
            state is UpdateFromCartLoadingState ||
            state is CheckOutLoadingState) {
          showLoadingDialog(context);
          log("==================00000-------------");
        } else if (state is GetCartLoadedState) {
          Navigator.pop(context);
        } else if (state is UpdateFromCartLoadedState) {
          Navigator.pop(context);
        } else if (state is RemoveFromCartLoadedState) {
          log("==================00000---------1----");
          Navigator.pop(context);
          context.read<HomeBloc>().add(GetCartEvent());
          log("==================00000-----------2--");
        } else if (state is CheckOutLoadedState) {
          String cartTotal =
              context.read<HomeBloc>().cartResponse?.data?.total.toString() ??
                  '';
          Navigator.pop(context);
          pushTo(
              context,
              CheckoutScreen(
                total: cartTotal,
              ));
        }
      },
      builder: (context, state) {
        var cart = context.read<HomeBloc>().cartResponse;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("My Cart"),
          ),
          body: cart?.data?.cartItems?.isEmpty == true
              ? const EmptyCartWidget()
              : cartBuilder(cart?.data?.cartItems ?? []),
          bottomNavigationBar: (cart?.data?.cartItems?.isNotEmpty == true)
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(22, 10, 22, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total :',
                            style: getFont18TextStyle(context),
                          ),
                          const Spacer(),
                          Text(
                            "${cart?.data?.total}\$",
                            style: getFont20TextStyle(context),
                          )
                        ],
                      ),
                      const Gap(15),
                      CustomElevatedButton(
                          text: "CheckOut",
                          onPressed: () {
                            context.read<HomeBloc>().add(CheckOutEvent());
                          })
                    ],
                  ),
                )
              : const SizedBox(),
        );
      },
    );
  }

  Padding cartBuilder(List<CartItem> cartList) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return CartItemWidget(
            onAddQuantity: () {
              if ((cartList[index].itemQuantity ?? 0) <
                  (cartList[index].itemProductStock ?? 0)) {
                context.read<HomeBloc>().add(UpdateCartEvent(
                    cartItemId: cartList[index].itemId ?? 0,
                    quantity: (cartList[index].itemQuantity ?? 0) + 1));
              } else {
                showAppDialog(
                    context, 'Item is out of stock', DialogType.success);
              }
            },
            onMinusQuantity: () {
              if ((cartList[index].itemQuantity ?? 0) > 1) {
                context.read<HomeBloc>().add(UpdateCartEvent(
                    cartItemId: cartList[index].itemId ?? 0,
                    quantity: (cartList[index].itemQuantity ?? 0) - 1));
              }
            },
            product: cartList[index],
            onRemove: () {
              context.read<HomeBloc>().add(RemoveCartEvent(
                    cartItemId: cartList[index].itemId ?? 0,
                  ));
            },
            onAddToCart: () {},
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 40,
        ),
        itemCount: cartList.length,
      ),
    );
  }
}

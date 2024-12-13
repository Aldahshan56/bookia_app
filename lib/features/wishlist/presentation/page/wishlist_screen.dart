import 'dart:developer';

import 'package:bookia_app/core/constants/app_icons.dart';
import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/dialogs.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_style.dart';
import 'package:bookia_app/core/widgets/custom_elevated_button.dart';
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

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetWishlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is GetWishlistLoadingState ||
            state is RemoveFromWishlistLoadingState ||
            state is AddCartLoadingState) {
          showLoadingDialog(context);
        } else if (state is GetWishlistLoadedState) {
          Navigator.pop(context);
        } else if (state is RemoveFromWishlistLoadedState) {
          Navigator.pop(context);
          context.read<HomeBloc>().add(GetWishlistEvent());
        } else if (state is AddCartLoadedState) {
          Navigator.pop(context);
          showAppDialog(context, "Added to Cart", DialogType.success);
        }
      },
      builder: (context, state) {
        var wishlist = context.read<HomeBloc>().wishlist;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("WishList"),
          ),
          body: wishlist.isEmpty
              ? const EmptyWishlistWidget()
              : wishlistBuilder(wishlist),
        );
      },
    );
  }

  Padding wishlistBuilder(List<Product> wishlist) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return WishlistItem(
            product: wishlist[index],
            onRemove: () {
              context
                  .read<HomeBloc>()
                  .add(RemoveWishlistEvent(productId: wishlist[index].id ?? 0));
            },
            onAddToCart: () {
              context
                  .read<HomeBloc>()
                  .add(AddCartEvent(productId: wishlist[index].id ?? 0));
              log("==============================");
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 40,
        ),
        itemCount: wishlist.length,
      ),
    );
  }
}

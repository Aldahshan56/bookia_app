import 'dart:developer';

import 'package:bookia_app/core/constants/app_icons.dart';
import 'package:bookia_app/core/functions/dialogs.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_style.dart';
import 'package:bookia_app/core/widgets/custom_elevated_button.dart';
import 'package:bookia_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookia_app/features/home/data/models/get_arrivals_books_response/product.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../bloc/home_state.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is AddWishlistLoadingState || state is AddCartLoadingState) {
          showLoadingDialog(context);
        } else if (state is AddWishlistLoadedState) {
          Navigator.pop(context);
          showAppDialog(context, "Added to wishlist", DialogType.success);
        } else if (state is AddCartLoadedState) {
          Navigator.pop(context);
          showAppDialog(context, "Added to Cart", DialogType.success);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          actions: [
            IconButton(
                onPressed: () {
                  context
                      .read<HomeBloc>()
                      .add(AddWishlistEvent(productId: widget.product.id ?? 0));
                },
                icon: SvgPicture.asset(
                    AppIcons.bookMarkSvg,
                  colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(10),
                Hero(
                  tag: widget.product.id.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.network(
                      widget.product.image ?? "",
                      height: 250,
                    ),
                  ),
                ),
                const Gap(12),
                Text(
                  widget.product.name ?? "",
                  style: getFont30TextStyle(context),
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                Text(
                  widget.product.category ?? "",
                  style: getFont16TextStyle(context,
                      color: AppColors.primaryColor),
                ),
                const Divider(
                  height: 40,
                ),
                const Gap(16),
                Text(
                  widget.product.description ?? "",
                  style: getFont14TextStyle(context,color: Theme.of(context).colorScheme.onSurface),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 5, 22, 5),
            child: Row(
              children: [
                Text(
                  "${widget.product.priceAfterDiscount.toString()} EGB",
                  style: getFont20TextStyle(context),
                ),
                const Gap(50),
                Expanded(
                    child: CustomElevatedButton(
                        backGroundColor: AppColors.primaryColor,
                        text: "Add To Cart",
                        onPressed: () {
                          context.read<HomeBloc>().add(
                              AddCartEvent(productId: widget.product.id ?? 0));
                          log("==============================");
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

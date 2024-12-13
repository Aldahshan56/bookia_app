import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/features/home/data/models/get_arrivals_books_response/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../data/models/response/get_cart_response/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget(
      {super.key,
      required this.product,
      required this.onRemove,
      required this.onAddToCart,
      required this.onAddQuantity,
      required this.onMinusQuantity});
  final CartItem product;
  final Function() onRemove;
  final Function() onAddToCart;
  final Function() onAddQuantity;
  final Function() onMinusQuantity;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            product.itemProductImage ?? "",
            width: 100,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    product.itemProductName ?? "",
                    style: getFont18TextStyle(context,),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                  )),
                  const Gap(5),
                  GestureDetector(
                    onTap: onRemove,
                    child: SvgPicture.asset(AppIcons.deleteSvg,colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
                  )
                ],
              ),
              const Gap(10),
              Text(
                "${product.itemProductPriceAfterDiscount ?? product.itemProductPrice} EGP",
                style: getFont16TextStyle(context),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onMinusQuantity,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.borderColor),
                      child: const Icon(Icons.remove),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Text(
                      product.itemQuantity.toString(),
                      style: getFont18TextStyle(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: onAddQuantity,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.borderColor),
                      child: const Icon(Icons.add),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

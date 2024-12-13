import 'package:bookia_app/features/home/data/models/get_arrivals_books_response/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class WishlistItem extends StatelessWidget {
  const WishlistItem(
      {super.key,
      required this.product,
      required this.onRemove,
      required this.onAddToCart});
  final Product product;
  final Function() onRemove;
  final Function() onAddToCart;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            product.image ?? "",
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
                    product.name ?? "",
                    style: getFont18TextStyle(context),
                  )),
                  const Gap(5),
                  GestureDetector(
                    onTap: onRemove,
                    child: SvgPicture.asset(AppIcons.deleteSvg,
                      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),),
                  )
                ],
              ),
              const Gap(10),
              Text(
                "${product.priceAfterDiscount ?? product.price} EGP",
                style: getFont16TextStyle(context),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomElevatedButton(
                      height: 40,
                      width: 180,
                      text: "Add To Cart",
                      onPressed: onAddToCart),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

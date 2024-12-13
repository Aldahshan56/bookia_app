import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';

class EmptyWishlistWidget extends StatelessWidget {
  const EmptyWishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.bookMarkSvg,
            color: AppColors.primaryColor,
            width: 100,
          ),
          const Gap(20),
          Text(
            "No books in wishlist",
            style: getFont18TextStyle(context),
          ),
        ],
      ),
    );
  }
}

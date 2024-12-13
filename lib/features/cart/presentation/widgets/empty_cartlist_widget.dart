import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.groupSvg,
            color: AppColors.primaryColor,
            width: 100,
          ),
          const Gap(20),
          Text(
            "No books in Cart",
            style: getFont18TextStyle(context),
          ),
        ],
      ),
    );
  }
}

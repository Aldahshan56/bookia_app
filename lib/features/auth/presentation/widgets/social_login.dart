import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/utils/colors.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(15),
            height: 56,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderColor)),
            child: SvgPicture.asset(AppImages.facebookSvg),
          ),
        ),
        const Gap(10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(15),
            height: 56,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderColor)),
            child: SvgPicture.asset(AppImages.googleSvg),
          ),
        ),
        const Gap(10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(15),
            height: 56,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderColor)),
            child: SvgPicture.asset(AppImages.appleSvg),
          ),
        ),
      ],
    );
  }
}

import 'package:bookia_app/core/functions/navigation.dart';
import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/features/auth/presentation/page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class PasswordChangedScreen extends StatefulWidget {
  const PasswordChangedScreen({super.key});

  @override
  State<PasswordChangedScreen> createState() => _PasswordChangedScreenState();
}

class _PasswordChangedScreenState extends State<PasswordChangedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImages.successMarkSvg,
                width: 150,
              ),
              const Gap(20),
              Text(
                "Password Changed!",
                style: getFont30TextStyle(context),
              ),
              const Gap(10),
              Text(
                "Your password has been changed successfully.",
                style: getFont16TextStyle(context, color: AppColors.greyColor),
                textAlign: TextAlign.center,
              ),
              const Gap(30),
              CustomElevatedButton(
                  text: "Back to Login",
                  onPressed: () {
                    pushWithReplacement(context, const LoginScreen());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

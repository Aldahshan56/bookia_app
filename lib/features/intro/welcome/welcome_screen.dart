import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigation.dart';
import 'package:bookia_app/core/widgets/custom_elevated_button.dart';
import 'package:bookia_app/features/auth/presentation/page/login_screen.dart';
import 'package:bookia_app/features/auth/presentation/page/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/text_style.dart';
import '../../../core/widgets/custom_elevated_button_outline.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.welcome,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 2,
                ),
                SvgPicture.asset(
                  AppImages.appLogoSvg,
                  width: 250,
                ),
                const Gap(10),
                Text("Order Your Book Now!",
                    style: getFont18TextStyle(context)),
                const Spacer(
                  flex: 3,
                ),
                CustomElevatedButton(
                    text: "Login",
                    onPressed: () {
                      pushTo(context, const LoginScreen());
                    }),
                const Gap(15),
                CustomElevatedButtonOutline(
                    text: "Register",
                    onPressed: () {
                      pushTo(context, const RegisterScreen());
                    }),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

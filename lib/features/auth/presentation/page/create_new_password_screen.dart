import 'package:bookia_app/features/auth/presentation/page/password_changed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.darkColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Create new password",
                    style: getFont30TextStyle(context),
                  ),
                ],
              ),
              const Gap(10),
              Text(
                "Your new password must be unique from those previously used.",
                style: getFont16TextStyle(context, color: AppColors.greyColor),
              ),
              const Gap(32),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "New Password",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: SvgPicture.asset(
                        AppIcons.eyeSvg,
                      ),
                    ),
                    suffixIconConstraints:
                        const BoxConstraints(maxHeight: 17, maxWidth: 80)),
              ),
              const Gap(10),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Confirm Password",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: SvgPicture.asset(
                        AppIcons.eyeSvg,
                      ),
                    ),
                    suffixIconConstraints:
                        const BoxConstraints(maxHeight: 17, maxWidth: 80)),
              ),
              const Gap(60),
              CustomElevatedButton(
                  text: "Reset Password",
                  onPressed: () {
                    pushWithReplacement(context, const PasswordChangedScreen());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

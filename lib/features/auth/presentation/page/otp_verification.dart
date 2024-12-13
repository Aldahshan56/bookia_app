import 'package:bookia_app/features/auth/presentation/page/create_new_password_screen.dart';
import 'package:bookia_app/features/auth/presentation/widgets/pinput.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/functions/navigation.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<OtpVerificationScreen> {
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
                    "OTP Verification",
                    style: getFont30TextStyle(context),
                  ),
                ],
              ),
              const Gap(10),
              Text(
                "Enter the verification code we just sent on your email address.",
                style: getFont16TextStyle(context, color: AppColors.greyColor),
              ),
              const Gap(30),
              const CustomPinput(),
              const Gap(50),
              CustomElevatedButton(
                  text: "Verify",
                  onPressed: () {
                    pushWithReplacement(
                        context, const CreateNewPasswordScreen());
                  }),
              const Gap(100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn’t received code?",
                    style: getFont16TextStyle(context,
                        color: AppColors.darkGreyColor),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Resend",
                        style: getFont16TextStyle(context,
                            color: AppColors.primaryColor),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:bookia_app/features/auth/presentation/page/login_screen.dart';
import 'package:bookia_app/features/auth/presentation/page/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/functions/navigation.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                    "Forgot Password?",
                    style: getFont30TextStyle(context),
                  ),
                ],
              ),
              const Gap(10),
              Text(
                "Don't worry! It occurs. Please enter the email address linked with your account.",
                style: getFont16TextStyle(context, color: AppColors.greyColor),
              ),
              const Gap(32),
              TextFormField(
                decoration: const InputDecoration(hintText: "Enter your email"),
              ),
              const Gap(60),
              CustomElevatedButton(
                  text: "Send Code",
                  onPressed: () {
                    pushTo(context, const OtpVerificationScreen());
                  }),
              const Gap(100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Remember Password?",
                    style: getFont16TextStyle(context,
                        color: AppColors.darkGreyColor),
                  ),
                  TextButton(
                      onPressed: () {
                        pushWithReplacement(context, const LoginScreen());
                      },
                      child: Text(
                        "Login",
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

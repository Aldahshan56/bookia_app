import 'package:bookia_app/core/utils/colors.dart';
import 'package:bookia_app/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomPinput extends StatefulWidget {
  const CustomPinput({super.key});

  @override
  State<CustomPinput> createState() => _CustomPinputState();
}

class _CustomPinputState extends State<CustomPinput> {
  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 4,
      onCompleted: (pin) => print("PIN Entered: $pin"),
      onChanged: (value) => print("Current PIN: $value"),
      defaultPinTheme: PinTheme(
        width: 70,
        height: 60,
        textStyle: getFont20TextStyle(context,color: AppColors.darkColor),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.greyColor),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 70,
        height: 60,
        textStyle: getFont20TextStyle(context,color: AppColors.darkColor),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primaryColor),
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 70,
        height: 60,
        textStyle: getFont20TextStyle(context,color: AppColors.darkColor),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}

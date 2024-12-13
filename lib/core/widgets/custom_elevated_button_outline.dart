import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/text_style.dart';

class CustomElevatedButtonOutline extends StatelessWidget {
  const CustomElevatedButtonOutline(
      {super.key,
      this.width = double.infinity,
      this.height = 56,
      this.textColor,
      this.backGroundColor,
      required this.text,
      required this.onPressed});
  final double width;
  final double height;
  final Color? textColor;
  final Color? backGroundColor;
  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              side: const BorderSide(color: AppColors.darkColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: backGroundColor ?? AppColors.whiteColor),
          onPressed: onPressed,
          child: Text(
            text,
            style: getFont16TextStyle(context, color: AppColors.darkColor),
          )),
    );
  }
}

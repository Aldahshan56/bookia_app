import 'package:bookia_app/core/utils/text_style.dart';
import 'package:flutter/material.dart';

import '../constants/app_fonts.dart';
import 'colors.dart';
class AppTheme{
  static final lightMode=ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          onPrimary: AppColors.primaryColor,
          onSurface: AppColors.darkColor,
          onSecondary: AppColors.whiteColor,
          outline: Colors.black,
          onPrimaryFixed: AppColors.whiteColor,
          onTertiary: AppColors.whiteColor
      ),


      fontFamily: AppFonts.dmSerif,
      scaffoldBackgroundColor: AppColors.whiteColor,
      appBarTheme:
      const AppBarTheme(backgroundColor: AppColors.whiteColor),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.accentColor,
          hintStyle:
          getHintTextStyle(color: AppColors.greyColor),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(color: AppColors.borderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(color: AppColors.primaryColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(color: AppColors.redColor)))
  );
  static final darkMode=ThemeData(
      colorScheme: ColorScheme.fromSeed(
          onSecondaryFixed: AppColors.primaryColor,
          onPrimary: AppColors.whiteColor,
          seedColor: AppColors.whiteColor,
          onSurface: AppColors.whiteColor,
          onSecondary: AppColors.darkColor,
          outline: Colors.black,
        onPrimaryFixed: AppColors.primaryColor,
        onTertiary: AppColors.secondaryColor
      ),

      fontFamily: AppFonts.dmSerif,
      scaffoldBackgroundColor: AppColors.darkColor,
      appBarTheme:
      const AppBarTheme(backgroundColor: AppColors.primaryColor),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.accentColor,
          hintStyle:
          getHintTextStyle(color: AppColors.greyColor),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(color: AppColors.borderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(color: AppColors.primaryColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(color: AppColors.redColor)))
  );

}
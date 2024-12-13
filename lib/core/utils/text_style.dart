import 'package:flutter/material.dart';

import '../constants/app_fonts.dart';
import 'colors.dart';

TextStyle getFont30TextStyle(BuildContext context,
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    //fontFamily:AppFonts.dmSerif,
    color: color ?? Theme.of(context).colorScheme.onSurface,
    fontSize: fontSize ?? 30,
    fontWeight: fontWeight ?? FontWeight.normal,
  );
}

TextStyle getFont14TextStyle(BuildContext context,
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    //fontFamily:AppFonts.dmSerif,
    color: color ?? Theme.of(context).colorScheme.outline,
    fontSize: fontSize ?? 14,
    fontWeight: fontWeight ?? FontWeight.normal,
  );
}

TextStyle getFont24TextStyle(BuildContext context,
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    //fontFamily:AppFonts.dmSerif,
    color: color ?? Theme.of(context).colorScheme.onSurface,
    fontSize: fontSize ?? 24,
    fontWeight: fontWeight ?? FontWeight.bold,
  );
}

TextStyle getFont20TextStyle(BuildContext context,
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    //fontFamily:AppFonts.dmSerif,
    color: color ?? Theme.of(context).colorScheme.onSurface,
    fontSize: fontSize ?? 20,
    fontWeight: fontWeight ?? FontWeight.normal,
  );
}

TextStyle getFont18TextStyle(BuildContext context,
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    //fontFamily:AppFonts.dmSerif,
    color: color ?? Theme.of(context).colorScheme.onSurface,
    fontSize: fontSize ?? 18,
    fontWeight: fontWeight ?? FontWeight.normal,
  );
}

TextStyle getFont16TextStyle(BuildContext context,
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    //fontFamily:AppFonts.dmSerif,
    color: color ?? Theme.of(context).colorScheme.onSurface,
    fontSize: fontSize ?? 16,
    fontWeight: fontWeight ?? FontWeight.normal,
  );
}
TextStyle getHintTextStyle(
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    //fontFamily:AppFonts.dmSerif,
    color: color ,
    fontSize: fontSize ?? 16,
    fontWeight: fontWeight ?? FontWeight.normal,
  );
}


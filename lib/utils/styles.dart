import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wedme1/constants/colors.dart';

class Styles {
  static Color primaryColor = kPrimaryColor;

  static Color textColor = kPrimaryBlack;
  static Color whiteColor = kBackgroundColor;
  static Color redColor = kPrimaryColor;

  static Color grayColor = Colors.grey.shade500;

  static String fontFamily = "Poppins";

  static TextStyle textStyle =
      TextStyle(fontSize: 14, color: textColor, fontWeight: FontWeight.w500);

  static TextStyle headLineStylel =
      TextStyle(fontSize: 30, color: textColor, fontWeight: FontWeight.w400);

  static TextStyle headLineStyle2 =
      TextStyle(fontSize: 26, color: textColor, fontWeight: FontWeight.bold);

  static TextStyle headLineStyle3 =
      TextStyle(fontSize: 14, color: textColor, fontWeight: FontWeight.w500);

  static TextStyle headLineStyle4 = TextStyle(
      fontSize: 12,
      color: whiteColor,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily);

  static TextStyle buttonTextStyle = TextStyle(
      fontSize: 14,
      color: whiteColor,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily);

  static TextStyle headLineStyle5 = TextStyle(
      fontSize: 26,
      color: whiteColor,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily);

  static TextStyle headLineStyle6 = TextStyle(
      fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w500);
}

final stBlack40013 = GoogleFonts.poppins(
    textStyle: const TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.black,
  fontSize: 13,
));

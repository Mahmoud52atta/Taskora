import 'package:flutter/material.dart';

abstract class FontStyles {
  static TextStyle fontStyleBold24(context) {
    return TextStyle(
        fontSize: getResponsiveFontSize(context, fontSize: 24),
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontFamily: 'DM Sans');
  }

  static TextStyle fontStyleBold16(context) {
    return TextStyle(
        fontSize: getResponsiveFontSize(context, fontSize: 16),
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontFamily: 'DM Sans');
  }

  static TextStyle fontStyleRegular14(context) {
    return TextStyle(
        fontSize: getResponsiveFontSize(context, fontSize: 14),
        fontWeight: FontWeight.w400,
        color: const Color(0xff7F7F7F),
        fontFamily: 'DM Sans');
  }

  static TextStyle fontStyleMedium12(context) {
    return TextStyle(
        fontSize: getResponsiveFontSize(context, fontSize: 12),
        fontWeight: FontWeight.w500,
        color: const Color(0xff2F2F2F),
        fontFamily: 'DM Sans');
  }
}

double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;
  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width < 600) {
    return width / 400;
  } else if (width < 900) {
    return width / 700;
  } else {
    return width / 1000;
  }
}

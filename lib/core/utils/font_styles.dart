import 'dart:ui';

import 'package:flutter/material.dart';

abstract class FontStyles {
  static TextStyle fontStyleBold24 = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w900,
      color: Colors.black,
      fontFamily: 'DM Sans');
  static TextStyle fontStyleRegular14 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xff7F7F7F),
      fontFamily: 'DM Sans');
  static TextStyle fontStyleMedium12 = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color(0xff2F2F2F),
      fontFamily: 'DM Sans');
}

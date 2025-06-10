import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class ActiveSelectedStatus extends StatelessWidget {
  const ActiveSelectedStatus({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7.4),
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(18)),
      child: Text(
        text,
        style:
            FontStyles.fontStyleBold16(context).copyWith(color: Colors.white),
      ),
    );
  }
}

class InActiveSelectedStatus extends StatelessWidget {
  const InActiveSelectedStatus({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7.4),
      decoration: BoxDecoration(
          color: kSecondColor, borderRadius: BorderRadius.circular(18)),
      child: Text(
        text,
        style: FontStyles.fontStyleRegular14(context).copyWith(
            color: const Color(
              0xff7C7C80,
            ),
            fontSize: 16),
      ),
    );
  }
}

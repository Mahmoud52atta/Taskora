import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class SectionTextField extends StatelessWidget {
  const SectionTextField({
    super.key,
    required this.hintText,
  });
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
            hintStyle: FontStyles.fontStyleRegular14,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            )));
  }
}

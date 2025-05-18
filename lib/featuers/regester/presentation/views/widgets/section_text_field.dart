import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class SectionTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  const SectionTextField({
    super.key,
    required this.hintText,
    this.validator,
    this.onChanged,
  });
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
            hintStyle: FontStyles.fontStyleRegular14(context),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            )));
  }
}

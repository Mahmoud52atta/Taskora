import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required this.obscureText,
    this.onPressed,
    required this.icon,
    this.validator,
    this.onChanged,
  });
  final bool obscureText;
  final void Function()? onPressed;
  final Widget icon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  // bool isVisiable = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: icon,
          // isVisiable
          //     ? const Icon(Icons.visibility_off)
          //     : const Icon(Icons.visibility),
        ),
        //
        // Image.asset(
        //   Assets.imagesEyeLock,
        //   scale: 3.5,
        // ),
        labelText: 'Password...',
        labelStyle: FontStyles.fontStyleRegular14(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

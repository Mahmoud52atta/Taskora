import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isVisiable = true;

  void toggleVisiable() {
    setState(() {
      isVisiable = !isVisiable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isVisiable,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: toggleVisiable,
          icon: isVisiable
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
        //
        // Image.asset(
        //   Assets.imagesEyeLock,
        //   scale: 3.5,
        // ),
        labelText: 'Password...',
        labelStyle: FontStyles.fontStyleRegular14,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

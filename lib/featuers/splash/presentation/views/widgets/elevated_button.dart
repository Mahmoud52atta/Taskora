import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';

class ElevatedBottonSection extends StatelessWidget {
  const ElevatedBottonSection({
    super.key,
    required this.onPressed,
    this.child,
  });
  final Function() onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          // decoration: BoxDecoration(
          //     color: kPrimaryColor, borderRadius: BorderRadius.circular(12)),
          height: 55,
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  backgroundColor: kPrimaryColor),
              onPressed: onPressed,
              child: child),
        ));
  }
}

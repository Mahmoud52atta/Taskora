import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class AddTaskAppBar extends StatelessWidget {
  const AddTaskAppBar({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset(Assets.imagesArrowLeft)),
        Text(
          text,
          style: FontStyles.fontStyleBold16(context),
        ),
        const Spacer(),
      ],
    );
  }
}

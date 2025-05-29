import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class TaskDetailsAppBar extends StatelessWidget {
  const TaskDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset(Assets.imagesArrowLeft)),
        Text(
          'Task Details',
          style: FontStyles.fontStyleBold16(context),
        ),
        const Spacer(),
        Image.asset(
          Assets.imagesFrame5,
          scale: 4.5,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/presentation/views/home_view.dart';

class AddTaskAppBar extends StatelessWidget {
  const AddTaskAppBar({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          },
          child: Image.asset(Assets.imagesArrowLeft),
        ),
        Text(
          text,
          style: FontStyles.fontStyleBold16(context),
        ),
        const SizedBox(width: 24), // Add fixed width to balance the layout
      ],
    );
  }
}

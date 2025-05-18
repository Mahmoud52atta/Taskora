import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class HomeViewAppBar extends StatelessWidget {
  const HomeViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Logo',
          style: FontStyles.fontStyleBold24(context),
        ),
        Spacer(
          flex: 10,
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 24 / 24,
            child: Image.asset(
              Assets.imagesProfile,
              // scale: 3.5,
            ),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        // SizedBox(
        //   width: 20,
        // ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 24 / 24,
            child: Image.asset(
              Assets.imagesLogOut,
              // scale: 3.5,
            ),
          ),
        )
      ],
    );
  }
}

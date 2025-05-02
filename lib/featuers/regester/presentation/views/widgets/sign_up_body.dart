import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/featuers/regester/presentation/views/widgets/sign_up_section.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Image.asset(Assets.imagesGroup8),
            const SizedBox(
              height: 24,
            ),
            const SignUpSection()
          ],
        ),
      )
    ]);
  }
}

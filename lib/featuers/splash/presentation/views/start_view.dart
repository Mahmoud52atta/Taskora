import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/regester/presentation/views/sign_in_view.dart';
import 'package:to_do_app/featuers/splash/presentation/views/widgets/elevated_button.dart';

class StartView extends StatelessWidget {
  static const String routeName = 'start';

  const StartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Image.asset(Assets.imagesGroup8),
            const SizedBox(
              height: 24,
            ),
            Column(
              children: [
                Text(
                  'Task Management &\n        To-Do List',
                  style: FontStyles.fontStyleBold24(context),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'This productive tool is designed to help \n          you better manage your task \n            project-wise conveniently!',
                  style: FontStyles.fontStyleRegular14(context)
                      .copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedBottonSection(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Let's Start",
                        style: FontStyles.fontStyleBold24(context)
                            .copyWith(fontSize: 19, color: Colors.white),
                      ),
                      Image.asset(
                        Assets.imagesArrowright,
                        scale: 3.5,
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, SignInView.routeName);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

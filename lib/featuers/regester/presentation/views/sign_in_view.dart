import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/regester/presentation/views/sign_up_view.dart';
import 'package:to_do_app/featuers/regester/presentation/views/widgets/password_text_field.dart';
import 'package:to_do_app/featuers/regester/presentation/views/widgets/phone_text_field.dart';
import 'package:to_do_app/featuers/splash/presentation/views/widgets/elevated_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static const String routeName = 'SignIn';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: FontStyles.fontStyleBold24,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const PhoneTextField(),
                    const SizedBox(
                      height: 24,
                    ),
                    const PasswordTextField(),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
              ElevatedBottonSection(
                  onPressed: () {},
                  child: Text(
                    'Sign in',
                    style: FontStyles.fontStyleBold24
                        .copyWith(fontSize: 16, color: Colors.white),
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn’t have any account?',
                    style: FontStyles.fontStyleRegular14,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, SignUpView.routeName);
                    },
                    child: Text(
                      ' Sign Up here',
                      style: FontStyles.fontStyleRegular14
                          .copyWith(color: kPrimaryColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}

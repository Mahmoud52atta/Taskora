import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/regester/presentation/views/sign_in_view.dart';
import 'package:to_do_app/featuers/regester/presentation/views/widgets/password_text_field.dart';
import 'package:to_do_app/featuers/regester/presentation/views/widgets/phone_text_field.dart';
import 'package:to_do_app/featuers/regester/presentation/views/widgets/section_drop_down.dart';
import 'package:to_do_app/featuers/regester/presentation/views/widgets/section_text_field.dart';
import 'package:to_do_app/featuers/splash/presentation/views/widgets/elevated_button.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static const routeName = 'signUp';
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
                      'Sign Up',
                      style: FontStyles.fontStyleBold24,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const SectionTextField(
                      hintText: ' Name...',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const PhoneTextField(),
                    const SizedBox(
                      height: 18,
                    ),
                    const SectionTextField(
                      hintText: 'Years of experience...',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const SectionDropDown(),
                    const SizedBox(
                      height: 24,
                    ),
                    const SectionTextField(hintText: 'Adress...'),
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
                    'Sign Up',
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
                    'Already have any account?',
                    style: FontStyles.fontStyleRegular14,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, SignInView.routeName);
                    },
                    child: Text(
                      '  Sign in',
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

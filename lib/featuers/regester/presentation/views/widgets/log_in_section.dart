import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/presentation/views/home_view.dart';
import 'package:to_do_app/featuers/regester/presentation/mange/cubit/log_in_cubit/log_in_cubit.dart';
import 'package:to_do_app/featuers/regester/presentation/views/sign_up_view.dart';
import 'package:to_do_app/featuers/regester/presentation/views/widgets/password_text_field.dart';
import 'package:to_do_app/featuers/regester/presentation/views/widgets/phone_text_field.dart';
import 'package:to_do_app/featuers/splash/presentation/views/widgets/elevated_button.dart';

class LoginSection extends StatefulWidget {
  const LoginSection({
    super.key,
  });

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  bool isVisiable = true;

  void toggleVisiable() {
    setState(() {
      isVisiable = !isVisiable;
    });
  }

  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? phone;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocConsumer<LogInCubit, LogInState>(
        listener: (context, state) {
          if (state is LogInSuccess) {
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          } else if (state is LogInFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: FontStyles.fontStyleBold24(context),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    PhoneTextField(
                      validator: (value) {
                        if (value?.number.isEmpty ?? true) {
                          return 'enter your number';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        phone = value.completeNumber;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    PasswordTextField(
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'enter your password';
                        } else {
                          return null;
                        }
                      },
                      onPressed: toggleVisiable,
                      obscureText: isVisiable,
                      icon: isVisiable
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
              state is LogInLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedBottonSection(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          context
                              .read<LogInCubit>()
                              .logIn(phone: phone!, password: password!);
                        } else {
                          autovalidateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      },
                      child: Text(
                        'Sign in',
                        style: FontStyles.fontStyleBold24(context)
                            .copyWith(fontSize: 16, color: Colors.white),
                      )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t have any account?',
                    style: FontStyles.fontStyleRegular14(context),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, SignUpView.routeName);
                    },
                    child: Text(
                      ' Sign Up here',
                      style: FontStyles.fontStyleRegular14(context)
                          .copyWith(color: kPrimaryColor),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

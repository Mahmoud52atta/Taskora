import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/presentation/views/home_view.dart';
import 'package:to_do_app/featuers/regester/presentation/mange/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:to_do_app/featuers/regester/presentation/views/sign_in_view.dart';
import 'package:to_do_app/featuers/regester/presentation/views/widgets/password_text_field.dart';
import 'package:to_do_app/featuers/regester/presentation/views/widgets/phone_text_field.dart';
import 'package:to_do_app/featuers/regester/presentation/views/widgets/section_drop_down.dart';
import 'package:to_do_app/featuers/regester/presentation/views/widgets/section_text_field.dart';
import 'package:to_do_app/featuers/splash/presentation/views/widgets/elevated_button.dart';

class SignUpSection extends StatefulWidget {
  const SignUpSection({
    super.key,
  });

  @override
  State<SignUpSection> createState() => _SignUpSectionState();
}

class _SignUpSectionState extends State<SignUpSection> {
  bool isVisiable = true;

  void toggleVisiable() {
    setState(() {
      isVisiable = !isVisiable;
    });
  }

  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? name, phoneNumber, address, password;
  String? selectedExperienceLevel;
  String? yearsOfExperience;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          } else if (state is SignUpFailure) {
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
                      'Sign Up',
                      style: FontStyles.fontStyleBold24(context),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    PhoneTextField(
                      onChanged: (value) {
                        phoneNumber = value.completeNumber;
                      },
                      validator: (value) {
                        if (value?.completeNumber.isEmpty ?? true) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    PasswordTextField(
                      onPressed: toggleVisiable,
                      obscureText: isVisiable,
                      icon: isVisiable
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SectionTextField(
                      onChanged: (value) {
                        name = value;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      hintText: ' Name...',
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    SectionTextField(
                      onChanged: (value) {
                        yearsOfExperience = value;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your years of experience';
                        }
                        return null;
                      },
                      hintText: 'Years of experience...',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SectionTextField(
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          address = value;
                        },
                        hintText: 'Adress...'),
                    const SizedBox(
                      height: 24,
                    ),
                    SectionDropDown(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your experience level';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        selectedExperienceLevel = value;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
              state is SignUpLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedBottonSection(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          context.read<SignUpCubit>().register(
                                phoneNumber: phoneNumber!,
                                password: password!,
                                name: name!,
                                experienceYear: yearsOfExperience!,
                                address: address!,
                                experienceLevel: selectedExperienceLevel!,
                              );
                        }
                      },
                      child: Text(
                        'Sign Up',
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
                    'Already have any account?',
                    style: FontStyles.fontStyleRegular14(context),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, SignInView.routeName);
                    },
                    child: Text(
                      '  Sign in',
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

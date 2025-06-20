import 'package:flutter/material.dart';

import 'package:to_do_app/featuers/regester/presentation/views/widgets/sign_in_view_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static const String routeName = 'SignIn';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignInVewbody(),
    );
  }
}

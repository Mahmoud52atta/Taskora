import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:to_do_app/core/helper_function/get_it.dart';

import 'package:to_do_app/featuers/regester/data/repo/auth_repo_imp.dart';
import 'package:to_do_app/featuers/regester/presentation/mange/cubit/log_in_cubit.dart';

import 'package:to_do_app/featuers/regester/presentation/views/widgets/sign_in_view_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static const String routeName = 'SignIn';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LogInCubit(getIt<AuthRepoImp>()),
        child: const SignInVewbody(),
      ),
    );
  }
}

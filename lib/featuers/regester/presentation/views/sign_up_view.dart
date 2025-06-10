import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/helper_function/get_it.dart';
import 'package:to_do_app/featuers/regester/data/repo/auth_repo_imp.dart';
import 'package:to_do_app/featuers/regester/presentation/mange/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:to_do_app/featuers/regester/presentation/views/widgets/sign_up_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static const routeName = 'signUp';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpCubit(getIt<AuthRepoImp>()),
        child: const SignUpBody(),
      ),
    );
  }
}

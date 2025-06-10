import 'package:flutter/material.dart';
import 'package:to_do_app/featuers/home/presentation/views/add_new_task_view.dart';
import 'package:to_do_app/featuers/home/presentation/views/home_view.dart';
import 'package:to_do_app/featuers/home/presentation/views/task_details_view.dart';
import 'package:to_do_app/featuers/home/presentation/views/profile_view.dart';
import 'package:to_do_app/featuers/regester/presentation/views/sign_in_view.dart';
import 'package:to_do_app/featuers/regester/presentation/views/sign_up_view.dart';
import 'package:to_do_app/featuers/splash/presentation/views/splash_view.dart';
import 'package:to_do_app/featuers/splash/presentation/views/start_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case StartView.routeName:
      return MaterialPageRoute(builder: (context) => const StartView());
    case SignInView.routeName:
      return MaterialPageRoute(builder: (context) => const SignInView());
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case TaskDetailsView.routeName:
      return MaterialPageRoute(builder: (context) => const TaskDetailsView());
    case AddNewTaskView.routeName:
      return MaterialPageRoute(builder: (context) => const AddNewTaskView());
    case ProfileView.routeName:
      return MaterialPageRoute(builder: (context) => const ProfileView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}

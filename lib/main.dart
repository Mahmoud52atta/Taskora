import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/cash/cash_helper.dart';
import 'package:to_do_app/core/helper_function/generate_goRout.dart';
import 'package:to_do_app/core/helper_function/get_it.dart';
import 'package:to_do_app/featuers/home/data/repos_impl/home_repo_impl.dart';
import 'package:to_do_app/featuers/home/presentation/manage/add_task_cubit/cubit/new_task_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/manage/delete_cubit/cubit/delete_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/manage/edit_cubit/cubit/edit_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/manage/home_cubit/home_cubit.dart';
import 'package:to_do_app/featuers/regester/data/repo/auth_repo_imp.dart';
import 'package:to_do_app/featuers/regester/presentation/mange/cubit/log_in_cubit/log_in_cubit.dart';
import 'package:to_do_app/featuers/regester/presentation/mange/cubit/log_out_cubit/cubit/log_out_cubit.dart';
import 'package:to_do_app/featuers/regester/presentation/mange/cubit/profile_cubit/cubit/profile_cubit.dart';
import 'package:to_do_app/featuers/splash/presentation/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  setupServiceLocator(CacheHelper.sharedPreferences);

  runApp(DevicePreview(
    builder: (context) => const RebuildToDoApp(),
  ));
}

class RebuildToDoApp extends StatelessWidget {
  const RebuildToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LogInCubit(getIt<AuthRepoImp>())),
        BlocProvider(
            create: (context) =>
                HomeCubit(getIt<HomeRepoImpl>())..getHomeData()),
        BlocProvider(create: (context) => LogOutCubit(getIt<AuthRepoImp>())),
        BlocProvider(create: (context) => ProfileCubit(getIt<AuthRepoImp>())),
        BlocProvider(create: (context) => NewTaskCubit(getIt<HomeRepoImpl>())),
        BlocProvider(create: (context) => EditCubit(getIt<HomeRepoImpl>())),
        BlocProvider(create: (context) => DeleteCubit(getIt<HomeRepoImpl>())),
      ],
      child: MaterialApp(
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          onGenerateRoute: generateRoute,
          initialRoute: SplashView.routeName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white, // خلفية التطبيق
            primaryColor: Colors.black,
            brightness: Brightness.light, // وضع الإضاءة
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black),
              bodyMedium: TextStyle(color: Colors.black),
              bodySmall: TextStyle(color: Colors.black),
            ),
          )),
    );
  }
}

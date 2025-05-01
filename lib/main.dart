import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/core/helper_function/generate_goRout.dart';
import 'package:to_do_app/featuers/splash/presentation/views/splash_view.dart';

void main() {
  runApp(DevicePreview(
      enabled: true, builder: (context) => const RebuildToDoApp()));
}

class RebuildToDoApp extends StatelessWidget {
  const RebuildToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        ));
  }
}

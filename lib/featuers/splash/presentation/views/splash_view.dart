import 'dart:async';
import 'package:flutter/material.dart';
import 'package:to_do_app/featuers/splash/presentation/views/start_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);
  static const String routeName = 'splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _animate = false;
  @override
  void initState() {
    super.initState();

    // بدء الأنيميشن بعد دخول الصفحة بقليل
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _animate = true;
      });
    });

    // الانتقال للصفحة التالية بعد 3 ثواني
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacementNamed(
        context,
        StartView.routeName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6C3EFF),
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 5),
          opacity: _animate ? 1 : 0,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'DM Sans',
              ),
              children: [
                TextSpan(text: 'Task', style: TextStyle(color: Colors.white)),
                TextSpan(text: 'y', style: TextStyle(color: Colors.yellow)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

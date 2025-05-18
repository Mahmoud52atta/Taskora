import 'package:flutter/material.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/home_view_appBar.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = 'homeView';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 36,
            ),
            HomeViewAppBar(),
            SizedBox(
              height: 36,
            ),
            HomeViewBody()
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/date_time_field.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/periority_field.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/status_field.dart';

class TaskDetailsBody extends StatelessWidget {
  const TaskDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(Assets.imagesImage1),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Grocery Shopping App',
          style: FontStyles.fontStyleBold24(context),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'This application is designed for super shops. By using this application they can enlist all their products in one place and can deliver. Customers will get a one-stop solution for their daily shopping.',
          style: FontStyles.fontStyleRegular14(context),
        ),
        const SizedBox(
          height: 16,
        ),
        const DateTimeField(),
        const SizedBox(
          height: 8,
        ),
        const StatusField(),
        const SizedBox(
          height: 8,
        ),
        const PeriorityField(),
        const SizedBox(height: 10),
        Center(
          child: Image.asset(
            Assets.imagesQRCode,
          ),
        )
      ],
    );
  }
}

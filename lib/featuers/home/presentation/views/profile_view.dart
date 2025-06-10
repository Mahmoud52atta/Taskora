import 'package:flutter/material.dart';
import 'package:to_do_app/core/helper_function/const_space.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/add_task_appbar.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/profile_field.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const routeName = 'profileView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ConstSpace.horizontalPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 36),
            const AddTaskAppBar(text: 'Profile'),
            const SizedBox(height: 30),
            const ProfileField(label: 'NAME', value: 'Islam Sayed'),
            const SizedBox(height: 16),
            ProfileField(
              label: 'PHONE',
              value: '+20 123 456-7890',
              trailing: Image.asset(
                Assets.imagesCopyImage,
                scale: 4.5,
              ),
            ),
            const SizedBox(height: 16),
            const ProfileField(label: 'LEVEL', value: 'Senior'),
            const SizedBox(height: 16),
            const ProfileField(label: 'YEARS OF EXPERIENCE', value: '7 years'),
            const SizedBox(height: 16),
            const ProfileField(label: 'LOCATION', value: 'Fayyum, Egypt'),
          ],
        ),
      ),
    );
  }
}

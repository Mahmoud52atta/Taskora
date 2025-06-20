import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/helper_function/const_space.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/add_task_appbar.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/profile_field.dart';
import 'package:to_do_app/featuers/regester/domain/entities/profile_entity.dart';
import 'package:to_do_app/featuers/regester/presentation/mange/cubit/profile_cubit/cubit/profile_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  static const routeName = 'profileView';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is ProfileSuccess) {
          return _buildProfileContent(context, state.profile);
        } else {
          return const Scaffold(
            body: Center(child: Text('No profile data available')),
          );
        }
      },
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileEntity profile) {
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
            ProfileField(label: 'NAME', value: profile.name),
            const SizedBox(height: 16),
            ProfileField(
              label: 'PHONE',
              value: profile.phone,
              trailing: Image.asset(
                Assets.imagesCopyImage,
                scale: 4.5,
              ),
            ),
            const SizedBox(height: 16),
            ProfileField(label: 'LEVEL', value: profile.level),
            const SizedBox(height: 16),
            ProfileField(
                label: 'YEARS OF EXPERIENCE', value: profile.yearsOfExperience),
            const SizedBox(height: 16),
            ProfileField(label: 'LOCATION', value: profile.location),
          ],
        ),
      ),
    );
  }
}

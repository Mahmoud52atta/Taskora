import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/presentation/views/profile_view.dart';
import 'package:to_do_app/featuers/regester/presentation/mange/cubit/log_out_cubit/cubit/log_out_cubit.dart';
import 'package:to_do_app/featuers/regester/presentation/mange/cubit/profile_cubit/cubit/profile_cubit.dart';
import 'package:to_do_app/featuers/regester/presentation/views/sign_in_view.dart';
import 'package:to_do_app/core/cash/cash_helper.dart';
import 'package:to_do_app/core/api/end_point.dart';

class HomeViewAppBar extends StatelessWidget {
  const HomeViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Logo',
          style: FontStyles.fontStyleBold24(context),
        ),
        const Spacer(
          flex: 10,
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 24 / 24,
            child: GestureDetector(
              onTap: () async {
                Navigator.pushNamed(
                  context,
                  ProfileView.routeName,
                );
                await context.read<ProfileCubit>().getProfile();
                // arguments: context.read<ProfileCubit>());
              },
              child: Image.asset(
                Assets.imagesProfile,
                // scale: 3.5,
              ),
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        // SizedBox(
        //   width: 20,
        // ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          BlocConsumer<LogOutCubit, LogOutState>(
                            listener: (context, state) {
                              if (state is LogOutSuccess) {
                                Navigator.pushReplacementNamed(
                                    context, SignInView.routeName);
                              } else if (state is LogOutFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is LogOutLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return TextButton(
                                onPressed: () {
                                  final refreshToken =
                                      CacheHelper.getDataString(
                                          key: ApiKey.refreshToken);
                                  if (refreshToken.isNotEmpty) {
                                    context
                                        .read<LogOutCubit>()
                                        .logOut(refreshToken: refreshToken);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Unable to logout: No refresh token found')),
                                    );
                                  }
                                },
                                child: const Text('Logout'),
                              );
                            },
                          ),
                        ],
                      ));
            },
            child: AspectRatio(
              aspectRatio: 24 / 24,
              child: Image.asset(
                Assets.imagesLogOut,
                // scale: 3.5,
              ),
            ),
          ),
        )
      ],
    );
  }
}

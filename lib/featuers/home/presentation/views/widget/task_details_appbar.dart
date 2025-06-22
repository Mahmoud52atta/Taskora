import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';
import 'package:to_do_app/featuers/home/presentation/manage/delete_cubit/cubit/delete_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/manage/home_cubit/home_cubit.dart';

class TaskDetailsAppBar extends StatelessWidget {
  const TaskDetailsAppBar({
    super.key,
    required this.details,
    required this.isEditing,
    required this.onEditToggle,
  });
  final HomeEntity details;
  final bool isEditing;
  final VoidCallback onEditToggle;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteCubit, DeleteState>(
      listener: (context, state) {
        if (state is DeleteSuccess) {
          // Clear any existing snackbars before showing new one
          ScaffoldMessenger.of(context).clearSnackBars();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Task deleted successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          context.read<HomeCubit>().getHomeData();
          Navigator.pop(context); // Go back to home
        } else if (state is DeleteFailure) {
          // Clear any existing snackbars before showing new one
          ScaffoldMessenger.of(context).clearSnackBars();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: Row(
        children: [
          GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset(Assets.imagesArrowLeft)),
          Text(
            'Task Details',
            style: FontStyles.fontStyleBold16(context),
          ),
          const Spacer(),
          // Edit button
          GestureDetector(
            onTap: onEditToggle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isEditing ? Colors.orange : kPrimaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isEditing ? 'Cancel' : 'Edit',
                style: FontStyles.fontStyleMedium12(context).copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Task'),
                    content: const Text(
                        'Are you sure you want to delete this task?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          context
                              .read<DeleteCubit>()
                              .deleteTask(id: details.id);
                          Navigator.pop(context); // Close dialog
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete',
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
            icon: Image.asset(
              Assets.imagesFrame5,
              scale: 4.5,
            ),
          ),
        ],
      ),
    );
  }
}

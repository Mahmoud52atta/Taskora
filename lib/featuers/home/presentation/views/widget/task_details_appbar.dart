import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';

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
    return Row(
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
                  content:
                      const Text('Are you sure you want to delete this task?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement delete functionality
                        Navigator.pop(context);
                        Navigator.pop(context); // Go back to home
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Task deleted successfully!')),
                        );
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
    );
  }
}

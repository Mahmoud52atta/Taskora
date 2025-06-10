import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class TaskDescriptionField extends StatelessWidget {
  const TaskDescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task Description',
          style: FontStyles.fontStyleRegular14(context),
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Enter description here...',
            hintStyle: FontStyles.fontStyleRegular14(context),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

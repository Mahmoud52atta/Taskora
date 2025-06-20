import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class TaskTitleField extends StatelessWidget {
  const TaskTitleField({super.key, this.onChanged});
  final Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task title',
          style: FontStyles.fontStyleRegular14(context),
        ),
        const SizedBox(height: 8),
        TextFormField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Enter title here...',
            hintStyle: FontStyles.fontStyleRegular14(context),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

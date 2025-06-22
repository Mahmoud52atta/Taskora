import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class TaskDetailsTextField extends StatelessWidget {
  const TaskDetailsTextField({
    super.key,
    required this.isEditing,
    required this.value,
    required this.label,
    this.onChanged,
    this.maxLines = 1,
    required this.displayStyle,
  });

  final bool isEditing;
  final String value;
  final String label;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final TextStyle displayStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FontStyles.fontStyleRegular14(context),
        ),
        const SizedBox(height: 8),
        if (isEditing)
          TextFormField(
            initialValue: value,
            onChanged: onChanged,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: 'Enter $label here...',
              hintStyle: FontStyles.fontStyleRegular14(context),
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: kSecondColor,
            ),
            style: FontStyles.fontStyleRegular14(context)
                .copyWith(fontWeight: FontWeight.bold),
          )
        else
          Text(
            value,
            style: displayStyle,
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}

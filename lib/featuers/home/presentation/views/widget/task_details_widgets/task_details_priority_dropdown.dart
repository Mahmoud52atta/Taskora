import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class TaskDetailsPriorityDropdown extends StatelessWidget {
  const TaskDetailsPriorityDropdown({
    super.key,
    required this.isEditing,
    required this.selectedValue,
    required this.onChanged,
  });

  final bool isEditing;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final standardPriorities = ['high', 'medium', 'low'];
    final allPriorities = <String>[];
    allPriorities.addAll(standardPriorities);
    if (selectedValue != null && !allPriorities.contains(selectedValue)) {
      allPriorities.add(selectedValue!);
    }

    return DropdownButtonFormField<String>(
      iconSize: 30,
      iconEnabledColor: kPrimaryColor,
      borderRadius: BorderRadius.circular(16),
      style: FontStyles.fontStyleBold16(context).copyWith(color: kPrimaryColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: kSecondColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      value: selectedValue,
      items: allPriorities
          .map((priority) => DropdownMenuItem(
                value: priority,
                child: Text(priority.isNotEmpty
                    ? _capitalizeFirstLetter(priority)
                    : 'Unknown'),
              ))
          .toList(),
      onChanged: isEditing ? onChanged : null,
    );
  }

  String _capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
}

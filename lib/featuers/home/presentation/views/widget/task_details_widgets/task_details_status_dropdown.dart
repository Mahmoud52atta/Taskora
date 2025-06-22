import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class TaskDetailsStatusDropdown extends StatelessWidget {
  const TaskDetailsStatusDropdown({
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
    final standardStatuses = ['waiting', 'inprogress', 'finished'];
    final allStatuses = <String>[];
    allStatuses.addAll(standardStatuses);
    if (selectedValue != null && !allStatuses.contains(selectedValue)) {
      allStatuses.add(selectedValue!);
    }

    return DropdownButtonFormField<String>(
      iconSize: 30,
      iconEnabledColor: kPrimaryColor,
      style: FontStyles.fontStyleBold16(context).copyWith(color: kPrimaryColor),
      borderRadius: BorderRadius.circular(16),
      decoration: InputDecoration(
        filled: true,
        fillColor: kSecondColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      value: selectedValue,
      items: allStatuses
          .map((status) => DropdownMenuItem(
                value: status,
                child: Text(
                    status.isNotEmpty ? _getDisplayText(status) : 'Unknown'),
              ))
          .toList(),
      onChanged: isEditing ? onChanged : null,
    );
  }

  String _getDisplayText(String status) {
    switch (status.toLowerCase()) {
      case 'inprogress':
        return 'In Progress';
      case 'waiting':
        return 'Waiting';
      case 'finished':
        return 'Finished';
      default:
        return status.isNotEmpty
            ? status[0].toUpperCase() + status.substring(1)
            : 'Unknown';
    }
  }
}

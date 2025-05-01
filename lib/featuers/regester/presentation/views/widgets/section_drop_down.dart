import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class SectionDropDown extends StatelessWidget {
  const SectionDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        enableFeedback: false,
        dropdownColor: Colors.white,
        decoration: InputDecoration(
            hintText: 'Choose experience Level...',
            hintStyle: FontStyles.fontStyleMedium12.copyWith(fontSize: 14),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        items: [
          'Entry Level',
          'Mid Level',
          'Senior Level',
          'Manager',
        ]
            .map((level) => DropdownMenuItem(value: level, child: Text(level)))
            .toList(),
        onChanged: (value) {});
  }
}

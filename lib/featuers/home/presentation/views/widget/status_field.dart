import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class StatusField extends StatefulWidget {
  const StatusField({super.key});

  @override
  State<StatusField> createState() => _StatusFieldState();
}

class _StatusFieldState extends State<StatusField> {
  String _selectedStatus = 'Inprogress';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      iconSize: 30, iconEnabledColor: kPrimaryColor,
      style: FontStyles.fontStyleBold16(context).copyWith(color: kPrimaryColor),
      borderRadius: BorderRadius.circular(16),
      decoration: InputDecoration(
        filled: true, fillColor: kSecondColor,
        // focusColor: kPrimaryColor,
        // fillColor: kSecondColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      // iconEnabledColor: kPrimaryColor,
      // dropdownColor: kSecondColor,
      // borderRadius: BorderRadius.circular(16),
      value: _selectedStatus,
      items: const [
        DropdownMenuItem(value: 'Inprogress', child: Text('Inprogress')),
        DropdownMenuItem(value: 'Completed', child: Text('Completed')),
        DropdownMenuItem(value: 'Pending', child: Text('Pending')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedStatus = value!;
        });
      },
    );
  }
}

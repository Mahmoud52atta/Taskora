import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class PeriorityField extends StatefulWidget {
  const PeriorityField({super.key});

  @override
  State<PeriorityField> createState() => _PeriorityFieldState();
}

class _PeriorityFieldState extends State<PeriorityField> {
  String _selectedPriority = 'Medium Priority';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      iconSize: 30,
      iconEnabledColor: kPrimaryColor,
      borderRadius: BorderRadius.circular(16),
      style: FontStyles.fontStyleBold16(context).copyWith(color: kPrimaryColor),
      decoration: InputDecoration(
          filled: true,
          fillColor: kSecondColor,
          prefixIcon: Image.asset(
            scale: 4.5,
            Assets.imagesFlage,
            width: 5,
            height: 5,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
      value: _selectedPriority,
      items: const [
        DropdownMenuItem(value: 'High Priority', child: Text('High Priority')),
        DropdownMenuItem(
            value: 'Medium Priority', child: Text('Medium Priority')),
        DropdownMenuItem(value: 'Low Priority', child: Text('Low Priority')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedPriority = value!;
        });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';
import 'package:to_do_app/featuers/home/presentation/manage/home_cubit/home_cubit.dart';

class PeriorityField extends StatefulWidget {
  const PeriorityField({super.key, this.onChanged, this.homeInitial});
  final Function(String?)? onChanged;
  final HomeEntity? homeInitial;

  @override
  State<PeriorityField> createState() => _PeriorityFieldState();
}

class _PeriorityFieldState extends State<PeriorityField> {
  String? _selectedPriority;

  @override
  void initState() {
    super.initState();
    _selectedPriority = widget.homeInitial?.priority;
  }

  @override
  Widget build(BuildContext context) {
    // Create a list of standard priority values
    final standardPriorities = [
      'high',
      'medium',
      'low',
      'High',
      'Medium',
      'Low'
    ];

    // Ensure the current priority is included in the items list
    final allPriorities = <String>[];
    allPriorities.addAll(standardPriorities);
    if (!allPriorities.contains(_selectedPriority)) {
      allPriorities.add(_selectedPriority ?? '');
    }

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
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
      value: _selectedPriority,
      items: allPriorities
          .map((priority) => DropdownMenuItem(
                value: priority,
                child: Text(priority.isNotEmpty ? priority : 'Unknown'),
              ))
          .toList(),
      onChanged: null, // Make it read-only for display
    );
  }
}

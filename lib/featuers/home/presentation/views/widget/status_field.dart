import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';

class StatusField extends StatefulWidget {
  const StatusField({super.key, required this.homeEntity});
  final HomeEntity homeEntity;
  @override
  State<StatusField> createState() => _StatusFieldState();
}

class _StatusFieldState extends State<StatusField> {
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.homeEntity.status;
  }

  @override
  Widget build(BuildContext context) {
    // Create a list of standard status values
    final standardStatuses = [
      'Inprogress',
      'Completed',
      'Pending',
      'waiting',
      'inprogress',
      'completed',
      'pending'
    ];

    // Ensure the current status is included in the items list
    final allStatuses = <String>[];
    allStatuses.addAll(standardStatuses);
    if (!allStatuses.contains(_selectedStatus)) {
      allStatuses.add(_selectedStatus ?? '');
    }

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
      items: allStatuses
          .map((status) => DropdownMenuItem(
                value: status,
                child: Text(status.isNotEmpty ? status : 'Unknown'),
              ))
          .toList(),
      onChanged: null, // Make it read-only for display
    );
  }
}

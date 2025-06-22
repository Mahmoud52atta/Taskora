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
    final defaultPriority =
        widget.homeInitial?.priority?.toLowerCase() ?? 'medium';
    _selectedPriority = defaultPriority;
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return kPrimaryColor;
    }
  }

  IconData _getPriorityIcon(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Icons.priority_high;
      case 'medium':
        return Icons.remove;
      case 'low':
        return Icons.keyboard_arrow_down;
      default:
        return Icons.flag;
    }
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final priorities = ['high', 'medium', 'low'];

    return DropdownButtonFormField<String>(
      iconSize: 30,
      iconEnabledColor: kPrimaryColor,
      borderRadius: BorderRadius.circular(16),
      style: FontStyles.fontStyleBold16(context).copyWith(color: kPrimaryColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: kSecondColor,
        labelText: 'Priority',
        labelStyle: FontStyles.fontStyleRegular14(context).copyWith(
          color: Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
      ),
      value: _selectedPriority,
      items: priorities.map((priority) {
        return DropdownMenuItem<String>(
          value: priority,
          child: Text(
            _capitalizeFirstLetter(priority),
            style: FontStyles.fontStyleRegular14(context).copyWith(
              color: _getPriorityColor(priority),
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedPriority = value;
        });
        widget.onChanged?.call(value);
      },
    );
  }
}

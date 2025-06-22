import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';

class StatusField extends StatefulWidget {
  const StatusField({
    super.key,
    this.onChanged,
    this.homeEntity,
    this.initialStatus,
  });

  final Function(String?)? onChanged;
  final HomeEntity? homeEntity;
  final String? initialStatus;

  @override
  State<StatusField> createState() => _StatusFieldState();
}

class _StatusFieldState extends State<StatusField> {
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    final defaultStatus =
        widget.initialStatus ?? widget.homeEntity?.status ?? 'waiting';
    _selectedStatus = defaultStatus;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'inprogress':
        return Colors.blue;
      case 'waiting':
        return Colors.orange;
      case 'finished':
        return Colors.green;
      default:
        return kPrimaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'inprogress':
        return Icons.play_circle_outline;
      case 'waiting':
        return Icons.schedule;
      case 'finished':
        return Icons.check_circle_outline;
      default:
        return Icons.circle_outlined;
    }
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final statuses = ['waiting', 'inprogress', 'finished'];

    return DropdownButtonFormField<String>(
      iconSize: 30,
      iconEnabledColor: kPrimaryColor,
      style: FontStyles.fontStyleBold16(context).copyWith(color: kPrimaryColor),
      borderRadius: BorderRadius.circular(16),
      decoration: InputDecoration(
        filled: true,
        fillColor: kSecondColor,
        labelText: 'Status',
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
      value: _selectedStatus,
      items: statuses.map((status) {
        return DropdownMenuItem<String>(
          value: status,
          child: Text(
            _getDisplayText(status),
            style: FontStyles.fontStyleRegular14(context).copyWith(
              color: _getStatusColor(status),
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedStatus = value;
        });
        widget.onChanged?.call(value);
      },
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
        return _capitalizeFirstLetter(status);
    }
  }
}

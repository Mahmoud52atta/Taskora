import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class DateTimeField extends StatefulWidget {
  const DateTimeField({super.key, this.onChanged, this.child});
  final Function(String?)? onChanged;
  final Widget? child;
  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  DateTime? _selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      // Call the callback with the formatted date string
      final formattedDate =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      widget.onChanged?.call(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kSecondColor,
      ),
      width: double.infinity,
      height: 55,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 6, top: 5),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'End Date',
                  style: FontStyles.fontStyleRegular14(context),
                ),
                const SizedBox(
                  height: 2,
                ),
                InkWell(
                  child: widget.child ??
                      Text(
                        _selectedDate != null
                            ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                            : 'Choose due date...',
                        style: FontStyles.fontStyleRegular14(context).copyWith(
                          color: _selectedDate != null
                              ? Colors.black
                              : Colors.grey[600],
                        ),
                      ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Image.asset(
                Assets.imagesCalendar,
                width: 25,
                height: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

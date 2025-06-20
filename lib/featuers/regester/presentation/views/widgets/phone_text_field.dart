import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    super.key,
    required this.validator,
    required this.onChanged,
  });
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final Function(PhoneNumber) onChanged;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
        validator: validator,
        decoration: InputDecoration(
          labelText: 'رقم الهاتف',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          // prefixIcon: Icon(Icons.phone),
          // suffixIcon: Icon(Icons.phone), // جرب هنا
        ),
        initialCountryCode: 'EG', // مصر مثلاً
        onChanged: onChanged
        // (phone) {
        //   print(phone.completeNumber); // رقم كامل مع كود الدولة
        // },
        );
  }
}

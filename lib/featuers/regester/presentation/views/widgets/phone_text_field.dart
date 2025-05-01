import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        labelText: 'رقم الهاتف',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        // prefixIcon: Icon(Icons.phone),
        // suffixIcon: Icon(Icons.phone), // جرب هنا
      ),
      initialCountryCode: 'EG', // مصر مثلاً
      onChanged: (phone) {
        print(phone.completeNumber); // رقم كامل مع كود الدولة
      },
    );
  }
}

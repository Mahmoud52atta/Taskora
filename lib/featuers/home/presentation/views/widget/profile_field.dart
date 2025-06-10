import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final Widget? trailing;

  const ProfileField({
    required this.label,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: FontStyles.fontStyleMedium12(context).copyWith(
                    color: const Color(0xff2F2F2F).withOpacity(.4),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: FontStyles.fontStyleBold16(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xff2F2F2F).withOpacity(.6),
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ]
        ],
      ),
    );
  }
}

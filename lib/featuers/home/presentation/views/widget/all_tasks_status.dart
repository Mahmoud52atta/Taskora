import 'package:flutter/material.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/active_and_inactive_selected_stutus.dart';

class AllTasksStatus extends StatelessWidget {
  const AllTasksStatus(
      {super.key, required this.isSelected, required this.text});
  final bool isSelected;
  final String text;
  @override
  Widget build(BuildContext context) {
    return isSelected
        ? ActiveSelectedStatus(
            text: text,
          )
        : InActiveSelectedStatus(
            text: text,
          );
  }
}

import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/filtering_all_tasks_status.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Tasks',
            style: FontStyles.fontStyleBold16(context).copyWith(
              color: const Color(0xff7F7F7F),
            ),
          ),
          FilteringAllTasksStatus(),
          Expanded(
            flex: 3,
            child: Container(
              height: 70,
              color: Colors.amber,
              width: 50,
            ),
          )
        ],
      ),
    );
  }
}

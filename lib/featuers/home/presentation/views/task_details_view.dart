import 'package:flutter/material.dart';
import 'package:to_do_app/core/helper_function/const_space.dart';

import 'package:to_do_app/featuers/home/presentation/views/widget/task_details_appbar.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/task_details_body.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key});
  static const routeName = 'taskDetails';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ConstSpace.horizontalPadding(context)),
        child: const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 36)),
            SliverToBoxAdapter(
              child: TaskDetailsAppBar(),
            ),
            SliverToBoxAdapter(
              child: TaskDetailsBody(),
            )
          ],
        ),
      ),
    );
  }
}

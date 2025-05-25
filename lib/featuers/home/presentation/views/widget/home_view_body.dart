// import 'package:flutter/material.dart';
// import 'package:to_do_app/core/utils/app_images.dart';
// import 'package:to_do_app/core/utils/font_styles.dart';
// import 'package:to_do_app/featuers/home/presentation/views/widget/filtering_all_tasks_status.dart';
// import 'package:to_do_app/featuers/home/presentation/views/widget/item_task.dart';

// class HomeViewBody extends StatelessWidget {
//   const HomeViewBody({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'My Tasks',
//             style: FontStyles.fontStyleBold16(context).copyWith(
//               color: const Color(0xff7F7F7F),
//             ),
//           ),SizedBox(height:16 ,),
//           SizedBox(height: 37, child: const FilteringAllTasksStatus()),
//           const ItemTaskListView(),
//         ],
//       ),
//     );
//   }
// }

// class ItemTaskListView extends StatelessWidget {
//   const ItemTaskListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         child: ListView.builder(
//       padding: EdgeInsets.zero,
//       itemCount: 10,
//       itemBuilder: (index, context) => ItemTask(),
//     ));
//   }
// }

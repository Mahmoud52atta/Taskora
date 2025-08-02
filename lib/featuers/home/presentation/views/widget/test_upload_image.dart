// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:to_do_app/featuers/home/data/models/upload_image.dart';
// import 'package:to_do_app/featuers/home/presentation/manage/add_task_cubit/cubit/new_task_cubit.dart';

// class TestUploadImage extends StatelessWidget {
//   const TestUploadImage({super.key, this.image});
//   final UploadImageModel? image;
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NewTaskCubit, NewTaskState>(
//       builder: (context, state) {
//         return GestureDetector(
//           onTap: () {
//             context.read<NewTaskCubit>().uploadImage(image: image?.image ?? '');
//           },
//           child: Container(
//             width: double.infinity,
//             height: 200,
//             decoration: BoxDecoration(
//               color: Colors.red,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Image.network(
//               image?.image ?? '',
//               fit: BoxFit.cover,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

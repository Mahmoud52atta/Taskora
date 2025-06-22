import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/featuers/home/presentation/manage/delete_cubit/cubit/delete_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/views/task_details_view.dart';

import 'package:to_do_app/featuers/home/presentation/views/widget/build_task_image.dart';

class ItemTask extends StatelessWidget {
  const ItemTask({super.key, required this.homeEntity});
  final HomeEntity homeEntity;

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateStr; // fallback if parsing fails
    }
  }

  // Helper method to get status color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'inprogress':
        return kPrimaryColor;
      case 'waiting':
        return const Color(0xffFF7D53);
      case 'finished':
        return const Color(0xff0087FF);
      default:
        return const Color(0xffFF7D53); // fallback color
    }
  }

  // Helper method to get status display text
  String _getStatusDisplayText(String status) {
    switch (status.toLowerCase()) {
      case 'inprogress':
        return 'InProgress';
      case 'waiting':
        return 'Waiting';
      case 'finished':
        return 'Finished';
      default:
        return status; // fallback to original value
    }
  }

  // Helper method to get status background color
  Color _getStatusBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'inprogress':
        return kSecondColor;
      case 'waiting':
        return const Color(0xffFFE4F2);
      case 'finished':
        return const Color(0xffE3F2FF);
      default:
        return const Color(0xffFFE4F2); // fallback color
    }
  }

  // Helper method to get priority color
  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return const Color(0xffFF7D53);
      case 'medium':
        return kPrimaryColor;
      case 'low':
        return const Color(0xff0087FF);
      default:
        return const Color(0xff5F33E1); // fallback color
    }
  }

  // Helper method to get priority display text
  String _getPriorityDisplayText(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return 'High';
      case 'medium':
        return 'Medium';
      case 'low':
        return 'Low';
      default:
        return priority; // fallback to original value
    }
  }

  // // Helper method to get priority icon
  // IconData _getPriorityIcon(String priority) {
  //   switch (priority.toLowerCase()) {
  //     case 'high':
  //       return Icons.priority_high;
  //     case 'medium':
  //       return Icons.remove;
  //     case 'low':
  //       return Icons.keyboard_arrow_down;
  //     default:
  //       return Icons.flag;
  //   }
  // }

  // Helper method to get status icon
  // IconData _getStatusIcon(String status) {
  //   switch (status.toLowerCase()) {
  //     case 'inprogress':
  //       return Icons.play_circle_outline;
  //     case 'waiting':
  //       return Icons.schedule;
  //     case 'finished':
  //       return Icons.check_circle_outline;
  //     default:
  //       return Icons.circle_outlined;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          TaskDetailsView.routeName,
          arguments: {'details': homeEntity},
        );
      },
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: Row(
          children: [
            Expanded(
              child: BuildTaskImage(homeEntity: homeEntity),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.37,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          homeEntity.title,
                          style: FontStyles.fontStyleBold24(context),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                              color:
                                  _getStatusBackgroundColor(homeEntity.status),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              _getStatusDisplayText(homeEntity.status),
                              style: FontStyles.fontStyleMedium12(context)
                                  .copyWith(
                                      color:
                                          _getStatusColor(homeEntity.status)),
                            ),
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Image.asset(
                          Assets.imagesFrame5,
                          scale: 4.5,
                        ),
                        onSelected: (value) {
                          if (value == 'edit') {
                            Navigator.pushNamed(
                              context,
                              TaskDetailsView.routeName,
                              arguments: {'details': homeEntity},
                            );
                          } else if (value == 'delete') {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Task'),
                                content: const Text(
                                    'Are you sure you want to delete this task?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<DeleteCubit>()
                                          .deleteTask(id: homeEntity.id);
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.42,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      homeEntity.description,
                      style: FontStyles.fontStyleRegular14(context),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.42,
                          child: Row(
                            children: [
                              ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  _getPriorityColor(homeEntity.priority),
                                  BlendMode.srcIn,
                                ),
                                child: Image.asset(
                                  Assets.imagesFlage,
                                  scale: 5.5,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                _getPriorityDisplayText(homeEntity.priority),
                                style: FontStyles.fontStyleMedium12(context)
                                    .copyWith(
                                        color: _getPriorityColor(
                                            homeEntity.priority),
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                      Text(
                        _formatDate(homeEntity.date),
                        style: FontStyles.fontStyleRegular14(context),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

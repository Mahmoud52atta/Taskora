import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/featuers/home/presentation/views/task_details_view.dart';

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
              child: Image.asset(
                Assets.imagesImage2,
                scale: 3.5,
              ),
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
                        width: MediaQuery.sizeOf(context).width * 0.40,
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
                              horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                              color: const Color(0xffFFE4F2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              homeEntity.status,
                              style: FontStyles.fontStyleMedium12(context)
                                  .copyWith(color: const Color(0xffFF7D53)),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: MediaQuery.sizeOf(context).width * 0.00001,
                      // ),
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
                                      // TODO: Implement delete functionality
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
                              Image.asset(
                                Assets.imagesFlage,
                                scale: 5.5,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                homeEntity.priority,
                                style: FontStyles.fontStyleMedium12(context)
                                    .copyWith(
                                        color: const Color(
                                          0xff5F33E1,
                                        ),
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

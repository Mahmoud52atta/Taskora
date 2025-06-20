import 'package:flutter/material.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/item_task.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({
    super.key,
    required ScrollController scrollController,
    required this.tasks,
  }) : _scrollController = scrollController;
  // final List<HomeEntity> homeEntity;
  final ScrollController _scrollController;
  final List<HomeEntity> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ItemTask(homeEntity: tasks[index]),
        );
      },
    );
  }
}

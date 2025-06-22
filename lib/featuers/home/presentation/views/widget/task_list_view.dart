import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';
import 'package:to_do_app/featuers/home/presentation/manage/delete_cubit/cubit/delete_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/manage/home_cubit/home_cubit.dart';
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
    return BlocConsumer<DeleteCubit, DeleteState>(
      listener: (context, state) {
        if (state is DeleteSuccess) {
          context.read<HomeCubit>().getHomeData();

          // Clear any existing snackbars before showing new one
          ScaffoldMessenger.of(context).clearSnackBars();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Task deleted successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        if (tasks.isEmpty) {
          return _buildEmptyState(context);
        }

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
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final currentFilter = context.read<HomeCubit>().currentFilter;

    String message = 'No tasks available';
    IconData icon = Icons.task_alt;

    if (currentFilter != 'All') {
      message = 'No tasks with status "$currentFilter"';
      icon = Icons.filter_list_off;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          if (currentFilter != 'All')
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: () {
                  context.read<HomeCubit>().clearFilter();
                },
                child: const Text('Show All Tasks'),
              ),
            ),
        ],
      ),
    );
  }
}

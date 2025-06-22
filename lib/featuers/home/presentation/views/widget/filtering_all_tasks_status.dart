import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/featuers/home/presentation/manage/home_cubit/home_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/all_tasks_status.dart';

class FilteringAllTasksStatus extends StatelessWidget {
  const FilteringAllTasksStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final List<String> statuses = [
          'All',
          'Waiting',
          'Inprogress',
          'Finished'
        ];
        final currentFilter = context.read<HomeCubit>().currentFilter;

        return Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: statuses.map((status) {
                final isSelected = currentFilter == status;
                return GestureDetector(
                  onTap: () => context.read<HomeCubit>().filterByStatus(status),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AllTasksStatus(
                      isSelected: isSelected,
                      text: status,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

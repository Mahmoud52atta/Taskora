import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/featuers/home/presentation/manage/home_cubit/home_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/task_list_view.dart';

class HomeTaskListViewBloc extends StatelessWidget {
  const HomeTaskListViewBloc({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeFailure) {
          return Center(child: Text(state.message));
        } else if (state is HomeSuccess) {
          return TasksListView(
              scrollController: _scrollController, tasks: state.homeData);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/helper_function/const_space.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/featuers/home/presentation/manage/home_cubit/home_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/views/add_new_task_view.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/home_task_list_view_bloc.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/home_view_appBar.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/filtering_all_tasks_status.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/filter_indicator.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const routeName = 'homeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _mainScrollController = ScrollController();
  final ScrollController _taskListScrollController = ScrollController();
  bool _showFAB = false;
  bool _hasTasks = false;
  int _taskCount = 0;

  @override
  void initState() {
    super.initState();
    showFlaotingActionBottonMethod();
  }

  @override
  void dispose() {
    _mainScrollController.dispose();
    _taskListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeSuccess) {
          setState(() {
            _hasTasks = state.homeData.isNotEmpty;
            _taskCount = state.homeData.length;
          });
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ConstSpace.horizontalPadding(context)),
          child: CustomScrollView(
            controller: _mainScrollController,
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 36)),
              const SliverToBoxAdapter(child: HomeViewAppBar()),
              const SliverToBoxAdapter(child: SizedBox(height: 36)),
              SliverToBoxAdapter(
                child: Text(
                  'My Tasks',
                  style: FontStyles.fontStyleBold16(context).copyWith(
                    color: const Color(0xff7F7F7F),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              const SliverToBoxAdapter(
                  child:
                      SizedBox(height: 37, child: FilteringAllTasksStatus())),
              const SliverToBoxAdapter(child: FilterIndicator()),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              SliverToBoxAdapter(
                child: HomeTaskListViewBloc(
                    scrollController: _taskListScrollController),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)), // space
            ],
          ),
        ),
        floatingActionButton: _shouldShowFAB()
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    heroTag: "qrBtn",
                    mini: true,
                    backgroundColor: const Color(0xffEBE5FF),
                    onPressed: () {},
                    child: Image.asset(Assets.imagesBotton),
                  ),
                  const SizedBox(height: 12),
                  FloatingActionButton(
                    heroTag: "addBtn",
                    backgroundColor: const Color(0xff5F33E1),
                    onPressed: () {
                      Navigator.pushNamed(context, AddNewTaskView.routeName);
                    },
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  bool _shouldShowFAB() {
    // Show FAB if:
    // 1. There are no tasks
    // 2. There are few tasks (1-3 tasks) - no need to scroll
    // 3. User has scrolled down (for many tasks)
    return !_hasTasks || _taskCount <= 3 || _showFAB;
  }

  void showFlaotingActionBottonMethod() {
    _mainScrollController.addListener(() {
      if (_mainScrollController.position.pixels >=
          _mainScrollController.position.maxScrollExtent - 300) {
        if (!_showFAB) setState(() => _showFAB = true);
      } else {
        if (_showFAB) setState(() => _showFAB = false);
      }
    });
  }
}

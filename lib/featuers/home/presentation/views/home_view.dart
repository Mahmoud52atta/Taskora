import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/home_view_appBar.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/item_task.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/filtering_all_tasks_status.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const routeName = 'homeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  bool _showFAB = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        if (!_showFAB) setState(() => _showFAB = true);
      } else {
        if (_showFAB) setState(() => _showFAB = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.sizeOf(context).width * 0.05;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: CustomScrollView(
          controller: _scrollController,
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
                child: SizedBox(height: 37, child: FilteringAllTasksStatus())),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: ItemTask(),
                ),
                childCount: 10,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)), // space
          ],
        ),
      ),
      floatingActionButton: _showFAB
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
                  onPressed: () {},
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            )
          : null,
    );
  }
}

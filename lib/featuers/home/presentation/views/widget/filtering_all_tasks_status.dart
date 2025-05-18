import 'package:flutter/material.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/all_tasks_status.dart';

class FilteringAllTasksStatus extends StatefulWidget {
  const FilteringAllTasksStatus({super.key});

  @override
  State<FilteringAllTasksStatus> createState() =>
      _FilteringAllTasksStatusState();
}

class _FilteringAllTasksStatusState extends State<FilteringAllTasksStatus> {
  final List<String> status = ['All', 'Inprogress', 'Waiting', 'Finished'];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(scrollDirection: Axis.horizontal, slivers: [
        SliverToBoxAdapter(
          child: Row(
            children: [
              GestureDetector(
                  onTap: () => updateIndex(0),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AllTasksStatus(
                        isSelected: selectedIndex == 0, text: status[0]),
                  )),
              GestureDetector(
                  onTap: () => updateIndex(1),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AllTasksStatus(
                        isSelected: selectedIndex == 1, text: status[1]),
                  )),
              GestureDetector(
                  onTap: () => updateIndex(2),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AllTasksStatus(
                        isSelected: selectedIndex == 2, text: status[2]),
                  )),
              GestureDetector(
                  onTap: () => updateIndex(3),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AllTasksStatus(
                        isSelected: selectedIndex == 3, text: status[3]),
                  ))
            ],
          ),
        )
      ]),
    );
  }

  void updateIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

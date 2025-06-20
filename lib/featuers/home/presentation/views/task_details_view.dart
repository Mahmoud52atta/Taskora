import 'package:flutter/material.dart';
import 'package:to_do_app/core/helper_function/const_space.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/task_details_appbar.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/task_details_body.dart';

class TaskDetailsView extends StatefulWidget {
  const TaskDetailsView({super.key, required this.details});
  static const routeName = 'taskDetails';
  final HomeEntity details;

  @override
  State<TaskDetailsView> createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<TaskDetailsView> {
  bool _isEditing = false;
  late HomeEntity _currentDetails;

  @override
  void initState() {
    super.initState();
    _currentDetails = widget.details;
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _updateTaskDetails(HomeEntity updatedDetails) {
    setState(() {
      _currentDetails = updatedDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ConstSpace.horizontalPadding(context)),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 36)),
            SliverToBoxAdapter(
              child: TaskDetailsAppBar(
                details: _currentDetails,
                isEditing: _isEditing,
                onEditToggle: _toggleEditing,
              ),
            ),
            SliverToBoxAdapter(
              child: TaskDetailsBody(
                details: _currentDetails,
                isEditing: _isEditing,
                onEditToggle: _toggleEditing,
                onTaskUpdated: _updateTaskDetails,
              ),
            )
          ],
        ),
      ),
    );
  }
}

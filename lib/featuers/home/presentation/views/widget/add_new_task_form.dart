import 'package:flutter/material.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/add_task_button.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/date_time_field.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/image_field.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/periority_field.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/status_field.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/task_description_field.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/task_title_field.dart';

class AddNewTaskForm extends StatelessWidget {
  const AddNewTaskForm({
    super.key,
    required this.onImageChanged,
    required this.onTitleChanged,
    required this.onDescriptionChanged,
    required this.onPriorityChanged,
    required this.onDateTimeChanged,
    required this.onAddTask,
  });

  final ValueChanged<String?> onImageChanged;
  final ValueChanged<String?> onTitleChanged;
  final ValueChanged<String?> onDescriptionChanged;
  final ValueChanged<String?> onPriorityChanged;
  final ValueChanged<String?> onDateTimeChanged;
  final VoidCallback onAddTask;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(child: ImageField(onChanged: onImageChanged)),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: TaskTitleField(onChanged: onTitleChanged),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: TaskDescriptionField(onChanged: onDescriptionChanged),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: PeriorityField(onChanged: onPriorityChanged),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: DateTimeField(onChanged: onDateTimeChanged),
        ),
        SliverToBoxAdapter(
          child: AddTaskButton(onPressed: onAddTask),
        ),
      ],
    );
  }
}

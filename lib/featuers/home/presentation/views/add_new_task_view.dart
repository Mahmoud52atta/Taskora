import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/helper_function/const_space.dart';
import 'package:to_do_app/featuers/home/presentation/manage/add_task_cubit/cubit/new_task_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/manage/home_cubit/home_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/add_new_task_form.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/add_task_appbar.dart';

class AddNewTaskView extends StatefulWidget {
  const AddNewTaskView({super.key});
  static const routeName = 'addNewTaskView';

  @override
  State<AddNewTaskView> createState() => _AddNewTaskViewState();
}

class _AddNewTaskViewState extends State<AddNewTaskView> {
  String? title;
  String? description;
  String? priority = 'medium';
  String? dateTime;
  String? selectedImagePath;

  void _addTask() {
    if (selectedImagePath == null || selectedImagePath!.isEmpty) {
      _showValidationError('Please select an image');
      return;
    }
    if (title == null || title!.isEmpty) {
      _showValidationError('Please enter a title');
      return;
    }
    if (description == null || description!.isEmpty) {
      _showValidationError('Please enter a description');
      return;
    }
    if (dateTime == null || dateTime!.isEmpty) {
      _showValidationError('Please select a date');
      return;
    }

    context.read<NewTaskCubit>().addTask(
          title: title!,
          description: description!,
          priority: priority!,
          diuDate: dateTime!,
          image: selectedImagePath!,
        );
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewTaskCubit, NewTaskState>(
      listener: (context, state) {
        if (state is NewTaskSuccess) {
          context.read<HomeCubit>().getHomeData();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Task added successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is NewTaskFailure) {
          _showValidationError(state.error);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ConstSpace.horizontalPadding(context)),
          child: Column(
            children: [
              const SizedBox(height: 36),
              const AddTaskAppBar(text: 'Add New Task'),
              Expanded(
                child: AddNewTaskForm(
                  onImageChanged: (path) => selectedImagePath = path,
                  onTitleChanged: (newTitle) => title = newTitle,
                  onDescriptionChanged: (newDesc) => description = newDesc,
                  onPriorityChanged: (newPriority) => priority = newPriority,
                  onDateTimeChanged: (newDate) => dateTime = newDate,
                  onAddTask: _addTask,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

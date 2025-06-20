import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/helper_function/const_space.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/presentation/manage/add_task_cubit/cubit/new_task_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/manage/home_cubit/home_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/add_task_appbar.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/image_field.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/task_title_field.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/task_description_field.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/periority_field.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/date_time_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewTaskCubit, NewTaskState>(
      listener: (context, state) {
        if (state is NewTaskSuccess) {
          // Refresh home data to show the new task
          context.read<HomeCubit>().getHomeData();
          // Navigate back to home view
          Navigator.pop(context);
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Task added successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is NewTaskFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ConstSpace.horizontalPadding(context)),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 36)),
                const SliverToBoxAdapter(
                    child: AddTaskAppBar(
                  text: 'Add New Task',
                )),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(child: ImageField(
                  onChanged: (imagePath) {
                    setState(() {
                      selectedImagePath = imagePath;
                    });
                  },
                )),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(child: TaskTitleField(
                  onChanged: (p0) {
                    setState(() {
                      title = p0;
                    });
                  },
                )),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(child: TaskDescriptionField(
                  onChanged: (p0) {
                    setState(() {
                      description = p0;
                    });
                  },
                )),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(child: PeriorityField(
                  onChanged: (p0) {
                    setState(() {
                      priority = p0;
                    });
                  },
                )),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(child: DateTimeField(
                  onChanged: (p0) {
                    setState(() {
                      dateTime = p0;
                    });
                  },
                )),
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16))),
                            backgroundColor:
                                const WidgetStatePropertyAll(kPrimaryColor)),
                        onPressed: state is NewTaskLoading
                            ? null // Disable button while loading
                            : () {
                                // Validate required fields
                                if (selectedImagePath == null ||
                                    selectedImagePath!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Please select an image')),
                                  );
                                  return;
                                }

                                if (title == null || title!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Please enter a title')),
                                  );
                                  return;
                                }

                                if (description == null ||
                                    description!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Please enter a description')),
                                  );
                                  return;
                                }

                                if (dateTime == null || dateTime!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Please select a date')),
                                  );
                                  return;
                                }

                                print(
                                    'Selected image path: $selectedImagePath');
                                context.read<NewTaskCubit>().addTask(
                                      title: title ?? '',
                                      description: description ?? '',
                                      priority: priority ?? '',
                                      diuDate: dateTime ?? '',
                                      image: selectedImagePath ?? '',
                                    );
                              },
                        child: state is NewTaskLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
                                'Add task',
                                style: FontStyles.fontStyleBold16(context)
                                    .copyWith(
                                        color: Colors.white, fontSize: 19),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

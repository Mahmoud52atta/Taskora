import 'package:flutter/material.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/helper_function/const_space.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
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
  String? _selectedImagePath;

  @override
  Widget build(BuildContext context) {
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
              onImageSelected: (String? imagePath) {
                // Store the image path to use when creating/updating the todo
                setState(() {
                  _selectedImagePath = imagePath;
                });
              },
            )),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            const SliverToBoxAdapter(child: TaskTitleField()),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            const SliverToBoxAdapter(child: TaskDescriptionField()),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            const SliverToBoxAdapter(child: PeriorityField()),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            const SliverToBoxAdapter(child: DateTimeField()),
            SliverToBoxAdapter(
              child: SizedBox(
                // height: 10,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                        backgroundColor:
                            const WidgetStatePropertyAll(kPrimaryColor)),
                    onPressed: () {
                      // TODO: Create task with _selectedImagePath
                      print('Selected image path: $_selectedImagePath');
                    },
                    child: Text(
                      'Add task',
                      style: FontStyles.fontStyleBold16(context)
                          .copyWith(color: Colors.white, fontSize: 19),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

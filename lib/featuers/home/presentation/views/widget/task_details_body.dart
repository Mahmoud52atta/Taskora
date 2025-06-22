import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';
import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';
import 'package:to_do_app/featuers/home/presentation/manage/edit_cubit/cubit/edit_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/manage/home_cubit/home_cubit.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/date_time_field.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/image_field.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/task_details_widgets/task_details_image_section.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/task_details_widgets/task_details_priority_dropdown.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/task_details_widgets/task_details_save_button.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/task_details_widgets/task_details_status_dropdown.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/task_details_widgets/task_details_text_field.dart';
import 'dart:io';

class TaskDetailsBody extends StatefulWidget {
  const TaskDetailsBody({
    super.key,
    required this.details,
    required this.isEditing,
    required this.onEditToggle,
    required this.onTaskUpdated,
  });
  final HomeEntity details;
  final bool isEditing;
  final VoidCallback onEditToggle;
  final Function(HomeEntity) onTaskUpdated;

  @override
  State<TaskDetailsBody> createState() => _TaskDetailsBodyState();
}

class _TaskDetailsBodyState extends State<TaskDetailsBody> {
  String? _selectedStatus;
  String? _selectedPriority;
  String? _title;
  String? _description;
  String? _dateTime;
  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  @override
  void didUpdateWidget(covariant TaskDetailsBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.details != oldWidget.details) {
      _initState();
    }
  }

  void _initState() {
    _selectedStatus = widget.details.status;
    _selectedPriority = widget.details.priority;
    _title = widget.details.title;
    _description = widget.details.description;
    _dateTime = widget.details.date;
    _selectedImagePath = widget.details.image;
  }

  void _saveChanges() {
    if (_selectedImagePath == null || _selectedImagePath!.isEmpty) {
      _showSnackBar('Please select an image');
      return;
    }
    if (_title == null || _title!.isEmpty) {
      _showSnackBar('Please enter a title');
      return;
    }
    if (_description == null || _description!.isEmpty) {
      _showSnackBar('Please enter a description');
      return;
    }
    if (_dateTime == null || _dateTime!.isEmpty) {
      _showSnackBar('Please select a date');
      return;
    }

    context.read<EditCubit>().editTask(
          id: widget.details.id,
          image: _selectedImagePath!,
          title: _title!,
          description: _description!,
          priority: _selectedPriority!,
          status: _selectedStatus!,
          diuDate: _dateTime!,
        );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditCubit, EditState>(
      listener: (context, state) {
        if (state is EditSuccess) {
          _showSnackBar('Task updated successfully!');
          widget.onEditToggle();

          final updatedDetails = HomeEntity(
            id: widget.details.id,
            image: _selectedImagePath!,
            title: _title!,
            description: _description!,
            status: _selectedStatus!,
            priority: _selectedPriority!,
            date: _dateTime!,
          );
          widget.onTaskUpdated(updatedDetails);

          context.read<HomeCubit>().getHomeData();
        } else if (state is EditFailure) {
          _showSnackBar(state.message);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Image', style: FontStyles.fontStyleRegular14(context)),
          const SizedBox(height: 8),
          TaskDetailsImageSection(
            isEditing: widget.isEditing,
            imagePath: _selectedImagePath,
            onChanged: (path) => setState(() => _selectedImagePath = path),
          ),
          const SizedBox(height: 30),
          TaskDetailsTextField(
            label: 'Title',
            isEditing: widget.isEditing,
            value: _title ?? '',
            onChanged: (value) => _title = value,
            displayStyle: FontStyles.fontStyleBold24(context),
          ),
          TaskDetailsTextField(
            label: 'Description',
            isEditing: widget.isEditing,
            value: _description ?? '',
            onChanged: (value) => _description = value,
            displayStyle: FontStyles.fontStyleRegular14(context),
            maxLines: 4,
          ),
          Text('Date', style: FontStyles.fontStyleRegular14(context)),
          const SizedBox(height: 8),
          DateTimeField(
            onChanged: (value) => setState(() => _dateTime = value),
            child: Text(_dateTime ?? ''),
          ),
          const SizedBox(height: 16),
          Text('Status', style: FontStyles.fontStyleRegular14(context)),
          const SizedBox(height: 8),
          TaskDetailsStatusDropdown(
            isEditing: widget.isEditing,
            selectedValue: _selectedStatus,
            onChanged: (value) => setState(() => _selectedStatus = value),
          ),
          const SizedBox(height: 16),
          Text('Priority', style: FontStyles.fontStyleRegular14(context)),
          const SizedBox(height: 8),
          TaskDetailsPriorityDropdown(
            isEditing: widget.isEditing,
            selectedValue: _selectedPriority,
            onChanged: (value) => setState(() => _selectedPriority = value),
          ),
          const SizedBox(height: 16),
          if (widget.isEditing) TaskDetailsSaveButton(onPressed: _saveChanges),
          const SizedBox(height: 10),
          Center(child: Image.asset(Assets.imagesQRCode)),
        ],
      ),
    );
  }

  Widget _buildImageWidget(String imagePath) {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Icon(Icons.error, size: 50),
          );
        },
      );
    } else {
      return Image.file(
        File(imagePath),
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Icon(Icons.error, size: 50),
          );
        },
      );
    }
  }

  Widget _buildStatusDropdown() {
    final standardStatuses = ['waiting', 'inprogress', 'finished'];
    final allStatuses = <String>[];
    allStatuses.addAll(standardStatuses);
    if (!allStatuses.contains(_selectedStatus)) {
      allStatuses.add(_selectedStatus ?? '');
    }

    return DropdownButtonFormField<String>(
      iconSize: 30,
      iconEnabledColor: kPrimaryColor,
      style: FontStyles.fontStyleBold16(context).copyWith(color: kPrimaryColor),
      borderRadius: BorderRadius.circular(16),
      decoration: InputDecoration(
        filled: true,
        fillColor: kSecondColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      value: _selectedStatus,
      items: allStatuses
          .map((status) => DropdownMenuItem(
                value: status,
                child: Text(status.isNotEmpty
                    ? _getStatusDisplayText(status)
                    : 'Unknown'),
              ))
          .toList(),
      onChanged: widget.isEditing
          ? (String? newValue) {
              setState(() {
                _selectedStatus = newValue;
              });
            }
          : null,
    );
  }

  Widget _buildPriorityDropdown() {
    final standardPriorities = ['high', 'medium', 'low'];
    final allPriorities = <String>[];
    allPriorities.addAll(standardPriorities);
    if (!allPriorities.contains(_selectedPriority)) {
      allPriorities.add(_selectedPriority ?? '');
    }

    return DropdownButtonFormField<String>(
      iconSize: 30,
      iconEnabledColor: kPrimaryColor,
      borderRadius: BorderRadius.circular(16),
      style: FontStyles.fontStyleBold16(context).copyWith(color: kPrimaryColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: kSecondColor,
        prefixIcon: Image.asset(
          scale: 4.5,
          Assets.imagesFlage,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      value: _selectedPriority,
      items: allPriorities
          .map((priority) => DropdownMenuItem(
                value: priority,
                child: Text(priority.isNotEmpty
                    ? _getPriorityDisplayText(priority)
                    : 'Unknown'),
              ))
          .toList(),
      onChanged: widget.isEditing
          ? (String? newValue) {
              setState(() {
                _selectedPriority = newValue;
              });
            }
          : null,
    );
  }

  Widget _buildSaveButton(EditState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          backgroundColor: WidgetStateProperty.all(kPrimaryColor),
        ),
        onPressed: state is EditLoading
            ? null
            : () {
                // Validate required fields
                if (_selectedImagePath == null || _selectedImagePath!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select an image')),
                  );
                  return;
                }

                if (_title == null || _title!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a title')),
                  );
                  return;
                }

                if (_description == null || _description!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a description')),
                  );
                  return;
                }

                if (_dateTime == null || _dateTime!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a date')),
                  );
                  return;
                }

                context.read<EditCubit>().editTask(
                      id: widget.details.id,
                      image: _selectedImagePath ?? widget.details.image,
                      title: _title ?? widget.details.title,
                      description: _description ?? widget.details.description,
                      priority: _selectedPriority ?? widget.details.priority,
                      status: _selectedStatus ?? widget.details.status,
                      diuDate: _dateTime ?? widget.details.date,
                    );
              },
        child: state is EditLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Save Changes',
                style: FontStyles.fontStyleBold16(context).copyWith(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      initialValue: _title,
      onChanged: (value) {
        setState(() {
          _title = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Enter title here...',
        hintStyle: FontStyles.fontStyleRegular14(context),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: kSecondColor,
      ),
      style: FontStyles.fontStyleBold16(context),
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      initialValue: _description,
      onChanged: (value) {
        setState(() {
          _description = value;
        });
      },
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Enter description here...',
        hintStyle: FontStyles.fontStyleRegular14(context),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: kSecondColor,
      ),
      style: FontStyles.fontStyleRegular14(context),
    );
  }

  Widget _buildDateField() {
    return DateTimeField(
      onChanged: (value) {
        setState(() {
          _dateTime = value;
        });
      },
      child: Text(_dateTime ?? widget.details.date),
    );
  }

  String _getStatusDisplayText(String status) {
    switch (status) {
      case 'waiting':
        return 'Waiting';
      case 'inprogress':
        return 'In Progress';
      case 'finished':
        return 'Finished';
      default:
        return 'Unknown';
    }
  }

  String _getPriorityDisplayText(String priority) {
    switch (priority) {
      case 'high':
        return 'High';
      case 'medium':
        return 'Medium';
      case 'low':
        return 'Low';
      default:
        return 'Unknown';
    }
  }
}

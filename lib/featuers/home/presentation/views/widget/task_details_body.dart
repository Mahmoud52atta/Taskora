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
import 'package:to_do_app/featuers/home/presentation/views/widget/periority_field.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/status_field.dart';
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
    _selectedStatus = widget.details.status;
    _selectedPriority = widget.details.priority;
    _title = widget.details.title;
    _description = widget.details.description;
    _dateTime = widget.details.date;
    _selectedImagePath = widget.details.image;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditCubit, EditState>(
      listener: (context, state) {
        if (state is EditSuccess) {
          // Show success message first
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Task updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );

          // Exit edit mode but stay on task details view
          widget.onEditToggle();

          // Create updated task details with new values
          final updatedDetails = HomeEntity(
            image: _selectedImagePath ?? widget.details.image,
            title: _title ?? widget.details.title,
            description: _description ?? widget.details.description,
            status: _selectedStatus ?? widget.details.status,
            priority: _selectedPriority ?? widget.details.priority,
            date: _dateTime ?? widget.details.date,
          );

          // Update the task details in parent widget
          widget.onTaskUpdated(updatedDetails);

          // Immediately refresh home data
          context.read<HomeCubit>().getHomeData();

          // Also refresh after a delay to ensure server has processed the update
          Future.delayed(const Duration(seconds: 1), () {
            if (context.mounted) {
              context.read<HomeCubit>().getHomeData();
            }
          });
        } else if (state is EditFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Image',
              style: FontStyles.fontStyleRegular14(context),
            ),
            const SizedBox(height: 8),
            widget.isEditing
                ? ImageField(
                    onChanged: (imagePath) {
                      setState(() {
                        _selectedImagePath = imagePath;
                      });
                    },
                  )
                : _buildImageWidget(widget.details.image),
            const SizedBox(height: 30),
            Text(
              'Title',
              style: FontStyles.fontStyleRegular14(context),
            ),
            const SizedBox(height: 8),
            widget.isEditing
                ? _buildTitleField()
                : Text(
                    widget.details.title,
                    style: FontStyles.fontStyleBold24(context),
                  ),
            const SizedBox(height: 8),
            Text(
              'Description',
              style: FontStyles.fontStyleRegular14(context),
            ),
            const SizedBox(height: 8),
            widget.isEditing
                ? _buildDescriptionField()
                : Text(
                    widget.details.description,
                    style: FontStyles.fontStyleRegular14(context),
                  ),
            const SizedBox(height: 16),
            Text(
              'Date',
              style: FontStyles.fontStyleRegular14(context),
            ),
            const SizedBox(height: 8),
            widget.isEditing
                ? _buildDateField()
                : DateTimeField(
                    child: Text(widget.details.date),
                  ),
            const SizedBox(height: 8),
            Text(
              'Status',
              style: FontStyles.fontStyleRegular14(context),
            ),
            const SizedBox(height: 8),
            _buildStatusDropdown(),
            const SizedBox(height: 8),
            Text(
              'Priority',
              style: FontStyles.fontStyleRegular14(context),
            ),
            const SizedBox(height: 8),
            _buildPriorityDropdown(),
            const SizedBox(height: 16),
            if (widget.isEditing) _buildSaveButton(state),
            const SizedBox(height: 10),
            Center(
              child: Image.asset(Assets.imagesQRCode),
            )
          ],
        );
      },
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
    final standardStatuses = [
      'Inprogress',
      'Completed',
      'Pending',
      'waiting',
      'inprogress',
      'completed',
      'pending'
    ];
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
                child: Text(status.isNotEmpty ? status : 'Unknown'),
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
    final standardPriorities = [
      'high',
      'medium',
      'low',
      'High',
      'Medium',
      'Low'
    ];
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
                child: Text(priority.isNotEmpty ? priority : 'Unknown'),
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
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          backgroundColor: MaterialStateProperty.all(kPrimaryColor),
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
}

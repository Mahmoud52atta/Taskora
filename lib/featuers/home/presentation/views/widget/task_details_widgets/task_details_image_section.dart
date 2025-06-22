import 'dart:io';
import 'package:flutter/material.dart';
import 'package:to_do_app/featuers/home/presentation/views/widget/image_field.dart';

class TaskDetailsImageSection extends StatelessWidget {
  const TaskDetailsImageSection({
    super.key,
    required this.isEditing,
    required this.imagePath,
    required this.onChanged,
  });

  final bool isEditing;
  final String? imagePath;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return isEditing
        ? ImageField(onChanged: onChanged)
        : _buildImageWidget(imagePath ?? '');
  }

  Widget _buildImageWidget(String path) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Icon(Icons.error, size: 50),
          );
        },
      );
    } else if (path.isNotEmpty) {
      return Image.file(
        File(path),
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
      return Container(
        height: 200,
        width: double.infinity,
        color: Colors.grey[300],
        child: const Icon(Icons.image_not_supported, size: 50),
      );
    }
  }
}

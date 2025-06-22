import 'package:to_do_app/featuers/home/domain/entities/add_task_entity.dart';

class AddTaskModel extends AddTaskEntity {
  final String? id;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;

  AddTaskModel({
    required super.image,
    required super.title,
    required super.description,
    required super.priority,
    required super.status,
    required super.diuDate,
    this.id,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory AddTaskModel.fromJson(Map<String, dynamic> json) => AddTaskModel(
        image: json['image'] as String? ?? '',
        title: json['title'] as String? ?? '',
        description: json['desc'] as String? ?? '',
        priority: json['priority'] as String? ?? '',
        status: json['status'] as String? ?? 'Waiting',
        diuDate: json['diuDate'] as String? ?? '',
        id: json['_id'] as String?,
        userId: json['user'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        version: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'title': title,
        'desc': description,
        'priority': priority,
        'status': status,
        'diuDate': diuDate,
        '_id': id,
        'user': userId,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': version,
      };
}

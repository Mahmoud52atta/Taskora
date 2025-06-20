import 'package:to_do_app/featuers/home/domain/entities/edite_entity.dart';

class EditeModel extends EditEntity {
  final String id;

  EditeModel({
    required super.image,
    required super.title,
    required super.description,
    required super.dueDate,
    required super.status,
    required super.priority,
    required this.id,
  });

  factory EditeModel.fromJson(Map<String, dynamic> json) {
    return EditeModel(
      id: json['_id'] as String,
      image: json['image'] as String,
      title: json['title'] as String,
      description: json['desc'] as String,
      dueDate: json['diuDate'] as String,
      status: json['status'] as String,
      priority: json['priority'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'image': image,
        'title': title,
        'desc': description,
        'priority': priority,
        'status': status,
        '_id': id,
        'diuDate': dueDate,
      };
}

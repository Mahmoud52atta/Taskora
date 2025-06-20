import 'package:to_do_app/featuers/home/domain/entities/hoem_entity.dart';

class HomeModel extends HomeEntity {
  final String id;
  final String user;
  final String createdAt;
  final String updatedAt;
  final int v;

  HomeModel({
    required this.id,
    required super.image,
    required super.title,
    required super.description,
    required super.status,
    required super.priority,
    required super.date,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['_id'] ?? '',
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      description: json['desc'] ?? '',
      status: json['status'] ?? '',
      priority: json['priority'] ?? '',
      date: json['createdAt'] ?? '',
      user: json['user'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
      'title': title,
      'desc': description,
      'status': status,
      'priority': priority,
      'createdAt': date,
      'user': user,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

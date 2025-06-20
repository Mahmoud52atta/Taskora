import 'package:to_do_app/featuers/regester/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  String? id;
  List<String>? roles;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ProfileModel({
    required super.phone,
    required super.name,
    required super.level,
    required super.yearsOfExperience,
    required super.location,
    this.id,
    this.roles,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json['_id'] as String?,
        roles:
            (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
        active: json['active'] as bool?,
        name: json['displayName'] as String? ?? '',
        level: json['level'] as String? ?? '',
        yearsOfExperience: (json['experienceYears'] as int?)?.toString() ?? '0',
        location: json['address'] as String? ?? '',
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        phone: json['username'] as String? ?? '',
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'roles': roles,
        'active': active,
        'level': level,
        'phone': phone,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}

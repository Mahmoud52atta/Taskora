class UploadImageModel {
  final String image;
  UploadImageModel({required this.image});

  factory UploadImageModel.fromJson(Map<String, dynamic> json) {
    return UploadImageModel(image: json['image'] ?? '');
  }
}
// Map<String, dynamic> toJson() {
//     return {
//       'image': image,
//     };
//   }
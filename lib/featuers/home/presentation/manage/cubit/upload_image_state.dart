part of 'upload_image_cubit.dart';

@immutable
sealed class UploadImageState {}

final class UploadImageInitial extends UploadImageState {}

final class UploadImageLoading extends UploadImageState {}

final class UploadImageSuccess extends UploadImageState {}

final class UploadImageFailuer extends UploadImageState {
  final String error;

  UploadImageFailuer({required this.error});
}

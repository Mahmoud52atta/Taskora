import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/constant.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class ImageField extends StatefulWidget {
  const ImageField({super.key, this.onChanged});
  final Function(String?)? onChanged;

  @override
  State<ImageField> createState() => ImageFieldState();
}

class ImageFieldState extends State<ImageField> {
  XFile? _image;
  String? _imagePath;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
        _imagePath = image.path;
      });
      // Notify parent widget of the selected image path
      widget.onChanged?.call(_imagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
   
        return Column(
          children: [
            if (_image != null) ...[
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: 
                  // Image.network(
                  //   _uploadImageModel!.image,
                  //   height: 200,
                  //   width: double.infinity,
                  //   fit: BoxFit.cover,
                  // )
                  Image.file(
                    File(_image!.path),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  ),
              const SizedBox(height: 16),
            ],
            SizedBox(
              height: 56,
              width: double.infinity,
              child: OutlinedButton.icon(
                style: ButtonStyle(
                  overlayColor: const WidgetStatePropertyAll(kSecondColor),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                onPressed: _pickImage,
                icon: Image.asset(
                  Assets.imagesAddPhoto,
                  scale: 4.5,
                ),
                label: Text(
                  _image == null ? 'Add Image' : 'Change Image',
                  style: FontStyles.fontStyleBold16(context)
                      .copyWith(color: kPrimaryColor, fontSize: 19),
                ),
              ),
            ),
          ],
        );
      }
    
  String? get selectedImagePath => _imagePath;
  }




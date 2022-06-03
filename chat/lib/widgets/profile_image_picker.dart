import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  final void Function(File) onImagePicked;

  const ProfileImagePicker({
    Key? key,
    required this.onImagePicked,
  }) : super(key: key);

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _picture;

  void _pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      maxWidth: 200,
      maxHeight: 200,
    );
    if (image == null) {
      return;
    }

    setState(() => _picture = File(image.path));

    widget.onImagePicked(_picture!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blueGrey.shade400,
            backgroundImage: _picture != null ? FileImage(_picture!) : null,
          ),
          const Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

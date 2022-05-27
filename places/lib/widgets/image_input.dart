import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _image;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile != null) {
      setState(() => _image = File(imageFile!.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(
                width: 1,
                color: Colors.blueGrey.shade500,
              ),
            ),
            child: _image != null
                ? Image.file(
                    _image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Center(
                    child: Text(
                      "image required",
                      style: TextStyle(color: Colors.blueGrey.shade600),
                      textAlign: TextAlign.center,
                    ),
                  ),
            alignment: Alignment.center,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextButton.icon(
              icon: const Icon(Icons.camera),
              label: const Text("Take Picture..."),
              onPressed: _takePicture,
            ),
          ),
        ],
      ),
    );
  }
}

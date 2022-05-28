import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final void Function(XFile) onCapture;
  final void Function()? onDelete;
  final bool inErrorState;

  const ImageInput({
    Key? key,
    required this.onCapture,
    this.onDelete,
    this.inErrorState = false,
  }) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _image;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return;
    }
    setState(() => _image = File(imageFile.path));

    widget.onCapture(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context);
    final colors = Theme.of(context).colorScheme;

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
                color:
                    widget.inErrorState ? Colors.red : Colors.blueGrey.shade500,
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
                      style: TextStyle(
                          color: widget.inErrorState
                              ? Colors.red
                              : Colors.blueGrey.shade600),
                      textAlign: TextAlign.center,
                    ),
                  ),
            alignment: Alignment.center,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: device.size.width / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton.icon(
                  icon: Icon(
                    Icons.camera,
                    color: widget.inErrorState ? Colors.red : colors.primary,
                  ),
                  style: const ButtonStyle(
                    alignment: Alignment.centerLeft,
                  ),
                  label: Text(
                    _image == null ? "Take Picture..." : "Retake Picture...",
                    style: TextStyle(
                        color: widget.inErrorState
                            ? Colors.red
                            : Colors.blueGrey.shade600),
                  ),
                  onPressed: _takePicture,
                ),
                if (_image != null && widget.onDelete != null)
                  TextButton.icon(
                    style: const ButtonStyle(
                      alignment: Alignment.centerLeft,
                    ),
                    icon: const Icon(Icons.delete),
                    label: Text(
                      "Delete",
                      style: TextStyle(color: Colors.blueGrey.shade600),
                    ),
                    onPressed: () => setState(
                      () {
                        _image = null;
                        widget.onDelete!();
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

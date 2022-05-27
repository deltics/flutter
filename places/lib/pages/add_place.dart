import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../data/providers/places.dart';
import '../widgets/image_input.dart';

class AddPlacePage extends StatefulWidget {
  static const route = "/addPlace";

  const AddPlacePage({Key? key}) : super(key: key);

  @override
  State<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  final _formKey = GlobalKey<FormState>();

  XFile? _image;
  String? _title;

  bool _imageInputError = false;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    Future<File> _saveImage() async {
      final filename = path.basename(_image!.path);

      final appDocs = await getApplicationDocumentsDirectory();
      return await File(_image!.path).copy(
        path.join(appDocs.path, filename),
      );
    }

    Future<void> _submit() async {
      final form = _formKey.currentState;

      setState(() => _imageInputError = (_image == null));

      if (!form!.validate() || _imageInputError) {
        _autoValidate = true;
        return;
      }

      final image = await _saveImage();

      form.save();

      Places.of(context).addPlace(
        title: _title!,
        image: image,
      );

      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a New Place"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Form(
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Title"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "A title is required";
                        }
                      },
                      onSaved: (value) => _title = value,
                    ),
                    ImageInput(
                      onCapture: (image) => setState(() {
                        _image = image;
                        _imageInputError = false;
                      }),
                      onDelete: () => setState(() {
                        _image = null;
                        _imageInputError = false;
                      }),
                      inErrorState: _imageInputError,
                    ),
                  ],
                ),
              ),
            ),
          ),
          TextButton.icon(
            icon: Icon(
              Icons.add,
              color: colors.onSecondary,
            ),
            label: Text("Add Place",
                style: TextStyle(
                  color: colors.onSecondary,
                )),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                const Size.fromHeight(60),
              ),
              backgroundColor: MaterialStateProperty.all(
                colors.secondary,
              ),
              elevation: MaterialStateProperty.all(
                0,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}

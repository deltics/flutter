import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:places/helpers/google_maps.dart';

import '../data/models/location.dart';
import '../data/providers/places.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

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
  Location? _location;
  String? _address;
  final List<String> _addresses = [];
  final _addressController = TextEditingController();

  bool _imageInputError = false;
  bool _locationInputError = false;
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

      if ((_image == null && !_imageInputError) ||
          (_location == null && !_locationInputError)) {
        setState(() {
          _imageInputError = (_image == null);
          _locationInputError = (_location == null);
        });
      }

      if (!form!.validate() || _imageInputError || _locationInputError) {
        _autoValidate = true;
        return;
      }

      final image = await _saveImage();

      form.save();

      Places.of(context).addPlace(
          title: _title!,
          image: image,
          location: _location!,
          address: _address);

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
              padding: const EdgeInsets.all(10),
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
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
                    LocationInput(
                      inErrorState: _locationInputError,
                      onLocationChanged: (location) async {
                        if (!mounted) {
                          return;
                        }

                        _location = location;
                        _addresses.clear();
                        if (_locationInputError && (_location != null)) {
                          _locationInputError = false;
                        }

                        if (location == null) {
                          setState(() {});
                          return;
                        }

                        final addresses =
                            await GoogleMaps.getAddresses(location: location);

                        if (!mounted) {
                          setState(() {
                            _location = location;
                            _addresses.addAll(addresses);
                          });
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: _addresses.isEmpty
                              ? "Enter address"
                              : "Enter address or choose from list below"),
                      onSaved: (value) => _address = value,
                      controller: _addressController,
                    ),
                    if (_addresses.isNotEmpty) const SizedBox(height: 10),
                    if (_addresses.isNotEmpty)
                      SizedBox(
                        height: 200,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _addresses
                                .map(
                                  (address) => Container(
                                    width: double.infinity,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200),
                                    child: GestureDetector(
                                      child: Text(
                                        address,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blueGrey.shade700,
                                        ),
                                      ),
                                      onTap: () => setState(() =>
                                          _addressController.text = address),
                                    ),
                                    padding: const EdgeInsets.only(
                                      left: 24,
                                      top: 8,
                                      bottom: 8,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
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

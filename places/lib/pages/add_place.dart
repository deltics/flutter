import 'package:flutter/material.dart';

import '../widgets/image_input.dart';

class AddPlacePage extends StatelessWidget {
  static const route = "/addPlace";

  AddPlacePage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

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
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Title"),
                      validator: (value) {},
                      onSaved: (value) {},
                    ),
                    const ImageInput(),
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

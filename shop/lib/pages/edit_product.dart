import 'package:flutter/material.dart';
import 'package:shop/adapters/platform_page.dart';

class EditProductPage extends StatefulWidget {
  static const route = "/edit_product";

  const EditProductPage({Key? key}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformPage(
      title: "Edit Product",
      content: Form(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Title"),
                  textInputAction: TextInputAction.next,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

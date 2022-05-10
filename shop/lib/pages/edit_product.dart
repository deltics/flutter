import 'package:flutter/material.dart';
import 'package:shop/adapters/platform_page.dart';

class EditProductPage extends StatefulWidget {
  static const route = "/edit_product";

  const EditProductPage({Key? key}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  @override
  void dispose() {
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

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
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Price"),
                  textInputAction: TextInputAction.next,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  focusNode: _priceFocus,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_descriptionFocus),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Description"),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descriptionFocus,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
  final _imageUrlFocus = FocusNode();
  final _imageUrlInputController = TextEditingController();

  void _updateImage() {
    setState(() {});
  }

  @override
  void initState() {
    _imageUrlFocus.addListener(_updateImage);

    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocus.removeListener(_updateImage);

    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlInputController.dispose();

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
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_imageUrlFocus),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.blueGrey,
                        ),
                      ),
                      child: _imageUrlInputController.text.isEmpty
                          ? Center(
                              child: Text(
                              "enter a url",
                              style: TextStyle(color: Colors.grey.shade400),
                            ))
                          : FittedBox(
                              fit: BoxFit.contain,
                              child: Image.network(
                                _imageUrlInputController.text,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Image URL",
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageUrlFocus,
                        controller: _imageUrlInputController,
                        onEditingComplete: _updateImage,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

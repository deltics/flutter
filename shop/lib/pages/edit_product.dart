import 'package:flutter/material.dart';
import 'package:shop/utils.dart';

import '../adapters/platform_page.dart';
import '../models/product.dart';
import '../models/products.dart';

class EditProductPage extends StatefulWidget {
  static const route = "/edit_product";

  const EditProductPage({Key? key}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  static const newProductId = "";

  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlInputController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _imageUrlKey = GlobalKey<FormFieldState>();
  var _product = Product.createNew();
  var _imageUrl = "";
  var _productId = newProductId;

  void _updateImage() {
    _imageUrlKey.currentState?.validate();

    setState(() {
      if (_urlValidator(_imageUrlInputController.text) == null) {
        _imageUrl = _imageUrlInputController.text;
      } else {
        _imageUrl = "";
      }
    });
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

  String? _urlValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a Url";
    }
    if (!value.startsWith("http:") && !value.startsWith("https:")) {
      return "Please enter a valid Url";
    }
    if (!value.endsWith(".jpg") &&
        !value.endsWith(".jpeg") &&
        !value.endsWith(".png")) {
      return "Please enter a valid image Url";
    }
    return null;
  }

  void _saveProduct(BuildContext context) {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState?.save();

    if (_productId == newProductId) {
      Products.of(context).add(_product);
    } else {
      Products.of(context).update(id: _productId, using: _product);
    }

    Navigator.of(context).pop;
  }

  @override
  Widget build(BuildContext context) {
    _productId = routeArguments(context)["id"] ?? newProductId;

    if (_productId != newProductId) {
      _product = Products.of(context, listen: false).byId(_productId)!.clone();
      _imageUrl = _product.imageUrl;
      _imageUrlInputController.text = _imageUrl;
    }

    return PlatformPage(
      title: "Edit Product",
      actions: [
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () => _saveProduct(context),
        ),
      ],
      content: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _product.title,
                  decoration: const InputDecoration(labelText: "Title"),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a Title";
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  onSaved: (value) =>
                      _product = _product.withValues(title: value!),
                ),
                TextFormField(
                  initialValue: _product.price.toStringAsFixed(2),
                  decoration: const InputDecoration(labelText: "Price"),
                  textInputAction: TextInputAction.next,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  focusNode: _priceFocus,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a Price";
                    }
                    var d = double.tryParse(value);
                    if (d == null) {
                      return "Please enter a valid number";
                    }
                    if (d <= 0) {
                      return "Price must be > 0.00";
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_descriptionFocus),
                  onSaved: (value) => _product =
                      _product.withValues(price: double.parse(value!)),
                ),
                TextFormField(
                  initialValue: _product.description,
                  decoration: const InputDecoration(labelText: "Description"),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descriptionFocus,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a Description";
                    }
                    if (value.length < 10) {
                      return "Description must be at least 10 characters";
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_imageUrlFocus),
                  onSaved: (value) =>
                      _product = _product.withValues(description: value!),
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
                              child: _imageUrl.isEmpty
                                  ? null
                                  : Image.network(
                                      _imageUrl,
                                    ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        key: _imageUrlKey,
                        decoration: const InputDecoration(
                          labelText: "Image URL",
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageUrlFocus,
                        validator: _urlValidator,
                        controller: _imageUrlInputController,
                        onEditingComplete: _updateImage,
                        onFieldSubmitted: (_) => _saveProduct(context),
                        onSaved: (value) =>
                            _product = _product.withValues(imageUrl: value!),
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

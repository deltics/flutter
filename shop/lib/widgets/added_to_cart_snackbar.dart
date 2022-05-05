import 'package:flutter/material.dart';

class AddedToCartSnackBar {
  static SnackBar build({
    required BuildContext context,
    required Function action,
  }) {
    return SnackBar(
      content: const Text("Added to cart"),
      action: SnackBarAction(
        textColor: Theme.of(context).colorScheme.secondary,
        label: "UNDO",
        onPressed: () => action(),
      ),
      duration: const Duration(milliseconds: 2000),
    );
  }
}

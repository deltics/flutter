import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites with ChangeNotifier {
  final List<String> _ids = [];

  bool isFavorite(String id) {
    return _ids.contains(id);
  }

  List<String> get ids {
    return [..._ids];
  }

  void setFavorite({
    required String id,
    required bool isFavorite,
  }) {
    if (isFavorite) {
      if (!_ids.contains(id)) {
        _ids.add(id);
      }
    } else if (_ids.contains(id)) {
      _ids.remove(id);
    }
    notifyListeners();
  }

  static Favorites of(BuildContext context, {bool listen = true}) {
    return Provider.of<Favorites>(
      context,
      listen: listen,
    );
  }
}

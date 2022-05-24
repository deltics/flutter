import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../firebase.dart';
import '../utils.dart';

enum _FavoriteAction { add, remove, doNothing }

class Favorites with ChangeNotifier {
  final List<String> _ids = [];

  List<String> get ids {
    return [..._ids];
  }

  Future<void> fetch(BuildContext context) async {
    _ids.clear();

    try {
      final uri = await firebaseUri(context, "favorites.json");
      final response = await http.get(uri);

      final data = okJsonResponse(response);
      if (data == null) {
        return;
      }

      data.forEach((id, _) => _ids.add(id));

      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  bool isFavorite(String id) {
    return _ids.contains(id);
  }

  Future<void> setFavorite(
    BuildContext context, {
    required String id,
    required bool isFavorite,
  }) async {
    var action = _FavoriteAction.doNothing;

    if (isFavorite) {
      if (!_ids.contains(id)) {
        action = _FavoriteAction.add;
      }
    } else if (_ids.contains(id)) {
      action = _FavoriteAction.remove;
    }
    final uri = await firebaseUri(context, "favorites/$id.json");
    final response = (action == _FavoriteAction.add)
        ? await http.put(uri, body: "true")
        : await http.delete(uri);

    if (isOk(response)) {
      (action == _FavoriteAction.add) ? _ids.add(id) : _ids.remove(id);
      notifyListeners();
    }
  }

  static Favorites of(BuildContext context, {bool listen = true}) {
    return Provider.of<Favorites>(
      context,
      listen: listen,
    );
  }
}

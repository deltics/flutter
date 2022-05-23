import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Auth with ChangeNotifier {
  static const _apiKey = "AIzaSyAZWCHFpeOW75uff9-AoD44B1GD3CB1C7c";

  var _refreshToken = "";
  var _token = "";
  var _tokenExpires = DateTime.now();
  var _userEmail = "";
  var _userId = "";

  static Auth of(BuildContext context, {bool listen = true}) {
    return Provider.of<Auth>(context, listen: listen);
  }

  bool get isSignedIn => _userId.isNotEmpty;
  String get token => _token;
  bool get tokenExpired =>
      DateTime.now().add(const Duration(seconds: 5)).isAfter(_tokenExpires);

  Future<void> signIn({
    required String email,
    required String password,
    bool newUser = false,
  }) async {
    final uri = Uri.https(
      "identitytoolkit.googleapis.com",
      newUser ? "v1/accounts:signUp" : "v1/accounts:signInWithPassword",
      {"key": _apiKey},
    );

    try {
      final response = await http.post(
        uri,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );

      if (response.statusCode != HttpStatus.ok) {
        try {
          print(jsonDecode(response.body));
        } catch (_) {
          print(response.body);
        }
        throw response.body.toString();
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      _refreshToken = data["refreshToken"];
      _token = data["idToken"];
      _tokenExpires = DateTime.now().add(
        Duration(
          seconds: int.parse(data["expiresIn"]),
        ),
      );
      _userEmail = data["email"];
      _userId = data["localId"];
    } catch (error) {
      print(error);
    }
  }
}

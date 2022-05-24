import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

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

  bool get isSignedIn => _token.isNotEmpty;
  bool get _tokenExpired =>
      DateTime.now().add(const Duration(seconds: 5)).isAfter(_tokenExpires);

  Future<String> get token async {
    if (_tokenExpired) {
      await _getFreshToken();
    }
    return _token;
  }

  Future<void> _getFreshToken() async {
    final uri =
        Uri.https("securetoken.googleapis.com", "v1/token", {"key": _apiKey});
    final response = await http.post(uri,
        body: jsonEncode({
          "grant_type": "refresh_token",
          "refresh_token": _refreshToken,
        }));

    final result = okJsonResponse(response)!;

    _token = result["id_token"];
    _refreshToken = result["refresh_token"];
    _tokenExpires = DateTime.now().add(
      Duration(
        seconds: int.parse(result["expires_in"]),
      ),
    );
    print(
        "refreshed token expires @ ${DateFormat("hh:mm:ss").format(_tokenExpires)}");
  }

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

      final data = okJsonResponse(response, onError: (statusCode, body) {
        if (body.contains("EMAIL_EXISTS")) {
          return AuthException("Email already registered.");
        }
        if (body.contains("WEAK_PASSWORD")) {
          return AuthException("Stronger password required.");
        }
        if (body.contains("INVALID_PASSWORD")) {
          return AuthException("The email or password is not correct.");
        }

        var error = (jsonDecode(body) as Map<String, dynamic>)["error"]
            as Map<String, dynamic>;
        if (error.containsKey("message")) {
          return AuthException(error["message"]);
        }
      })!;

      _refreshToken = data["refreshToken"];
      _token = data["idToken"];
      _tokenExpires = DateTime.now().add(
        Duration(
          seconds: int.parse(data["expiresIn"]),
        ),
      );
      _userEmail = data["email"];
      _userId = data["localId"];

      print(
          "initial token expires @ ${DateFormat("hh:mm:ss").format(_tokenExpires)}");
    } catch (error) {
      print(error);
      throw error;
    }
  }
}

class AuthException {
  final String message;

  AuthException(this.message);

  @override
  String toString() => "AuthException: $message";
}

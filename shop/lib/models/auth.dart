import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home.dart';
import '../utils.dart';
import 'cart.dart';
import 'favorites.dart';
import 'orders.dart';
import 'products.dart';

class Auth with ChangeNotifier {
  static const _apiKey = "AIzaSyAZWCHFpeOW75uff9-AoD44B1GD3CB1C7c";

  var _refreshToken = "";
  var _token = "";
  var _tokenExpires = DateTime.now();
  var _userId = "";
  // var _userEmail = "";

  static Auth of(BuildContext context, {bool listen = true}) {
    return Provider.of<Auth>(context, listen: listen);
  }

  bool get _tokenExpired =>
      DateTime.now().add(const Duration(seconds: 5)).isAfter(_tokenExpires);

  Future<String> get token async {
    if (_tokenExpired) {
      await _getFreshToken();
    }
    return _token;
  }

  bool get isSignedIn => _token.isNotEmpty;

  String get userId => _userId;

  Future<void> _getFreshToken() async {
    final uri = Uri.https(
      "securetoken.googleapis.com",
      "v1/token",
      {"key": _apiKey},
    );

    final result = okJsonResponse(await http.post(uri,
        body: jsonEncode({
          "grant_type": "refresh_token",
          "refresh_token": _refreshToken,
        })))!;

    _refreshToken = result["refresh_token"];
    _token = result["id_token"];
    _tokenExpires = DateTime.now().add(
      Duration(
        seconds: int.parse(result["expires_in"]),
      ),
    );
    _userId = result["user_id"];
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

        return null;
      })!;

      _refreshToken = data["refreshToken"];
      _token = data["idToken"];
      _tokenExpires = DateTime.now().add(
        Duration(
          seconds: int.parse(data["expiresIn"]),
        ),
      );
      _userId = data["localId"];

      final prefs = await SharedPreferences.getInstance();
      prefs.setString(
        "auth",
        jsonEncode({
          "refreshToken": _refreshToken,
          "token": _token,
          "tokenExpires": _tokenExpires.toIso8601String(),
          "userId": _userId,
        }),
      );

      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }

      rethrow;
    }
  }

  Future<void> signOut(BuildContext context) async {
    _refreshToken = "";
    _token = "";
    _tokenExpires = DateTime.now();
    _userId = "";

    Cart.of(context, listen: false).clear();
    Products.of(context, listen: false).reset();
    Favorites.of(context, listen: false)?.reset();
    Orders.of(context, listen: false)?.reset();

    Navigator.of(context).pushNamedAndRemoveUntil(HomePage.route, (_) => false);

    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("auth")) {
      prefs.remove("auth");
    }

    notifyListeners();
  }

  Future<bool> tryAutoSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("auth")) {
      return false;
    }

    final authJson = prefs.getString("auth");

    final auth = jsonDecode(authJson!) as Map<String, dynamic>;

    _refreshToken = auth["refreshToken"];
    _token = auth["token"];
    _tokenExpires = DateTime.parse(auth["tokenExpires"]);
    _userId = auth["userId"];

    if (_tokenExpired) {
      await _getFreshToken();
    }

    notifyListeners();

    return isSignedIn;
  }
}

class AuthException {
  final String message;

  AuthException(this.message);

  @override
  String toString() => "AuthException: $message";
}

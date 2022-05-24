import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

Map<String, String>? routeArguments(BuildContext context) {
  return ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
}

Map<String, dynamic>? okJsonResponse(
  Response response, {
  Object? Function(int, String)? onError,
}) {
  if (response.statusCode == HttpStatus.ok) {
    return jsonDecode(response.body) as Map<String, dynamic>?;
  }

  if (onError != null) {
    final exception = onError(response.statusCode, response.body);
    if (exception != null) {
      throw exception;
    }
  }

  try {
    print("response body (json): ${jsonDecode(response.body)}");
  } catch (_) {
    print("response body (string): ${response.body}");
  }
  throw HttpException(
      "Unexpected (${response.statusCode}) response: ${response.body}");
}

bool isOk(Response response) {
  if (response.statusCode == HttpStatus.ok) {
    return true;
  }

  try {
    print("response body (json): ${jsonDecode(response.body)}");
  } catch (_) {
    print("response body (string): ${response.body}");
  }
  throw HttpException(
      "unexpected (${response.statusCode}) response: ${response.body}");
}

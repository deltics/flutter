import 'package:flutter/material.dart';

import 'models/auth.dart';

const _baseUrl =
    "udemy-shop-fb-default-rtdb.asia-southeast1.firebasedatabase.app";

Uri firebaseUri(BuildContext context, String resource) {
  final token = Auth.of(context, listen: false).token;
  return Uri.https(_baseUrl, resource, {"auth": token});
}

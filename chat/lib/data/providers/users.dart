import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Users with ChangeNotifier {
  static Users of(BuildContext context) =>
      Provider.of<Users>(context, listen: false);

  final Map<String, String> _usernames = {};

  Future<String> getName({required String uid}) async {
    if (_usernames.containsKey(uid)) {
      return Future.delayed(Duration.zero, () => _usernames[uid]!);
    }

    final user =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    final username = user["username"];

    _usernames[uid] = username;

    return Future.delayed(Duration(milliseconds: 1500), () => username);
    // return username;
  }
}

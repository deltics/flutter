import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_profile.dart';

class Users with ChangeNotifier {
  static Users of(BuildContext context) =>
      Provider.of<Users>(context, listen: false);

  static final _unknownUser = UserProfile(username: "unknown", picture: null);

  final Map<String, UserProfile> _profiles = {};

  Future<UserProfile> getById(String uid) async {
    if (_profiles.containsKey(uid)) {
      return Future.delayed(Duration.zero, () => _profiles[uid]!);
    }

    final ref = FirebaseFirestore.instance.collection('users').doc(uid);
    final user = await ref.get();

    final profile = user.exists
        ? UserProfile(
            username: user["username"],
            picture: (user["imageUrl"] != null)
                ? Image.network(user["imageUrl"])
                : null)
        : _unknownUser;

    _profiles[uid] = profile;

    return profile;
  }
}

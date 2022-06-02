import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';

class AuthPage extends StatelessWidget {
  static const route = "/auth";

  const AuthPage({Key? key}) : super(key: key);

  Future<void> _submit({
    required BuildContext context,
    required String email,
    required String password,
    required bool createUser,
    String? username,
  }) async {
    final auth = createUser
        ? FirebaseAuth.instance.createUserWithEmailAndPassword
        : FirebaseAuth.instance.signInWithEmailAndPassword;

    try {
      final creds = await auth(
        email: email,
        password: password,
      );

      if (createUser) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(creds.user!.uid)
            .set({"email": email, "username": username});
      }
    } on FirebaseAuthException catch (error) {
      final message = error.message ?? "An unexpected error occured";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: AuthForm(onSubmit: _submit),
    );
  }
}

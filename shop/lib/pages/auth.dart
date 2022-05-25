import 'dart:math';

import 'package:flutter/material.dart';

import '../models/auth.dart';

enum AuthMode {
  signup,
  login,
}

class AuthPage extends StatelessWidget {
  static const route = "/auth";

  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  const Color.fromRGBO(255, 188, 217, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              width: device.width,
              height: device.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 56,
                        vertical: 8,
                      ),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: const Text(
                        "40thieves",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: device.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _Credentials {
  String? email;
  String? password;
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  static const Map<AuthMode, String> formActionLabel = {
    AuthMode.signup: "SIGN UP",
    AuthMode.login: "LOGIN",
  };
  static const Map<AuthMode, String> toggleActionLabel = {
    AuthMode.signup: "Login instead",
    AuthMode.login: "Sign-Up instead",
  };

  final _formKey = GlobalKey<FormState>();
  final _credentials = _Credentials();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _passwordController.dispose();
    //_modeAnimationController?.dispose();
  }

  // Animation scaffolding not required when using AnimatedContainer()...

  // Animation<Size>? _modeAnimation;
  // AnimationController? _modeAnimationController;

  // @override
  // void initState() {
  //   super.initState();

  //   _setupAnimation();
  // }

  // void _setupAnimation() {
  //   _modeAnimationController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 300),
  //   );

  //   _modeAnimation = Tween<Size>(
  //     begin: const Size(
  //       double.infinity,
  //       260,
  //     ),
  //     end: const Size(
  //       double.infinity,
  //       320,
  //     ),
  //   ).animate(CurvedAnimation(
  //     parent: _modeAnimationController!,
  //     curve: Curves.linear,
  //   ));
  // }

  var _isSigningIn = false;
  var _mode = AuthMode.login;

  void _showError(BuildContext context, String message) {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Authentication Error"),
        content: Text(message),
        actions: [
          TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(colorScheme.primaryContainer),
                foregroundColor:
                    MaterialStateProperty.all(colorScheme.onPrimary),
              ),
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop()),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final form = _formKey.currentState!;

    if (!form.validate()) {
      return;
    }

    form.save();

    final auth = Auth.of(context, listen: false);
    try {
      setState(() => _isSigningIn = true);
      await auth.signIn(
          email: _credentials.email!,
          password: _credentials.password!,
          newUser: _mode == AuthMode.signup);
      setState(() => _isSigningIn = false);
    } on AuthException catch (error) {
      _showError(context, error.message);
    }
  }

  void _changeMode() {
    // _mode == AuthMode.login
    //     ? _modeAnimationController!.forward()
    //     : _modeAnimationController!.reverse();

    setState(() =>
        _mode = _mode == AuthMode.login ? AuthMode.signup : AuthMode.login);
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 8,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 175),
            height: _mode == AuthMode.signup ? 320 : 260,
            width: device.width * .75,
            constraints: BoxConstraints(
              minHeight: _mode == AuthMode.signup ? 320 : 260,
            ),
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                        decoration: const InputDecoration(labelText: "email"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !(value.contains(".") && value.contains("@"))) {
                            return "Please enter a valid email address";
                          }
                        },
                        onSaved: (value) {
                          _credentials.email = value ?? "";
                        }),
                    TextFormField(
                        decoration:
                            const InputDecoration(labelText: "password"),
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.length < 5) {
                            return "Password must be at least 6 characters";
                          }
                        },
                        onSaved: (value) {
                          _credentials.password = value ?? "";
                        }),
                    if (_mode == AuthMode.signup)
                      TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Confirm password"),
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value != _passwordController.text) {
                              return "Passwords are not the same";
                            }
                          },
                          onSaved: (value) {
                            _credentials.password = value ?? "";
                          }),
                    const SizedBox(height: 20),
                    _isSigningIn
                        ? SizedBox(
                            width: device.width / 3,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  colorScheme.primary),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            child: SizedBox(
                              width: device.width / 3,
                              child: Center(
                                child: Text(
                                  formActionLabel[_mode]!,
                                  style: TextStyle(
                                      color: colorScheme.onPrimaryContainer),
                                ),
                              ),
                            ),
                            onPressed: _submit,
                          ),
                    TextButton(
                      child: Text(
                        toggleActionLabel[_mode]!,
                        style: TextStyle(color: colorScheme.primary),
                      ),
                      onPressed: _changeMode,
                    ),
                  ],
                ),
              ),
            )));
  }
}

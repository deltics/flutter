import 'package:flutter/material.dart';

enum AuthMode { signIn, signUp }

class AuthForm extends StatefulWidget {
  final Future<void> Function({
    required BuildContext context,
    required String email,
    required String password,
    required bool createUser,
    String? username,
  }) onSubmit;

  const AuthForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  var _mode = AuthMode.signIn;
  var _isSubmitting = false;

  String? _email;
  String? _username;
  String? _password;

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email address is required";
    }

    if (!value.contains('.') || !value.contains('@')) {
      return "Please enter a valid email address";
    }

    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 7) {
      return "Password must be a minimum of 7 characters";
    }

    return null;
  }

  String? _usernameValidator(String? value) {
    if (_mode == AuthMode.signIn) {
      return null;
    }

    if (value == null || value.isEmpty) {
      return "Username is required";
    }

    if (value.length < 5) {
      return _mode == AuthMode.signIn
          ? "Reminder: Your username is at least 5 characters"
          : "Username must be a minimum of 5 characters";
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (_mode == AuthMode.signIn) {
      return null;
    }

    if (value == null || value.isEmpty) {
      return "Confirm your password";
    }

    if (value != _passwordController.text) {
      return "Passwords do not match";
    }

    return null;
  }

  void _submit(BuildContext context) async {
    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      return;
    }

    form.save();

    setState(() => _isSubmitting = true);
    try {
      await widget.onSubmit(
        context: context,
        email: _email!,
        password: _password!,
        createUser: _mode == AuthMode.signUp,
        username: _mode == AuthMode.signUp ? _username : null,
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  void _toggleMode() {
    _confirmPasswordController.text = "";

    setState(() {
      _mode = _mode == AuthMode.signIn ? AuthMode.signUp : AuthMode.signIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "email",
                      labelStyle: TextStyle(
                        color: Colors.blueGrey.shade300,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: _emailValidator,
                    onSaved: (value) => _email = value,
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _mode == AuthMode.signIn ? 0 : 1,
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      child: SizedBox(
                        height: _mode == AuthMode.signIn ? 0 : null,
                        child: TextFormField(
                          enabled: _mode == AuthMode.signUp,
                          decoration: InputDecoration(
                            labelText: "username",
                            labelStyle: TextStyle(
                              color: Colors.blueGrey.shade300,
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          validator: _usernameValidator,
                          onSaved: (value) => _username = value,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "password",
                      labelStyle: TextStyle(
                        color: Colors.blueGrey.shade300,
                      ),
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: _passwordController,
                    validator: _passwordValidator,
                    onSaved: (value) {
                      if (_mode == AuthMode.signIn) {
                        _password = value;
                      }
                    },
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _mode == AuthMode.signIn ? 0 : 1,
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      child: SizedBox(
                        height: _mode == AuthMode.signIn ? 0 : null,
                        child: TextFormField(
                          enabled: _mode == AuthMode.signUp,
                          decoration: InputDecoration(
                            labelText: "confirm password",
                            labelStyle: TextStyle(
                              color: Colors.blueGrey.shade300,
                            ),
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          controller: _confirmPasswordController,
                          validator: _confirmPasswordValidator,
                          onSaved: (value) {
                            if (_mode == AuthMode.signUp) {
                              _password = value;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primary),
                      ),
                      child: _isSubmitting
                          ? Center(
                              child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            ))
                          : Text(
                              _mode == AuthMode.signIn
                                  ? "Login"
                                  : "Create Account",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      onPressed: () => _submit(context),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                    // ignore: sort_child_properties_last
                    child: Text(
                      _isSubmitting
                          ? "Please wait..."
                          : _mode == AuthMode.signIn
                              ? "Create New Account"
                              : "Login with Existing Account",
                    ),
                    onPressed: _isSubmitting ? null : _toggleMode,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:ecommerce/pages/widgets/custom_button.dart';
import 'package:ecommerce/provider/user_provider.dart';
import 'package:ecommerce/util/adaptive_spacing.dart';
import 'package:ecommerce/util/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:ecommerce/services/auth_service.dart';
import 'package:ecommerce/provider/auth_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.systemScaffoldColor,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'e-Shop',
            style: TextStyle(
                color: ColorConstants.systemBlue, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'Please enter a password with at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40.h),
              CustomAuthButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await authProvider.loginWithEmail(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );
                    if (authProvider.errorMessage != null) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            authProvider.errorMessage!,
                          ),
                        ),
                      );
                    } else {
                      Provider.of<UserProvider>(context, listen: false)
                          .fetchUser();
                      Navigator.pushNamed(context, '/product');
                    }
                  }
                },
                text: 'Login',
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New here?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: const Text('Signup'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

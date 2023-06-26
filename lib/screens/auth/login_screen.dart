import 'package:flutter/material.dart';
import 'package:test_app/services/repositories/auth_repository.dart';
import 'package:test_app/widgets/button_widget.dart';
import 'package:test_app/widgets/text_widget.dart';
import 'package:test_app/widgets/textfield_widget.dart';

import '../../utils/routes.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: TextWidget(label: 'Login Screen', fontsize: 50),
            ),
            const SizedBox(
              height: 50,
            ),
            TextfieldWidget(
                textfieldController: emailController,
                icon: Icons.email,
                label: 'Email'),
            const SizedBox(
              height: 10,
            ),
            TextfieldWidget(
                isObscure: true,
                textfieldController: passwordController,
                icon: Icons.password,
                label: 'Password'),
            const SizedBox(
              height: 50,
            ),
            ButtonWidget(
              onPressed: () {
                _auth(context);
              },
              label: 'Login',
            ),
          ],
        ),
      ),
    );
  }

  void _auth(context) {
    AuthRepository()
        .loginFunction(emailController.text, passwordController.text)
        .then((value) {
      if (value == 200) {
        Navigator.pushReplacementNamed(context, Routes().homescreen);
      } else {
        print(value);
      }
    });
  }
}

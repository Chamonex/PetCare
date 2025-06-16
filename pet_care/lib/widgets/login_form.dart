import 'package:flutter/material.dart';
import 'app_button.dart';
import 'app_text_field.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;
  final VoidCallback changeToRegister;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    required this.changeToRegister,
  });

  @override
  Widget build(BuildContext context) {

    return Form(
      child: Column(
        children: [
          const SizedBox(height: 48),
          AppTextField(
            controller: emailController,
            label: 'email',
            hint: 'Enter your username',
          ),
          const SizedBox(height: 24),
          AppTextField(
            controller: passwordController,
            label: 'password',
            hint: 'Enter your password',
            obscureText: true,
          ),
          const SizedBox(height: 48),
          AppButton(label: 'Login', onPressed: onSubmit),
          const SizedBox(height: 24),
          AppButton(label: 'Register', onPressed: changeToRegister),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'app_button.dart';
import 'app_text_field.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController nameController;
  final VoidCallback onSubmit;

  const RegisterForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          AppTextField(
            controller: emailController,
            label: 'email',
            hint: 'Enter your username',
          ),
          AppTextField(
            controller: passwordController,
            label: 'password',
            hint: 'Enter your password',
            obscureText: true,
          ),
          AppTextField(
            controller: confirmPasswordController,
            label: 'confirm password',
            hint: 'confirm your password',
            obscureText: true,
          ),
          AppTextField(
            controller: nameController,
            label: 'name',
            hint: 'Enter your name',
          ),
          const SizedBox(height: 24),
          AppButton(label: 'Register', onPressed: onSubmit),
        ],
      ),
    );
  }
}

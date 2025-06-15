import 'package:flutter/material.dart';
import 'app_button.dart';
import 'app_text_field.dart';
import '../utils/app_utils.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController nameController;
  final VoidCallback onSubmit;
  final VoidCallback onBackToLogin;

  const RegisterForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameController,
    required this.onSubmit,
    required this.onBackToLogin,
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
          const SizedBox(height: 48),
          AppButton(
            label: 'Voltar',
            icon: Icons.login,
            onPressed: onBackToLogin,
            filled: false,
            color: Colors.red,
            width: 120,
            height: 48,
          ),
        ],
      ),
    );
  }
}

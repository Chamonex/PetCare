import 'package:flutter/material.dart';

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
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'email',
              hintText: 'Enter your username',
            ),
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'password',
              hintText: 'Enter your password',
            ),
            obscureText: true,
          ),
          TextFormField(
            controller: confirmPasswordController,
            decoration: const InputDecoration(
              labelText: 'confirm password',
              hintText: 'confirm your password',
            ),
            obscureText: true,
          ),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'name',
              hintText: 'Enter your name',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onSubmit,
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}

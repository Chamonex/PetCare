import 'package:flutter/material.dart';

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
          const SizedBox(height: 24),
          ElevatedButton(onPressed: onSubmit, child: const Text('Login')),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: changeToRegister, child: const Text('Register')),
        
        ],
      ),
    );
  }
}

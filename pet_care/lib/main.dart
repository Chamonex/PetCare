import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/login_form.dart';
import 'widgets/register_form.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Care',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      ),
      routes: {
        '/home': (context) => const HomePage(),
      },
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _showRegisterForm = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      debugPrint('Current emailss: ${_emailController.text}');
    });
    _passwordController.addListener(() {
      debugPrint('Current passwordss: ${_passwordController.text}');
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changeToRegister() {
    setState(() {
      _showRegisterForm = !_showRegisterForm;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void _submitRegister() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    
    if (password != confirmPassword) {
      debugPrint('Passwords do not match');
      return;
    }
    
    final response = await http.post(
      Uri.parse('http://localhost:3000/register'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'}, // importante para API REST
    );

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        debugPrint('Response data: $data');
      } catch (e) {
        debugPrint('Erro ao decodificar JSON: $e');
      }
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      debugPrint('Corpo da resposta: ${response.body}');
    }

    setState(() {
      _showRegisterForm = false;
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    });
  }

  void _submitLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://localhost:3000/login'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'}, // importante para API REST
    );

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        debugPrint('Response data: $data');
        Navigator.of(context).pushReplacementNamed('/home');
      } catch (e) {
        debugPrint('Erro ao decodificar JSON: $e');
      }
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      debugPrint('Corpo da resposta: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_showRegisterForm)
              RegisterForm(
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                onSubmit: _submitRegister,
              )
            else
              LoginForm(
                emailController: _emailController,
                passwordController: _passwordController,
                onSubmit: _submitLogin,
                changeToRegister: _changeToRegister,
              ),
          ],
        ),
      ),
    );
  }
}

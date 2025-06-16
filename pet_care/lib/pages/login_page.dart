import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care/utils/app_utils.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

import '../widgets/login_form.dart';
import '../widgets/register_form.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

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
  final TextEditingController _nameController = TextEditingController();
  bool _showRegisterForm = false;

  Color errorColor = Colors.red;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      debugPrint('Current email: ${_emailController.text}');
    });
    _passwordController.addListener(() {
      debugPrint('Current passwords: ${_passwordController.text}');
    });
    _confirmPasswordController.addListener(() {
      debugPrint(
        'Current confirm passwords: ${_confirmPasswordController.text}',
      );
    });
    _nameController.addListener(() {
      debugPrint('Current name: ${_nameController.text}');
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _changeToRegister() {

    setState(() {
      _showRegisterForm = true;
      _hasError = false;
      _errorMessage = '';
    });
    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
  }

  void _changeToLogin() {
    setState(() {
      _showRegisterForm = false;
      _hasError = false;
      _errorMessage = '';
    });
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _nameController.clear();
  }

  void makeError(String message) {
    setState(() {
      _hasError = true;
      _errorMessage = message;
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      _nameController.clear();
    });
  }

  void _submitRegister() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final name = _nameController.text;

    if (password != confirmPassword) {
      // As senhas não coincidem
      makeError('As senhas não coincidem');
      return;
    }
    if (name.isEmpty) {
      makeError('Nome não pode estar vazio');
      return;
    }
    final response = await http.post(
      Uri.parse('http://localhost:3000/register'),
      body: jsonEncode({'email': email, 'password': password, 'name': name}),
      headers: {'Content-Type': 'application/json'}, // importante para API REST
    );

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        debugPrint('Usuário registrado com sucesso: $data');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário criado com sucesso!')),
        );
      } catch (e) {
        debugPrint(
          'Usuário registrado com sucesso, mas erro ao decodificar JSON: $e',
        );
      }
    } else {
      makeError(response.body);
      return;
    }

    setState(() {
      _showRegisterForm = false;
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      _nameController.clear();
    });
  }

  void _submitLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    bool havePets = false;
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();

    if (email.isEmpty || password.isEmpty) {
      debugPrint('Email e senha não podem estar vazios');
      makeError('Email e senha não podem estar vazios');
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost:3000/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final name = data['name'];
      havePets = data['havePets'] ?? false;
      _hasError = false;
      _errorMessage = '';
      debugPrint('Login realizado com sucesso: ${response.body}');
      
      if (havePets) {
        debugPrint('este usuário já tem pets registrados');
        changePage(context, 'home');
        
      } else {
        debugPrint('este usuário não tem pets registrados');
        changePage(context, 'registerPet');
      }

      Provider.of<UserProvider>(
        context,
        listen: false,
      ).setUser(User(email: email, name: name));
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado com sucesso!')),
      );
    } 
    
    else {
      makeError(
        'Erro ao fazer login: ${response.statusCode}\n${response.body}',
      );
      debugPrint('Erro na requisição: ${response.statusCode}');
      debugPrint('Corpo da resposta: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Login")),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              if (_hasError)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: errorColor, fontSize: 16),
                  ),
                ),
              if (_showRegisterForm)
                RegisterForm(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  nameController: _nameController,
                  onSubmit: _submitRegister,
                  onBackToLogin: _changeToLogin,
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
      ),
      
    );
  }
}

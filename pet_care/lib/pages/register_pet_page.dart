import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../widgets/app_button.dart';
import '../utils/app_utils.dart';

import '../providers/user_provider.dart';


class RegisterPetPage extends StatefulWidget {
  const RegisterPetPage({super.key});

  @override
  State<RegisterPetPage> createState() => _RegisterPetPageState();
}

class _RegisterPetPageState extends State<RegisterPetPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        timeController.text = picked.format(context);
      });
    }
  }

  Future<void> _registerPet(UserProvider userProvider) async {
    final String name = nameController.text;
    final String idade = idadeController.text;
    final String email = userProvider.user?.email ?? 'sem email';

    if (userProvider.user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário não está logado')),
      );
      return;
    }
    
    if (name.isEmpty || idade.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/registerPet'),
        body: jsonEncode({'email': email, 'name': name, 'idade': idade}),
        headers: {'Content-Type': 'application/json'},
      );

      String message;
      if (response.statusCode == 200) {
        debugPrint('SUCESSO: ${response.body}');
        final data = jsonDecode(response.body);
        message = data['message'] ?? 'Pet registrado com sucesso!';
      } else {
        debugPrint('ERRO: ${response.body}');
        message = 'Erro ao registrar pet: ${response.body}';
        debugPrint('Erro ao registrar pet: ${response.body}');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de conexão: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
  final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Registrar Pet')),
      body: Center(
        child: Column(
          children: [
            const Text(
              "Registre seu pet",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Qual o nome de seu pet?',
                        hintText: 'nome do pet',
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: idadeController,
                      decoration: const InputDecoration(
                        labelText: 'Qual a idade do seu pet?',
                        hintText: 'idade do pet',
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppButton(
                      label: 'Salvar',
                      icon: Icons.save,
                      onPressed: () {
                        _registerPet(userProvider);
                      },
                      color: Colors.green,
                      filled: false,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AppButton(
        label: 'Home',
        icon: Icons.home,
        onPressed: () => changePage(context, 'home'),
        filled: false,
        color: Colors.red,
        width: 120,
        height: 48,
      ),
    );
  }
}

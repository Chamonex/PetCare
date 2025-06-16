import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/app_button.dart';
import '../utils/app_utils.dart';
import '../models/pet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    debugPrint('HomePage initialized');
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final maxWidth = screenSize.width > 600 ? 600.0 : screenSize.width * 0.9;

    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      floatingActionButton: AppButton(
        label: 'Sair',
        icon: Icons.exit_to_app,
        filled: false,
        color: Colors.red,
        width: 120,
        height: 48,
        onPressed: () {
          debugPrint('FloatingActionButton pressed');
          userProvider.clearUser();
          changePage(context, 'login');
        },
      ),
      appBar: AppBar(
        title: Center(child: Text('Bem-vindo, ${userProvider.user?.name}')),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            children: [
              PetInfo(),
              Text(""),
              AppButton(
                label: 'Meu Pet',
                icon: Icons.pets,
                onPressed: () => {
                  debugPrint('Meu Pet button pressed'),
                },
                filled: false,
                color: Colors.green,
                width: 120,
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PetInfo extends StatelessWidget {
  const PetInfo({super.key});


  Future<Pet?> _getPets(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final email = userProvider.user?.email ?? '';
    final uri = Uri.parse(
      'http://192.168.15.101:3000/pet',
    ).replace(queryParameters: {'email': email});

    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Pet.fromJson(data['pet']);
    } else {
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pet?>(
      future: _getPets(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Erro ao carregar informações do pet');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text('Nenhuma informação do pet encontrada');
        } else {
          final pet = snapshot.data!;
          return Column(
            children: [
              const Text(
                'Informações do Pet',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text('Nome: ${pet.name}'),
              Text('Idade: ${pet.idade}'),
              Text('Tipo: ${pet.type}'),
              // Adicione mais campos conforme necessário
            ],
          );
        }
      },
    );
  }
}
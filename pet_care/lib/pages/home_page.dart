import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/app_button.dart';
import '../utils/app_utils.dart';
import '../models/pet.dart' as pet_model;
import '../pages/edit_pet_page.dart';

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

  Future<pet_model.Pet?> _getPet(BuildContext context) async {
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
      return pet_model.Pet.fromJson(data['pet']);
    } else {
      return null;
    }
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
              FutureBuilder<pet_model.Pet?>(
                future: _getPet(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Erro ao carregar informações do pet');
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('Nenhuma informação do pet encontrada');
                  } else {
                    return PetInfoBox(pet: snapshot.data!);
                  }
                },
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}


class PetInfoBox extends StatelessWidget {
  final pet_model.Pet pet;
  const PetInfoBox({super.key, required this.pet});

  // PET ATRIBUTES
  // String name;
  // String idade;
  // String type;
  // List<Tarefa>? tarefas;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pet.name,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Image.asset(
                  pet.type.toLowerCase() == 'dog'
                      ? 'assets/icons/dog.png'
                      : 'assets/icons/cat.png',
                  width: 64,
                  height: 64,
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: AppButton(
                label: 'Editar Pet',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPetPage(pet: pet),
                    ),
                  );
                },
                filled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/app_button.dart';
import '../utils/app_utils.dart';

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

  Future<void> _getPets() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final email = userProvider.user?.email ?? '';
    final uri = Uri.parse('http://localhost:3000/pet').replace(queryParameters: {'email': email});
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final data = jsonDecode(response.body);
    debugPrint('GET Pets response status: ${data['pet']['name']}');
  }
  
  @override
  Widget build(BuildContext context) {
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
        }

      ),
      appBar: AppBar(
        title: Center(child: Text('Bem-vindo, ${userProvider.user?.name}')),
      ),
      body: Center(child: Column(
        children: [
          Text(""),
          AppButton(
            label: 'Meu Pet',
            icon: Icons.pets,
            onPressed: () => _getPets(),
            filled: false,
            color: Colors.green,
            width: 120,
            height: 48,
          ),
        ],
      )),
    );
  }
}
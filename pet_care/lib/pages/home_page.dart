import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/home_button.dart';
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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FloatingActionButton pressed');    
          userProvider.clearUser();
          changePage(context, 'login');
        },
        child: const Icon(Icons.exit_to_app),
      ),
      appBar: AppBar(
        title: Center(child: Text('Bem-vindo, ${userProvider.user?.name}')),
      ),
      body: Center(child: Column(
        children: [
          HomeButton(
            icon: const Icon(Icons.home),
            onPressed: () => changePage(context, 'register_pet'),
          ),
          HomeButton(
            icon: const Icon(Icons.home),
            onPressed: () => changePage(context, 'register_pet'),
          ),
          HomeButton(
            icon: const Icon(Icons.home),
            onPressed: () => changePage(context, 'register_pet'),
          ),
        ],
      )),
    );
  }
}
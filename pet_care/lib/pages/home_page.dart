import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/home_button.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _openPage(String page) {
    debugPrint('Opening page: $page');
    Navigator.of(context).pushNamed(page);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FloatingActionButton pressed');    
          userProvider.clearUser();
          Navigator.of(context).pushReplacementNamed('/login');
        },
        child: const Icon(Icons.exit_to_app),
      ),
      appBar: AppBar(
        title: Center(child: Text('Bem-vindo, ${userProvider.user?.name}')),
      ),
      body: Center(child: Column(
        children: [
          HomeButton(icon: Icons.home, text: 'Home', onPressed: () => _openPage('/home')),
          HomeButton(icon: Icons.person, text: 'Login', onPressed: () => _openPage('/login')),
          HomeButton(icon: Icons.home, text: 'Home', onPressed: () => _openPage('/home')),
        ],
      )),
    );
  }
}
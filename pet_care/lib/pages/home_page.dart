import 'package:flutter/material.dart';
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
          AppButton(
            label: 'Home',
            icon: Icons.home,
            onPressed: () => changePage(context, 'register_pet'),
            filled: false,
            color: Colors.green,
            width: 120,
            height: 48,
          ),
          AppButton(
            label: 'Home',
            icon: Icons.home,
            onPressed: () => changePage(context, 'register_pet'),
            filled: false,
            color: Colors.green,
            width: 120,
            height: 48,
          ),
          AppButton(
            label: 'Home',
            icon: Icons.home,
            onPressed: () => changePage(context, 'register_pet'),
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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'providers/user_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Pet Care',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, dynamicSchemeVariant: DynamicSchemeVariant.vibrant),
        ),
        routes: {
          '/home': (context) => HomePage(),
          '/login': (context) => LoginPage()
        },
        home: const LoginPage(),
      ),
    );
  }
}

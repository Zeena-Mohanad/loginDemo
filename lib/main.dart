import 'package:flutter/material.dart';
import 'package:login/model/user.dart';
import 'landing.dart';
import 'view/Home page/home.dart';
import 'view/login page/login.dart';
import 'package:provider/provider.dart';

void main() {
  
  runApp(MultiProvider(
    
    providers: [
      ChangeNotifierProvider(create: (_)=> User())
    ],
    
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.green,
            ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Landing(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(title: 'home'),
      },
    );
  }
}

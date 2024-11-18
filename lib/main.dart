import 'package:flutter/material.dart';
import 'package:front_kpop/screens/HomeScreen.dart';
import 'package:front_kpop/screens/LoginScreen.dart';
import 'package:front_kpop/screens/RegisterScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

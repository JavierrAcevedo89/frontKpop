import 'package:flutter/material.dart';
import 'package:front_kpop/services/AuthService.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> handleLogin() async {
    try {
      final response = await authService.login(
        emailController.text,
        passwordController.text,
      );

      final token = response['token'];
      if (token != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inicio de Sesión',
          style: GoogleFonts.lilitaOne(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF6EC7), Color(0xFF8A2BE2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: GoogleFonts.notoSans(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: GoogleFonts.notoSans(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  'Iniciar sesión',
                  style: GoogleFonts.notoSans(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.purpleAccent),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  'Registrarse',
                  style: GoogleFonts.notoSans(fontSize: 18, color: Colors.purple),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

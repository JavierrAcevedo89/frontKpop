import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl = 'kpopMovilesDos.somee.com/api/Cuentas';
  final storage = new FlutterSecureStorage();

  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://kpopMovilesDos.somee.com/api/Cuentas/Registrar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await storage.write(key: 'token', value: data['token']);
      return data;
    } else {
      throw Exception('Error en el registro: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://kpopMovilesDos.somee.com/api/Cuentas/Login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Guardar token al hacer login
      final data = jsonDecode(response.body);
      await storage.write(key: 'token', value: data['token']);
      return data;
    } else {
      throw Exception('Error en el login: ${response.body}');
    }
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }
  
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api.dart';

// Service untuk autentikasi (login & register)
class AuthService {

  // Fungsi register user baru
  static Future<Map<String, dynamic>> register(
      String name,
      String email,
      String password,
      ) async {
    // Request POST ke endpoint register API
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/auth/register.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,         // Nama lengkap user
        'email': email,       // Email user
        'password': password // Password user
      }),
    );

    // Mengembalikan response API dalam bentuk Map
    return jsonDecode(response.body);
  }

  // Fungsi login user
  static Future<Map<String, dynamic>> login(
      String email,
      String password,
      ) async {
    // Request POST ke endpoint login API
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/auth/login.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,       // Email user
        'password': password // Password user
      }),
    );

    // Mengembalikan response API dalam bentuk Map
    return jsonDecode(response.body);
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

// Signup
Future<Map<String, dynamic>> signup(
  String name,
  String email,
  String password,
) async {
  final response = await http.post(
    Uri.parse("http://10.0.2.2:3000/signup"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({'name': name, 'email': email, 'password': password}),
  );
  return jsonDecode(response.body);
}

// Login
Future<Map<String, dynamic>> login(String email, String password) async {
  final response = await http.post(
    Uri.parse("http://10.0.2.2:3000/login"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({'email': email, 'password': password}),
  );
  return jsonDecode(response.body);
}

class ApiService {
  static const baseUrl = 'http://10.0.2.2:3000';

  static Future<Map<String, dynamic>> getUserProfile(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
    print('profile response: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}

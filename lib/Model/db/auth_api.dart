import 'package:my_agenda/Model/db/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  Future<void> login(String email, String password) async {
    final response = await ApiClient.dio.post(
      '/api/auth/login',
      data: {'email': email, 'password': password},
    );

    final token = response.data['token'] ?? response.data['Token'];

    if (token == null) {
      throw Exception('No se recibio token');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token.toString());
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('name', email);
  }

  Future<void> register(String email, String password) async {
    await ApiClient.dio.post(
      '/api/auth/register',
      data: { 'email': email, 'password': password},
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('isLoggedIn');
    await prefs.remove('name');
  }
}

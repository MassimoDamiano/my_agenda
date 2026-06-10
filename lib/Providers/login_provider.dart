import 'package:flutter/material.dart';
import 'package:my_agenda/Model/db/auth_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final AuthApi _authApi = AuthApi();
  String _name = "";
  bool _isLoggedIn = false;

  LoginProvider() {
    _loadSession();
  }

  String get name => _name;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String name, String password) async {
    await _authApi.login(name, password);

    _name = name;
    _isLoggedIn = true;

    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    await _authApi.register(email, password);
  }

  Future<void> logout() async {
    _name = "";
    _isLoggedIn = false;

    await _authApi.logout();

    notifyListeners();
  }

  Future<void> _loadSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("name") ?? "";
    _isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    notifyListeners();
  }
}

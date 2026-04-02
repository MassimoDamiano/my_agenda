import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  String _name = "";

  bool _isLoggedIn = false;

    LoginProvider() {
    _loadSession();
  } 

  // Getters
  String get name => _name;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String name, String password) async {
    if (name == "Massimo" && password == "123") {
      _name = name;
      _isLoggedIn = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("name", _name);
      await prefs.setBool("isLoggedIn", _isLoggedIn);
      
      notifyListeners();
    } else {
      throw Exception("Error,, Try Again");
    }
  }

  Future<void> logout() async {
    _name = "";
    _isLoggedIn = false;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifyListeners();
  }

  Future<void> _loadSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("name") ?? "";
    _isLoggedIn = prefs.getBool("isLoggedin") ?? false;
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  AuthModel() {
    _loadLoginStatus(); // Giriş durumunu yükle
  }

  Future<void> _loadLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners(); // Durumu bildir
  }

  Future<void> login(String username, String password) async {
    if (username == "admin" && password == "1234") {
      _isLoggedIn = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true); // Giriş durumunu kaydet
      notifyListeners();
    } else {
      throw Exception("Kullanıcı adı veya şifre hatalı");
    }
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Giriş durumunu sıfırla
    notifyListeners();
  }
}

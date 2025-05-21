import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<void> login(String email, String password) async {
    try {

      // Firebase Authentication ile giriş yap
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        _isLoggedIn = true; // Giriş başarılı, durumu güncelle
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true); // Giriş durumunu kaydet
        notifyListeners();
      }

    } on FirebaseAuthException catch (e) {
      // Firebase Authentication'dan gelen hataları işleyin
      if (e.code == 'user-not-found') {
        throw Exception("Kullanıcı bulunamadı.");
      } else if (e.code == 'wrong-password') {
        throw Exception("Şifre hatalı.");
      } else {
        throw Exception("Bir hata oluştu: ${e.message}");
      }
    } catch (e) {
      throw Exception("Bir hata oluştu: $e");
    }
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Giriş durumunu sıfırla
    notifyListeners();
  }
}

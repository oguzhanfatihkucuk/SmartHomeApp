import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../Services/SharedPreferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  void _login(BuildContext context) async {
    final auth = Provider.of<AuthModel>(context, listen: false);

    try {
      await auth.login(_usernameController.text, _passwordController.text);
      context.go('/main'); // Başarılı girişte Ana Ekrana yönlendir
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  void _loginWithGoogle() {
    // Google ile giriş işlemi
    context.go('/main');
  }

  void _loginWithApple() {
    // Apple ile giriş işlemi
    context.go('/main');
  }

  void _loginWithGmail() {
    // Gmail ile giriş işlemi
    context.go('/main');
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel>(context);

    // Eğer giriş yapılmışsa doğrudan MainScreen'e yönlendir
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (auth.isLoggedIn) {
        context.go('/main');
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text('Giriş Yap',)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/logo/img.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Kullanıcı Adı',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Şifre',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF34E0A1),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Giriş Yap', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'Veya ile giriş yapın:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialLoginButton(
                  icon: Icons.email,
                  label: 'Gmail',
                  color: Colors.red,
                  onTap: _loginWithGmail,
                ),
                _buildSocialLoginButton(
                  icon: Icons.apple,
                  label: 'Apple',
                  color: Colors.black,
                  onTap: _loginWithApple,
                ),
                _buildSocialLoginButton(
                  icon: Icons.g_translate,
                  label: 'Google',
                  color: Colors.blue,
                  onTap: _loginWithGoogle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: Text(label, style: TextStyle(fontSize: 14)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: Size(100, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

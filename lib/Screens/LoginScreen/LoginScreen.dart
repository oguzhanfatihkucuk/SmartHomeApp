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
  final _emailController = TextEditingController(text: 'deneme@gmail.com');
  final _passwordController = TextEditingController(text: 'deneme');
  String? _errorMessage;

  bool _isLoading = false; // Loading state

  void _login(BuildContext context) async {
    final auth = Provider.of<AuthModel>(context, listen: false);

    if (_emailController.text.isEmpty) {
      setState(() {
        _errorMessage = "Email cannot be empty.";
      });
      return;
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = "Password cannot be empty.";
      });
      return;
    }

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = "Email and Password cannot be empty.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null; // Reset previous error
    });

    try {
      await auth.login(_emailController.text, _passwordController.text);
      context.go('/main'); // Redirect on successful login
    } catch (e) {
      setState(() {
        _errorMessage = e.toString(); // Save error message
      });
    } finally {
      setState(() {
        _isLoading = false; // Turn off loading state when process completes
      });
    }
  }

  void _loginWithGoogle() {
    // Google login process
    context.go('/main');
  }

  void _loginWithApple() {
    // Apple login process
    context.go('/main');
  }

  void _loginWithGmail() {
    // Gmail login process
    context.go('/main');
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel>(context);

    // If already logged in, redirect directly to MainScreen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (auth.isLoggedIn) {
        context.go('/main');
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
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
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
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
                labelText: 'Password',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Text(
              _errorMessage != null ? "$_errorMessage" : "",
              style: TextStyle(color: Colors.red),
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
              child: Text('Login', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'Or login with:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialLoginButton(
                  icon: Icons.email,
                  iconColor: Colors.white,
                  label: 'Gmail',
                  color: Colors.red,
                  onTap: _loginWithGmail,
                ),
                _buildSocialLoginButton(
                  icon: Icons.apple,
                  iconColor: Colors.white,
                  label: 'Apple',
                  color: Colors.black,
                  onTap: _loginWithApple,
                ),
                _buildSocialLoginButton(
                  icon: Icons.g_translate,
                  iconColor: Colors.white,
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
    required Color iconColor,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20, color: iconColor),
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
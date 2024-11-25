import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../Services/SharedPreferences.dart';

class SettingsScreen extends StatelessWidget {
  get auth => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final auth = Provider.of<AuthModel>(context, listen: false);
              if (auth != null) {
                await auth.logout(); // Çıkış yap
                context.go('/'); // LoginScreen'e yönlendir
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Ayarlar Ekranı',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
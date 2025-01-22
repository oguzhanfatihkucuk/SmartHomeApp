import 'package:flutter/material.dart';

class SettingsDetailScreen extends StatefulWidget {
  @override
  _SettingsDetailScreenState createState() => _SettingsDetailScreenState();
}

class _SettingsDetailScreenState extends State<SettingsDetailScreen> {
  // Bildirim durumu (true veya false)
  bool _isNotificationEnabled = true;
  bool _isDarkMode = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Genel Ayarlar",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Bildirimleri Aç'),
              value: _isNotificationEnabled, // Durumu burada kullanıyoruz
              onChanged: (bool value) {
                setState(() {
                  _isNotificationEnabled = value; // Durumu güncelliyoruz
                });
              },
            ),
            SwitchListTile(
              title: const Text('Kararan Modu Aktif Et'),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value; // Durumu güncelliyoruz
                });
              },
            ),
            const SizedBox(height: 16),
            const Divider(),
            const Text(
              "Hesap Ayarları",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("E-posta Adresini Değiştir"),
              onTap: () {
                // E-posta değişikliği işlemleri
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text("Şifreyi Değiştir"),
              onTap: () {
                // Şifre değiştirme işlemleri
              },
            ),
          ],
        ),
      ),
    );
  }
}

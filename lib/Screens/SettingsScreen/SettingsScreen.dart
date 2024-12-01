import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../Services/SharedPreferences.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilim'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profil Bilgileri
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://via.placeholder.com/150"), // Profil resmi
              ),
              const SizedBox(height: 16),
              const Text(
                "Ad Soyad",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "adsoyad@örnek.com",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              // Ayarlar Menüsü
              ListTile(
                leading: const Icon(Icons.person, color: Colors.blue),
                title: const Text("Profil Detayları"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Profil detayları sayfasına yönlendirme
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.blue),
                title: const Text("Ayarlar"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Ayarlar sayfasına yönlendirme
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_outline, color: Colors.blue),
                title: const Text("Destek"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Destek sayfasına yönlendirme
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Çıkış"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  // Pop-up göstermek için showDialog kullanılıyor
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Çıkış Yap"),
                        content: const Text(
                            "Hesabınızdan çıkış yapmak istediğinizden emin misiniz?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(false); // İptal seçeneği
                            },
                            child: const Text("Hayır"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true); // Çıkış seçeneği
                            },
                            child: const Text("Evet"),
                          ),
                        ],
                      );
                    },
                  );

                  // Kullanıcı çıkışı onayladıysa işlemi gerçekleştir
                  if (shouldLogout == true) {
                    final auth = Provider.of<AuthModel>(context, listen: false);
                    if (auth != null) {
                      await auth.logout(); // Çıkış yap
                      context.go('/'); // LoginScreen'e yönlendir
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

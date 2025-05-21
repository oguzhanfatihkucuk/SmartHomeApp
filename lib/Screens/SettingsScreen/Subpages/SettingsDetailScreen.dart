import 'package:flutter/material.dart';

class SettingsDetailScreen extends StatefulWidget {
  @override
  _SettingsDetailScreenState createState() => _SettingsDetailScreenState();
}

class _SettingsDetailScreenState extends State<SettingsDetailScreen> {
  bool _isNotificationEnabled = true;
  bool _isDarkMode = true;
  bool _isBiometricAuthEnabled = false;
  String _selectedLanguage = 'English';
  String _selectedTheme = 'System Default';

  final List<String> _languages = ['English', 'Spanish', 'French', 'German'];
  final List<String> _themes = ['System Default', 'Light', 'Dark'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "General Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Enable Notifications'),
                value: _isNotificationEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isNotificationEnabled = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Activate Dark Mode'),
                value: _isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
              ),
              ListTile(
                title: const Text('Language'),
                subtitle: Text(_selectedLanguage),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showLanguagePicker(context);
                },
              ),
              ListTile(
                title: const Text('Theme'),
                subtitle: Text(_selectedTheme),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showThemePicker(context);
                },
              ),
              const SizedBox(height: 16),
              const Divider(),
              const Text(
                "Account Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text("Change Email Address"),
                onTap: () {
                  // Handle email change logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text("Change Password"),
                onTap: () {
                  // Handle password change logic
                },
              ),
              SwitchListTile(
                title: const Text('Enable Biometric Authentication'),
                value: _isBiometricAuthEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isBiometricAuthEnabled = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              const Divider(),
              const Text(
                "Privacy Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.visibility),
                title: const Text("Profile Visibility"),
                subtitle: const Text("Who can see your profile"),
                onTap: () {
                  // Handle profile visibility settings
                },
              ),
              ListTile(
                leading: const Icon(Icons.security),
                title: const Text("Data Privacy"),
                subtitle: const Text("Manage your data privacy settings"),
                onTap: () {
                  // Handle data privacy settings
                },
              ),
              const SizedBox(height: 16),
              const Divider(),
              const Text(
                "Support & Feedback",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text("Help & Support"),
                onTap: () {
                  // Navigate to help & support screen
                },
              ),
              ListTile(
                leading: const Icon(Icons.feedback),
                title: const Text("Send Feedback"),
                onTap: () {
                  // Handle send feedback logic
                },
              ),
              const SizedBox(height: 16),
              const Divider(),
              const Text(
                "Advanced Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.developer_mode),
                title: const Text("Developer Options"),
                onTap: () {
                  // Navigate to developer options screen
                },
              ),
              ListTile(
                leading: const Icon(Icons.storage),
                title: const Text("Clear Cache"),
                onTap: () {
                  // Handle clear cache logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _languages
                  .map((language) => ListTile(
                title: Text(language),
                onTap: () {
                  setState(() {
                    _selectedLanguage = language;
                  });
                  Navigator.of(context).pop();
                },
              ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  void _showThemePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Theme'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _themes
                  .map((theme) => ListTile(
                title: Text(theme),
                onTap: () {
                  setState(() {
                    _selectedTheme = theme;
                  });
                  Navigator.of(context).pop();
                },
              ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
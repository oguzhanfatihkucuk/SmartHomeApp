import 'package:flutter/material.dart';

class SettingsDetailScreen extends StatefulWidget {
  @override
  _SettingsDetailScreenState createState() => _SettingsDetailScreenState();
}

class _SettingsDetailScreenState extends State<SettingsDetailScreen> {
  // Notification state (true or false)
  bool _isNotificationEnabled = true;
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'General Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: _isNotificationEnabled, // Use the state here
              onChanged: (bool value) {
                setState(() {
                  _isNotificationEnabled = value; // Update the state
                });
              },
            ),
            SwitchListTile(
              title: const Text('Activate Dark Mode'),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value; // Update the state
                });
              },
            ),
            const SizedBox(height: 16),
            const Divider(),
            const Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Change Email Address'),
              onTap: () {
                // Handle email change logic here
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              onTap: () {
                // Handle password change logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
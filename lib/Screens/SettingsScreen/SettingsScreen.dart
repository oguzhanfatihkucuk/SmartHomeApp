import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../Services/SharedPreferences.dart';
import 'Subpages/ProfileScreen.dart';
import 'Subpages/SettingsDetailScreen.dart';
import 'Subpages/SupportScreen.dart';

class SettingsScreen extends StatelessWidget {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Information
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://via.placeholder.com/150"), // Profile picture
              ),
              const SizedBox(height: 16),
              const Text(
                "Full Name",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "fullname@example.com",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              // Settings Menu
              ListTile(
                leading: const Icon(Icons.person, color: Colors.blue),
                title: const Text("Profile Details"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.settings, color: Colors.blue),
                title: const Text("Settings"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsDetailScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_outline, color: Colors.blue),
                title: const Text("Support"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to support page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SupportScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Logout"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  // Using showDialog to display pop-up
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Logout"),
                        content: const Text(
                            "Are you sure you want to log out of your account?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(false); // Cancel option
                            },
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true); // Logout option
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      );
                    },
                  );

                  // Perform logout if user confirmed
                  if (shouldLogout == true) {
                    final auth = Provider.of<AuthModel>(context, listen: false);
                    if (auth != null) {
                      await auth.logout(); // Logout
                      context.go('/'); // Redirect to LoginScreen
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

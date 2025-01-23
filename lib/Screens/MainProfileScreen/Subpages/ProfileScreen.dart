import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar title
      appBar: AppBar(
        title: const Text('Profile Details'),
      ),
      body: Padding(
        // Add some padding around the content
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Align content to the start
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile picture
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  "https://via.placeholder.com/150"),
            ),
            const SizedBox(height: 16),
            // User name
            const Text(
              "Name Surname", // Change to display actual user name
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // User email
            Text(
              "emailaddress@example.com", // Change to display actual email
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            // Text for 'About User' section
            const Text(
              'About User',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Text to display user information
            Text(
              "This section will contain information about the user.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Text for 'Location' section
            const Text(
              'Location',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Mock location data (replace with actual location retrieval)
            Text(
              "Istanbul, Turkey",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
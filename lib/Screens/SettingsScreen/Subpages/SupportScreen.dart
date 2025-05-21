import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('support@example.com'),
              onTap: () async {

              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone'),
              subtitle: const Text('+1 (123) 456-7890'),
              onTap: () async {

              },
            ),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Website'),
              subtitle: const Text('https://www.example.com'),
              onTap: () async {

              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Social Media',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () async {

                  },
                ),
                IconButton(
                  icon:Icon(Icons.abc_outlined),
                  onPressed: () async {

                  },
                ),
                IconButton(
                  icon: const Icon(Icons.apple),
                  onPressed: () async {

                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('FAQ'),
              onTap: () {
                // Navigate to FAQ screen
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => FAQScreen()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
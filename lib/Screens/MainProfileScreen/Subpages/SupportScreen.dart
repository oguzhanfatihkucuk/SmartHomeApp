import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


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
                final Uri params = Uri(
                  scheme: 'mailto',
                  path: 'support@example.com',
                  query: 'subject=App Support',
                );
                if (await canLaunchUrl(params)) {
                  await launchUrl(params);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('No email app found.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone'),
              subtitle: const Text('+1 (123) 456-7890'),
              onTap: () async {
                final Uri telUri = Uri(scheme: 'tel', path: '+11234567890');
                if (await canLaunchUrl(telUri)) {
                  await launchUrl(telUri);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Website'),
              subtitle: const Text('https://www.example.com'),
              onTap: () async {
                final Uri websiteUri = Uri.parse('https://www.example.com');
                if (await canLaunchUrl(websiteUri)) {
                  await launchUrl(websiteUri);
                }
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
                    const url = 'https://www.facebook.com/yourcompany';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    }
                  },
                ),
                IconButton(
                  icon:Icon(Icons.abc_outlined),
                  onPressed: () async {
                    const url = 'https://www.twitter.com/yourcompany';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.apple),
                  onPressed: () async {
                    const url = 'https://www.instagram.com/yourcompany';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    }
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
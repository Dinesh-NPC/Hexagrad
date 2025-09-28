import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MentorsScreen extends StatelessWidget {
  const MentorsScreen({super.key});

  static const List<Map<String, String>> mentors = [
    {
      "name": "Indira",
      "phone": "+91 9345833643 ",
      "email": "indira@gmail.com",
    },
    {
      "name": "Kaviya Sree",
      "phone": "+91 7010941264",
      "email": "kaviya@gmail.com",
    },
    {
      "name": "Hemadevi",
      "phone": "+91 9345761776",
      "email": "hema@gmail.com",
    },
    {
      "name": "Dinesh Kumar",
      "phone": "+91 7010483576 ",
      "email": "dinesh.kumar@gmail.com",
    },
    {
      "name": "Jasir Ahamed",
      "phone": "+91 8778990686",
      "email": "jasir@gmail.com",
    },
    {
      "name": "Kishore Kumar",
      "phone": "+91 7094747535",
      "email": "kishore@gmail.com",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Mentors'),
        backgroundColor: Colors.blue.shade600,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mentors.length,
        itemBuilder: (context, index) {
          final mentor = mentors[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mentor['name']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.blue, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        mentor['phone']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.email, color: Colors.blue, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        mentor['email']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final url = Uri(scheme: 'tel', path: mentor['phone']);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Cannot make call')),
                            );
                          }
                        },
                        icon: const Icon(Icons.call),
                        label: const Text('Call'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final url = Uri(scheme: 'mailto', path: mentor['email']);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Cannot send email')),
                            );
                          }
                        },
                        icon: const Icon(Icons.email),
                        label: const Text('Email'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

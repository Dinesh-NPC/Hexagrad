import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  const ProfileScreen({super.key, required this.name, this.email = "", this.phone = ""});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome, $name 👋",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            if (email.isNotEmpty) Text("Email: $email"),
            if (phone.isNotEmpty) Text("Phone: $phone"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // go back to dashboard
              },
              child: const Text("Back to Dashboard"),
            ),
          ],
        ),
      ),
    );
  }
}

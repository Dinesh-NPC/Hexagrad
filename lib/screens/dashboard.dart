import 'package:flutter/material.dart';
import 'profile_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HexaGrad Dashboard")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text("HexaGrad Menu",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              title: const Text("Career Guidance"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Courses"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("AI Chat"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(
                      name: "User",
                      email: "user@example.com",
                      phone: "+91XXXXXXXXXX",
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text("Welcome to HexaGrad – AI-powered Career Guidance"),
      ),
    );
  }
}

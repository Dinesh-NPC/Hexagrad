import 'package:flutter/material.dart';
import 'career_test_screen.dart';

class CareerAssessmentScreen extends StatelessWidget {
  const CareerAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Career Assessment Test")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Start the 5 dimensional assessment and discover your best fit career!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CareerTestScreen()));
                },
                child: const Text("Start Assessment"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

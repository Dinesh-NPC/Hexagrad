import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/competitive_exams_data.dart';

class UploadExamsScreen extends StatelessWidget {
  const UploadExamsScreen({super.key});

  Future<void> uploadExams() async {
    final collection = FirebaseFirestore.instance.collection('competitiveExams');

    for (var exam in competitiveExamsData) {
      var existing = await collection.where('name', isEqualTo: exam['name']).get();
      if (existing.docs.isEmpty) {
        await collection.add(exam);
      }
    }
    print("Exams uploaded to Firestore (if not already present)");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Exams")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await uploadExams();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Dataset uploaded to Firestore!")),
            );
          },
          child: const Text("Upload Dataset"),
        ),
      ),
    );
  }
}

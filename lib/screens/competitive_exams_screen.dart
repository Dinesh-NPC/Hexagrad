import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompetitiveExamsScreen extends StatefulWidget {
  const CompetitiveExamsScreen({super.key});

  @override
  State<CompetitiveExamsScreen> createState() => _CompetitiveExamsScreenState();
}

class _CompetitiveExamsScreenState extends State<CompetitiveExamsScreen> {
  final CollectionReference examsCollection =
      FirebaseFirestore.instance.collection('competitiveExams');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Competitive Exams")),
      body: StreamBuilder<QuerySnapshot>(
        stream: examsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final exams = snapshot.data!.docs;

          if (exams.isEmpty) {
            return const Center(child: Text("No exams available"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: exams.length,
            itemBuilder: (context, index) {
              final exam = exams[index].data() as Map<String, dynamic>;

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: ExpansionTile(
                    title: Text(
                      exam['name'] ?? 'Unknown Exam',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    children: [
                      if (exam['eligibility'] != null)
                        ListTile(
                          title: const Text("Eligibility"),
                          subtitle: Text(exam['eligibility']),
                        ),
                      if (exam['syllabus'] != null)
                        ListTile(
                          title: const Text("Syllabus"),
                          subtitle: Text(exam['syllabus']),
                        ),
                      if (exam['examPattern'] != null)
                        ListTile(
                          title: const Text("Exam Pattern"),
                          subtitle: Text(exam['examPattern']),
                        ),
                      if (exam['importantDates'] != null)
                        ListTile(
                          title: const Text("Important Dates"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: (exam['importantDates'] as Map<String, dynamic>)
                                .entries
                                .map((e) => Text("${e.key}: ${e.value}"))
                                .toList(),
                          ),
                        ),
                      if (exam['applicationProcess'] != null)
                        ListTile(
                          title: const Text("Application Process"),
                          subtitle: Text(exam['applicationProcess']),
                        ),
                      if (exam['officialLink'] != null)
                        ListTile(
                          title: const Text("Official Link"),
                          subtitle: Text(exam['officialLink']),
                        ),
                      if (exam['remarks'] != null)
                        ListTile(
                          title: const Text("Remarks"),
                          subtitle: Text(exam['remarks']),
                        ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // TODO: connect to notifications
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Reminder for this exam will be set (coming soon)"),
                                ),
                              );
                            },
                            icon: const Icon(Icons.notifications),
                            label: const Text("Set Reminder"),
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

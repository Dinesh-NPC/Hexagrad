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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Competitive Exams",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search exams...",
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          
          // Exams List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: examsCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 60, color: Colors.red[300]),
                        const SizedBox(height: 16),
                        const Text("Something went wrong",
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final exams = snapshot.data!.docs;

                if (exams.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.note_alt_outlined,
                            size: 60, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text("No exams available",
                            style:
                                TextStyle(fontSize: 18, color: Colors.grey[600])),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: exams.length,
                  itemBuilder: (context, index) {
                    final exam = exams[index].data() as Map<String, dynamic>;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ExpansionTile(
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.school, color: Colors.blue),
                        ),
                        title: Text(
                          exam['name'] ?? 'Unknown Exam',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          exam['eligibility']?.toString().split('.')[0] ?? '',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (exam['eligibility'] != null)
                                  _buildInfoSection(
                                    "Eligibility",
                                    exam['eligibility'],
                                    Icons.person_outline,
                                  ),
                                if (exam['syllabus'] != null)
                                  _buildInfoSection(
                                    "Syllabus",
                                    exam['syllabus'],
                                    Icons.book_outlined,
                                  ),
                                if (exam['examPattern'] != null)
                                  _buildInfoSection(
                                    "Exam Pattern",
                                    exam['examPattern'],
                                    Icons.rule_outlined,
                                  ),
                                if (exam['importantDates'] != null)
                                  _buildDatesSection(
                                    exam['importantDates'] as Map<String, dynamic>,
                                  ),
                                if (exam['applicationProcess'] != null)
                                  _buildInfoSection(
                                    "Application Process",
                                    exam['applicationProcess'],
                                    Icons.edit_document,
                                  ),
                                if (exam['officialLink'] != null)
                                  _buildInfoSection(
                                    "Official Link",
                                    exam['officialLink'],
                                    Icons.link,
                                  ),
                                
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Reminder will be set soon",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      icon: const Icon(Icons.notifications),
                                      label: const Text("Set Reminder"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, String content, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatesSection(Map<String, dynamic> dates) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calendar_today, size: 20, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                "Important Dates",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...dates.entries.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Text(
                      "• ${e.key}:",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      e.value.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
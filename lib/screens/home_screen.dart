import 'package:flutter/material.dart';
import 'upload_exams_screen.dart';
import 'competitive_exams_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int questionIndex = 0;
  String? selectedAnswer;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is your highest education qualification?",
      "options": ["Below Class 10", "Class 10", "Class 12", "Diploma", "Graduation", "Post Graduation"],
    },
    {
      "question": "Which subject do you enjoy the most?",
      "options": ["Mathematics", "Science", "Arts", "Commerce", "Technology"],
    },
    {
      "question": "Do you prefer Research or Practical Work?",
      "options": ["Research", "Practical Work", "Both"],
    },
  ];

  void nextQuestion() {
    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
        selectedAnswer = null;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Test Completed 🎉"),
          content: const Text("Your personalized career suggestions will appear here."),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentQ = questions[questionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        title: Row(
          children: const [
            Icon(Icons.school, color: Colors.blue),
            SizedBox(width: 10),
            Text("EduCareer Hub", style: TextStyle(color: Colors.black)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CompetitiveExamsScreen()));
            },
            icon: const Icon(Icons.book, color: Colors.black),
            tooltip: "Competitive Exams",
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const UploadExamsScreen()));
            },
            icon: const Icon(Icons.upload_file, color: Colors.black),
            tooltip: "Upload Dataset",
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              color: Colors.blue.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Welcome to EduCareer Hub",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const Text(
                      "Your personalized guide for education, skills, and career growth",
                      style: TextStyle(fontSize: 16, color: Colors.black54)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const CompetitiveExamsScreen()));
                    },
                    child: const Text("Explore Competitive Exams"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search courses, exams, colleges...",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Featured Exams Grid (like Shiksha)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Featured Exams",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.school, size: 36, color: Colors.blueAccent),
                              const SizedBox(height: 8),
                              Text("Exam ${index + 1}",
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Aptitude Test Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentQ["question"],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 20),
                    ...currentQ["options"].map<Widget>((opt) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAnswer = opt;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: selectedAnswer == opt ? Colors.blue : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(opt,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: selectedAnswer == opt ? Colors.white : Colors.black)),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: nextQuestion,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, shape: const StadiumBorder()),
                        child: const Text("Next"),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (ctx) => Container(
              height: 400,
              padding: const EdgeInsets.all(20),
              child: const Center(
                child: Text("🤖 Chatbot coming soon...",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.chat),
      ),
    );
  }
}

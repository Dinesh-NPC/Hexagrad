  import 'package:flutter/material.dart';
  import 'upload_exams_screen.dart';
  import 'competitive_exams_screen.dart';
  import 'career_assessment_screen.dart';
  import 'chatbot_screen.dart';
  import 'college_explorer.dart';
  class HomeScreen extends StatefulWidget {
    const HomeScreen({Key? key}) : super(key: key);

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    Widget buildServiceCard({
      required IconData icon,
      required String title,
      required String subtitle,
      required Color color,
      VoidCallback? onTap,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 3,
          shadowColor: color.withOpacity(0.2),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.08), color.withOpacity(0.03)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 22, color: color),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.school, color: Colors.blue, size: 20),
              ),
              const SizedBox(width: 10),
              const Text(
                "EduCareer Hub",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UploadExamsScreen()),
                );
              },
              icon: Icon(Icons.upload_file, color: Colors.blue.shade700, size: 22),
              tooltip: "Upload Dataset",
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome to EduCareer Hub",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Your personalized guide for education, skills, and career growth.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search courses, exams, colleges...",
                  prefixIcon: Icon(Icons.search, color: Colors.blue.shade400, size: 20),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.blue.shade200),
                  ),
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Find Solutions For",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward, size: 16),
                    label: const Text("View All", style: TextStyle(fontSize: 13)),
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 1.15,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  buildServiceCard(
                    icon: Icons.checklist_rounded,
                    title: "Career Shortlisting",
                    subtitle: "Understand your inclination and shortlist best-fit careers",
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CareerAssessmentScreen()),
                      );
                    },
                  ),
                  buildServiceCard(
                    icon: Icons.book_rounded,
                    title: "Competitive Exams",
                    subtitle: "Explore and prepare for competitive examinations",
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CompetitiveExamsScreen()),
                      );
                    },
                  ),
                  buildServiceCard(
                    icon: Icons.timeline_rounded,
                    title: "Planning Tools",
                    subtitle: "Plan your career path and create roadmap",
                    color: Colors.orange,
                  ),
                  buildServiceCard(
                    icon: Icons.school_rounded,
                    title: "College Application",
                    subtitle: "Get expert help for dream college admission",
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CollegeExplorer()),
                      );
                    },
                  ),
                  buildServiceCard(
                    icon: Icons.folder_outlined,
                    title: "My Resources",
                    subtitle: "Access resources to understand options better",
                    color: Colors.red,
                  ),
                  buildServiceCard(
                    icon: Icons.assignment_outlined,
                    title: "Test Prep & Others",
                    subtitle: "Get assistance for exam preparation",
                    color: Colors.teal,
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatbotScreen()),
            );
          },
          backgroundColor: Colors.blue.shade400,
          child: const Icon(Icons.chat_bubble_outline_rounded, size: 20),
        ),
      );
    }
  }
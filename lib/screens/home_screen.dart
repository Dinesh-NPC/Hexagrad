import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'upload_exams_screen.dart';
import 'competitive_exams_screen.dart';
import 'career_assessment_screen.dart';
import 'chatbot_screen.dart';
import 'college_explorer.dart';
import 'profile_details_screen.dart';
import 'dashboard.dart';
import 'profile.dart';
import 'profile_view.dart';
import 'mentors_screen.dart';
import 'locate_colleges_screen.dart';
import 'contact_us_screen.dart'; // ✅ kept from old code
import 'scholarship_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isProfileFilled = false;
  int _completedMilestones = 0;
  bool _assessmentCompleted = false;
  bool _examsExplored = false;
  bool _guidanceUsed = false;
  bool _collegeApplicationStarted = false;
  bool _scholarshipsExplored = false;

  @override
  void initState() {
    super.initState();
    _checkProfileStatus();
  }

  Future<void> _checkProfileStatus() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          _isProfileFilled = data['firstName'] != null && data['firstName'].isNotEmpty;
          _assessmentCompleted = data['assessmentCompleted'] ?? false;
          _examsExplored = data['examsExplored'] ?? false;
          _guidanceUsed = data['guidanceUsed'] ?? false;
          _collegeApplicationStarted = data['collegeApplicationStarted'] ?? false;
          _scholarshipsExplored = data['scholarshipsExplored'] ?? false;
          _completedMilestones = (_isProfileFilled ? 1 : 0) +
            (_assessmentCompleted ? 1 : 0) +
            (_examsExplored ? 1 : 0) +
            (_guidanceUsed ? 1 : 0) +
            (_collegeApplicationStarted ? 1 : 0) +
            (_scholarshipsExplored ? 1 : 0);
        });
      }
    }
  }

  // Progress Section
  Widget _buildProgressSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hi There!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3142),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Let's Start Your Career Journey!",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMiniCard(
                  title: "MY PROGRESS",
                  value: "$_completedMilestones/6",
                  subtitle: "Milestones Completed",
                  icon: Icons.trip_origin,
                  iconColor: Colors.blue,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Your Progress'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildProgressItem('Profile Details', _isProfileFilled),
                            _buildProgressItem('Career Assessment', _assessmentCompleted),
                            _buildProgressItem('Competitive Exams', _examsExplored),
                            _buildProgressItem('Personalized Guidance', _guidanceUsed),
                            _buildProgressItem('College Application', _collegeApplicationStarted),
                            _buildProgressItem('Scholarship Opportunities', _scholarshipsExplored),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMiniCard(
                  title: "ONGOING",
                  value: "Career Assessment",
                  subtitle: _assessmentCompleted ? "100% Completed" : "0% Completed",
                  icon: Icons.assignment_outlined,
                  iconColor: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CareerAssessmentScreen()),
                    ).then((_) => _checkProfileStatus());
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMiniCard(
                  title: "COMING UP NEXT",
                  value: "Profile Details",
                  subtitle: _isProfileFilled ? "Completed" : "Not Started",
                  icon: Icons.person_outline,
                  iconColor: _isProfileFilled ? Colors.green : Colors.redAccent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileView()),
                    );
                  },
                  button: _isProfileFilled ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const Profile(isEditMode: true)),
                      );
                    },
                    child: const Text('Edit'),
                  ) : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    VoidCallback? onTap,
    Widget? button,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3142),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3142),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            if (button != null) ...[
              const SizedBox(height: 8),
              button,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(String title, bool completed) {
    return ListTile(
      leading: Icon(
        completed ? Icons.check_circle : Icons.radio_button_unchecked,
        color: completed ? Colors.green : Colors.grey,
      ),
      title: Text(title),
    );
  }

  // Solution Cards
  Widget _buildSolutionCard(
      String title, String description, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: Colors.blue.shade700, size: 26),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    color: Colors.grey[400], size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Scaffold with Drawer + FAB
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.school, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            const Text(
              "Pathora",
              style: TextStyle(
                color: Color(0xFF2D3142),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),

      ),

      // Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Dashboard()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileView()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_books),
              title: const Text('Course Suggestions'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Course Suggestions coming soon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.work_outline),
              title: const Text('Career Paths'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Career Paths coming soon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Compare Colleges'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CollegeExplorer()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: const Text('Scholarships'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScholarshipDetailsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notifications coming soon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('My Mentors'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MentorsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Locate Colleges'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const LocateCollegesScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ContactUsScreen()), // ✅ from old code
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings coming soon')),
                );
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressSection(),

            // Search bar
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search courses, exams, colleges...",
                  prefixIcon:
                      Icon(Icons.search, color: Colors.blue.shade400, size: 22),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 15),
                ),
              ),
            ),

            // Solutions Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Solutions For You",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[850],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildSolutionCard(
              "Career Assessment",
              "Find your best-fit career with Psychometric Assessment & Internship Program.",
              Icons.checklist_rounded,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CareerAssessmentScreen()),
                ).then((_) => _checkProfileStatus());
              },
            ),
            _buildSolutionCard(
              "Competitive Exams",
              "Explore exams & preparation strategies for your career path.",
              Icons.school,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CompetitiveExamsScreen()),
                );
              },
            ),
            _buildSolutionCard(
              "Personalized Guidance",
              "One-on-one sessions with expert counsellors for career clarity.",
              Icons.person_outline,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MentorsScreen()),
                );
              },
            ),
            _buildSolutionCard(
              "Explore Colleges",
              "Discover and compare top colleges to find your perfect fit.",
              Icons.school_rounded,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CollegeExplorer()),
                );
              },
            ),
            _buildSolutionCard(
              "Scholarship Opportunities",
              "Discover scholarships tailored to your profile and career goals.",
              Icons.card_giftcard,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScholarshipDetailsScreen()),
                );
              },
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
        backgroundColor: const Color(0xFF4A90E2),
        child: const Icon(Icons.chat_bubble_outline_rounded, size: 22),
      ),
    );
  }
}

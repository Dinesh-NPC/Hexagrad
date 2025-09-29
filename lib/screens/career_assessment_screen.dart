import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/assessment_data.dart';
import 'career_result_screen.dart';

class CareerAssessmentScreen extends StatefulWidget {
  const CareerAssessmentScreen({super.key});

  @override
  _CareerAssessmentScreenState createState() => _CareerAssessmentScreenState();
}

class _CareerAssessmentScreenState extends State<CareerAssessmentScreen> {
  int _categoryIndex = 0;
  int _questionIndex = 0;

  Map<String, int> careerScores = {}; // Track career scores

  List<String> get categories => assessmentData.keys.toList();

  @override
  Widget build(BuildContext context) {
    String currentCategory = categories[_categoryIndex];
    var currentQuestion = assessmentData[currentCategory]![_questionIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Career Assessment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$currentCategory (${_questionIndex + 1}/${assessmentData[currentCategory]!.length})',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              currentQuestion['question'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ...List<Widget>.from(
              currentQuestion['options'].map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _selectOption(option['career']);
                    },
                    child: Text(option['text']),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _selectOption(String career) {
    // Increment career score
    careerScores[career] = (careerScores[career] ?? 0) + 1;

    String currentCategory = categories[_categoryIndex];

    if (_questionIndex < assessmentData[currentCategory]!.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      if (_categoryIndex < categories.length - 1) {
        setState(() {
          _categoryIndex++;
          _questionIndex = 0;
        });
      } else {
        _showCareerResult();
      }
    }
  }

  void _showCareerResult() async {
    // Sort careers by score descending
    var sortedCareers = careerScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Get top 2 careers for better suggestion
    String topCareers = sortedCareers.take(2).map((e) => e.key).join(' & ');

    // Update Firestore
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'assessmentCompleted': true,
      });
    }

    // Navigate to result screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CareerResultScreen(topCareers: topCareers),
      ),
    );
  }
}

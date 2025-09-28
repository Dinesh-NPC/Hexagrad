import 'package:flutter/material.dart';
import '../data/assessment_data.dart';

class CareerTestScreen extends StatefulWidget {
  const CareerTestScreen({Key? key}) : super(key: key);

  @override
  State<CareerTestScreen> createState() => _CareerTestScreenState();
}

class _CareerTestScreenState extends State<CareerTestScreen> with SingleTickerProviderStateMixin {
  late List<String> categories;
  int currentCategoryIndex = 0;
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    categories = assessmentData.keys.toList();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void nextQuestion() {
    final currentCategory = categories[currentCategoryIndex];
    final totalQuestions = assessmentData[currentCategory]!.length;

    _animationController.reset();
    _animationController.forward();

    if (currentQuestionIndex < totalQuestions - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
      });
    } else if (currentCategoryIndex < categories.length - 1) {
      setState(() {
        currentCategoryIndex++;
        currentQuestionIndex = 0;
        selectedAnswer = null;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Text("🎉 "),
              Text("Assessment Completed", style: TextStyle(color: Colors.blue)),
            ],
          ),
          content: const Text(
            "You have finished the Career Assessment Test.\n\nReport will be generated soon.",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK", style: TextStyle(fontSize: 16, color: Colors.blue)),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentCategory = categories[currentCategoryIndex];
    final questions = assessmentData[currentCategory]!;
    final currentQ = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      "Career Assessment",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Progress Bar
                Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.blue.shade300],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Category and Question Count
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentCategory,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "• Q${currentQuestionIndex + 1}/${questions.length}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Question
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    currentQ["question"],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Options
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: ListView.builder(
                      itemCount: (currentQ["options"] as List).length,
                      itemBuilder: (context, i) {
                        final opt = currentQ["options"][i];
                        final isSelected = selectedAnswer == opt;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAnswer = opt;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blue : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              opt,
                              style: TextStyle(
                                fontSize: 18,
                                color: isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: selectedAnswer == null ? null : nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      "Next Question",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: selectedAnswer == null ? Colors.grey : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MentorsScreen extends StatelessWidget {
  const MentorsScreen({super.key});

  static const List<Map<String, dynamic>> mentors = [
    {
      "name": "Indira",
      "phone": "+91 9345833643 ",
      "email": "indira@gmail.com",
      "specialty": "Career Counseling",
      "rating": 4.8,
      "experience": "5 years",
    },
    {
      "name": "Kaviya Sree",
      "phone": "+91 7010941264",
      "email": "kaviya@gmail.com",
      "specialty": "Academic Advising",
      "rating": 4.9,
      "experience": "7 years",
    },
    {
      "name": "Hemadevi",
      "phone": "+91 9345761776",
      "email": "hema@gmail.com",
      "specialty": "College Applications",
      "rating": 4.7,
      "experience": "6 years",
    },
    {
      "name": "Dinesh Kumar",
      "phone": "+91 7010483576 ",
      "email": "dinesh.kumar@gmail.com",
      "specialty": "Exam Preparation",
      "rating": 4.6,
      "experience": "8 years",
    },
    {
      "name": "Jasir Ahamed",
      "phone": "+91 8778990686",
      "email": "jasir@gmail.com",
      "specialty": "Scholarship Guidance",
      "rating": 4.8,
      "experience": "4 years",
    },
    {
      "name": "Kishore Kumar",
      "phone": "+91 7094747535",
      "email": "kishore@gmail.com",
      "specialty": "Personal Development",
      "rating": 4.9,
      "experience": "10 years",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Mentors'),
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade600, Colors.blue.shade400],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Expert Mentorship Program",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Book personalized sessions with industry experts to accelerate your career growth.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: mentors.length,
              itemBuilder: (context, index) {
                final mentor = mentors[index];
                final initials = mentor['name']!.split(' ').map((e) => e[0]).join().toUpperCase();
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.grey.shade50],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.blue.shade100,
                            child: Text(
                              initials,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mentor['name']!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  mentor['specialty']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${mentor['rating']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Icon(Icons.work, color: Colors.grey, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      mentor['experience']!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        final url = Uri(scheme: 'tel', path: mentor['phone']);
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url);
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Cannot make call')),
                                          );
                                        }
                                      },
                                      icon: const Icon(Icons.call),
                                      color: Colors.green,
                                      tooltip: 'Call',
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        final url = Uri(scheme: 'mailto', path: mentor['email']);
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url);
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Cannot send email')),
                                          );
                                        }
                                      },
                                      icon: const Icon(Icons.email),
                                      color: Colors.blue,
                                      tooltip: 'Email',
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Session booked with ${mentor['name']}! Check your email for details.'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.calendar_today),
                                      color: Colors.orange,
                                      tooltip: 'Book Session',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

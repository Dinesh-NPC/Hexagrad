import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CareerResultScreen extends StatelessWidget {
  final String topCareers;

  const CareerResultScreen({super.key, required this.topCareers});

  @override
  Widget build(BuildContext context) {
    // Sample suggestions based on career
    Map<String, Map<String, List<String>>> careerSuggestions = {
      'Engineer': {
        'videos': [
          'https://www.youtube.com/watch?v=2zKa6j4b0oU - What is Engineering? (Crash Course Engineering #1)',
          'https://www.youtube.com/watch?v=9bZkp7q19f0 - Engineering Careers Explained',
        ],
        'webinars': [
          'Engineering Webinar Series by IEEE',
          'Future of Engineering Technologies',
        ],
        'workLife': [
          'Work-life balance in engineering: Flexible hours, remote work options.',
          'Average salary: ₹8-15 LPA, depending on specialization.',
          'Career growth: Opportunities in tech, manufacturing, and innovation.',
        ],
      },
      'Doctor': {
        'videos': [
          'https://www.youtube.com/watch?v=qbLe3R1fXnk - A Day in the Life of a Doctor',
          'https://www.youtube.com/watch?v=3p8EBPVZ2Iw - Medical School and Career Path',
        ],
        'webinars': [
          'Medical Webinar by AMA',
          'Advances in Healthcare',
        ],
        'workLife': [
          'Work-life balance: Shift-based, but rewarding with patient care.',
          'Average salary: ₹10-20 LPA.',
          'Career growth: Specializations, research, and hospital administration.',
        ],
      },
      'Teacher': {
        'videos': [
          'https://www.youtube.com/watch?v=UrT2eQmR5K8 - Why Teach? Career in Education',
          'https://www.youtube.com/watch?v=1uD8fO0vJ2A - Teaching as a Profession',
        ],
        'webinars': [
          'Education Webinar Series',
          'Innovative Teaching Methods',
        ],
        'workLife': [
          'Work-life balance: School hours, holidays, job security.',
          'Average salary: ₹4-8 LPA.',
          'Career growth: Promotions to principal, curriculum development.',
        ],
      },
      'Entrepreneur': {
        'videos': [
          'https://www.youtube.com/watch?v=CBYhVcO4WgI - How to Start a Startup (Y Combinator)',
          'https://www.youtube.com/watch?v=3p8EBPVZ2Iw - Startup School: How to Build a Startup',
        ],
        'webinars': [
          'Startup Webinar Series',
          'Entrepreneurship in India',
        ],
        'workLife': [
          'Work-life balance: High flexibility but demanding hours.',
          'Average salary: Variable, potential for high earnings.',
          'Career growth: Building your own business empire.',
        ],
      },
      'Leader': {
        'videos': [
          'https://www.youtube.com/watch?v=1uD8fO0vJ2A - The Skill of Self-Confidence (Dr. Ivan Joseph)',
          'https://www.youtube.com/watch?v=qbLe3R1fXnk - Why Good Leaders Make You Feel Safe (Simon Sinek)',
        ],
        'webinars': [
          'Leadership Development Webinar',
          'Effective Management Techniques',
        ],
        'workLife': [
          'Work-life balance: Leadership roles offer influence and responsibility.',
          'Average salary: ₹10-18 LPA.',
          'Career growth: Advance to executive positions.',
        ],
      },
      'Manager': {
        'videos': [
          'https://www.youtube.com/watch?v=9bZkp7q19f0 - Management Careers: What You Need to Know',
          'https://www.youtube.com/watch?v=3p8EBPVZ2Iw - Project Management Fundamentals',
        ],
        'webinars': [
          'Project Management Webinar',
          'Team Management Strategies',
        ],
        'workLife': [
          'Work-life balance: Structured roles with team coordination.',
          'Average salary: ₹7-12 LPA.',
          'Career growth: Promotions to senior management.',
        ],
      },
      'Scientist': {
        'videos': [
          'https://www.youtube.com/watch?v=2zKa6j4b0oU - Careers in Science: What Does a Scientist Do?',
          'https://www.youtube.com/watch?v=CBYhVcO4WgI - Scientific Research Careers',
        ],
        'webinars': [
          'Science Innovation Webinar',
          'Research Methodology',
        ],
        'workLife': [
          'Work-life balance: Lab-based with discovery focus.',
          'Average salary: ₹6-14 LPA.',
          'Career growth: Research leadership and publications.',
        ],
      },
      'Analyst': {
        'videos': [
          'https://www.youtube.com/watch?v=9bZkp7q19f0 - Day in the Life of a Data Analyst',
          'https://www.youtube.com/watch?v=1uD8fO0vJ2A - Analytical Skills for Career Success',
        ],
        'webinars': [
          'Data Analysis Webinar',
          'Business Intelligence Tools',
        ],
        'workLife': [
          'Work-life balance: Office-based with data focus.',
          'Average salary: ₹5-10 LPA.',
          'Career growth: Senior analyst or consultant roles.',
        ],
      },
      // Add more careers as needed
    };

    // Get suggestions for top career (take first if multiple)
    String primaryCareer = topCareers.split(' & ')[0];
    var suggestions = careerSuggestions[primaryCareer] ?? {
      'videos': ['General career videos available online.'],
      'webinars': ['Check local webinar platforms.'],
      'workLife': ['Research specific career details.'],
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Career Assessment Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recommended Career(s): $topCareers',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Suggested Videos:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...suggestions['videos']!.map((video) {
                var parts = video.split(' - ');
                var url = parts[0];
                var title = parts.length > 1 ? parts[1] : url;
                return ListTile(
                  leading: const Icon(Icons.video_library),
                  title: Text(title),
                  onTap: () async {
                    final uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cannot open video')),
                      );
                    }
                  },
                );
              }),
              const SizedBox(height: 20),
              const Text(
                'Webinars:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...suggestions['webinars']!.map((webinar) => ListTile(
                    leading: const Icon(Icons.web),
                    title: Text(webinar),
                  )),
              const SizedBox(height: 20),
              const Text(
                'Work Life Insights:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...suggestions['workLife']!.map((insight) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text('• $insight'),
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Back to home
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

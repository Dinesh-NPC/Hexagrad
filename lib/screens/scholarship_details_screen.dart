import 'package:flutter/material.dart';

class ScholarshipDetailsScreen extends StatelessWidget {
  const ScholarshipDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample scholarship data (focused on India, especially Jammu and Kashmir)
    final List<Map<String, String>> scholarships = [
      {
        'name': 'J&K Merit Scholarship',
        'description': 'Awarded to meritorious students from Jammu and Kashmir with outstanding academic performance.',
        'eligibility': 'J&K domicile, 80%+ in 12th board exams, Full-time enrollment',
        'amount': '₹50,000 per year',
      },
      {
        'name': 'National Scholarship Portal (NSP) - Post Matric',
        'description': 'Supports students from economically weaker sections pursuing higher education.',
        'eligibility': 'Indian citizen, Family income < ₹6 lakh, Minority/SC/ST/OBC categories',
        'amount': 'Up to ₹20,000 per year',
      },
      {
        'name': 'Prime Minister\'s Scholarship Scheme for Central Armed Police Forces',
        'description': 'For wards of CAPF personnel, including those from J&K.',
        'eligibility': 'Wards of CAPF personnel, 60%+ in 12th, Pursuing professional courses',
        'amount': '₹3,000 per month',
      },
      {
        'name': 'J&K State Scholarship for Professional Courses',
        'description': 'State-funded scholarships for students from J&K pursuing engineering, medicine, etc.',
        'eligibility': 'J&K domicile, Admission in professional courses, Merit-based',
        'amount': '₹1 lakh per year',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scholarship Details'),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar (placeholder for future functionality)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
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
                  hintText: "Search scholarships...",
                  prefixIcon: Icon(Icons.search, color: Colors.blue.shade400, size: 22),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                ),
              ),
            ),
            const Text(
              'Available Scholarships',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3142),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: scholarships.length,
                itemBuilder: (context, index) {
                  final scholarship = scholarships[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            scholarship['name']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            scholarship['description']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.check_circle, color: Colors.green, size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Eligibility: ${scholarship['eligibility']}',
                                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.attach_money, color: Colors.blue, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                'Amount: ${scholarship['amount']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

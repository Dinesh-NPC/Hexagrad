class College {
  final String name;
  final String location;
  final String infrastructure;
  final String placement;
  final String fees;
  final String description;

  College({
    required this.name,
    required this.location,
    required this.infrastructure,
    required this.placement,
    required this.fees,
    required this.description,
  });

  /// Converts the college attributes to a Map for comparison
  /// Excludes description for comparison
  Map<String, String> toMap() {
    return {
      "Name": name,
      "Location": location,
      "Infrastructure": infrastructure,
      "Placement": placement,
      "Fees": fees,
      // add more attributes here in the future if needed
    };
  }
}

// Simulated list of colleges
final List<College> collegesList = [
  College(
    name: "S.P. College",
    location: "Srinagar",
    infrastructure: "⭐⭐⭐⭐",
    placement: "80% placed",
    fees: "₹2,00,000 / year",
    description: "Sri Pratap College, commonly known as SP College, is an academic and professional college in Srinagar, Jammu and Kashmir, India. The college has been accredited by NAAC with an 'A+' Grade. It is the oldest institute of higher education in the Kashmir Valley.",
  ),
  College(
    name: "Central University of Kashmir",
    location: "Ganderbal",
    infrastructure: "⭐⭐⭐",
    placement: "70% placed",
    fees: "₹1,50,000 / year",
    description: "Central University of Kashmir, formerly Central University of Jammu and Kashmir, is a central university in the Ganderbal district of Jammu and Kashmir, India. It was established in March 2009 through an Act of Parliament, 'The Central Universities Act, 2009,' by the Government of India",
  ),
  College(
    name: "Baba Ghulam Shah Badshah University",
    location: "Rajauri",
    infrastructure: "⭐⭐⭐⭐",
    placement: "90% placed",
    fees: "₹2,36,000 / year",
    description: "Baba Ghulam Shah Badshah University is a state university in India which came into existence by the Act of the J&K Legislative Assembly in 2002.",
  ),
  College(
    name: "Government Degree College",
    location: "Kathua",
    infrastructure: "⭐⭐⭐⭐",
    placement: "70% placed",
    fees: "₹15,000 / year",
    description: "Government Degree College is the co-ed college in Kathua, Jammu and Kashmir, India and serves the people of Kathua district and its adjoining areas.",
  ),
  College(
    name: "Sher-e-Kashmir University of Agricultural Sciences and Technology",
    location: "Srinagar",
    infrastructure: "⭐⭐⭐⭐",
    placement: "75% placed",
    fees: "₹50,000 / year",
    description: "Sher-e-Kashmir University of Agricultural Sciences and Technology was an Agricultural University in the Indian union territory of Jammu and Kashmir. It was established in 1982 and named after Kashmiri leader Sheikh Mohammad Abdullah.",
  ),
  College(
    name: "University of Jammu",
    location: "Jammu",
    infrastructure: "⭐⭐⭐⭐⭐",
    placement: "85% placed",
    fees: "₹1,80,000 / year",
    description: "The University of Jammu is a public state university located in Jammu, Jammu and Kashmir, India. It was established in 1969 and offers various undergraduate, postgraduate, and doctoral programs.",
  ),
  College(
    name: "National Institute of Technology Srinagar",
    location: "Srinagar",
    infrastructure: "⭐⭐⭐⭐⭐",
    placement: "95% placed",
    fees: "₹2,50,000 / year",
    description: "National Institute of Technology Srinagar is a public technical university located in Srinagar, Jammu and Kashmir, India. It is one of the 31 National Institutes of Technology established by the Government of India.",
  ),
  College(
    name: "Indian Institute of Technology Jammu",
    location: "Jammu",
    infrastructure: "⭐⭐⭐⭐⭐",
    placement: "98% placed",
    fees: "₹3,00,000 / year",
    description: "Indian Institute of Technology Jammu is a public research university located in Jammu, Jammu and Kashmir, India. It is one of the eight new Indian Institutes of Technology established by the Ministry of Human Resource Development.",
  ),
  College(
    name: "Punjab Engineering College",
    location: "Chandigarh",
    infrastructure: "⭐⭐⭐⭐⭐",
    placement: "90% placed",
    fees: "₹2,20,000 / year",
    description: "Punjab Engineering College is a public research & technical institute in Chandigarh, India. It was founded in 1921 and is one of the oldest technical institutions in India.",
  ),
  College(
    name: "Guru Nanak Dev University",
    location: "Amritsar",
    infrastructure: "⭐⭐⭐⭐",
    placement: "80% placed",
    fees: "₹1,60,000 / year",
    description: "Guru Nanak Dev University is a public university located in Amritsar, Punjab, India. It was established in 1969 and is named after the first Sikh Guru, Guru Nanak Dev.",
  ),
  College(
    name: "Himachal Pradesh University",
    location: "Shimla",
    infrastructure: "⭐⭐⭐⭐",
    placement: "75% placed",
    fees: "₹1,40,000 / year",
    description: "Himachal Pradesh University is a public university located in Shimla, Himachal Pradesh, India. It was established in 1970 and offers various undergraduate and postgraduate programs.",
  ),
  College(
    name: "Punjabi University",
    location: "Patiala",
    infrastructure: "⭐⭐⭐⭐",
    placement: "78% placed",
    fees: "₹1,50,000 / year",
    description: "Punjabi University is a public university located in Patiala, Punjab, India. It was established in 1962 and is known for its focus on Punjabi language and culture.",
  ),
  College(
    name: "Central University of Punjab",
    location: "Bathinda",
    infrastructure: "⭐⭐⭐⭐",
    placement: "82% placed",
    fees: "₹1,70,000 / year",
    description: "Central University of Punjab is a central university located in Bathinda, Punjab, India. It was established in 2009 and offers various undergraduate and postgraduate programs.",
  ),
  College(
    name: "Jaypee University of Information Technology",
    location: "Waknaghat",
    infrastructure: "⭐⭐⭐⭐⭐",
    placement: "88% placed",
    fees: "₹2,80,000 / year",
    description: "Jaypee University of Information Technology is a private university located in Waknaghat, Himachal Pradesh, India. It was established in 2000 and specializes in information technology and related fields.",
  ),
  College(
    name: "Lovely Professional University",
    location: "Phagwara",
    infrastructure: "⭐⭐⭐⭐⭐",
    placement: "85% placed",
    fees: "₹2,00,000 / year",
    description: "Lovely Professional University is a private university located in Phagwara, Punjab, India. It was established in 2005 and offers a wide range of undergraduate and postgraduate programs.",
  ),
];

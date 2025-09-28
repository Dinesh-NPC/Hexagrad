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
  )
];
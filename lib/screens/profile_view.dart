import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Profile data
  bool isLoading = false;
  String? profileImageUrl;
  String? firstName, middleName, lastName, phone, email, gender;
  String? city, district, state;
  double? tenthMarks, twelfthMarks;

  @override
  void initState() {
    super.initState();
    _loadProfileView();
  }

  Future<void> _loadProfileView() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() => isLoading = true);
      try {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          final data = doc.data()!;
          setState(() {
            firstName = data['firstName'];
            middleName = data['middleName'];
            lastName = data['lastName'];
            phone = data['phone'];
            email = data['email'];
            gender = data['gender'];
            city = data['address']['city'];
            district = data['address']['district'];
            state = data['address']['state'];
            tenthMarks = data['marks']['tenth']?.toDouble();
            twelfthMarks = data['marks']['twelfth']?.toDouble();
            profileImageUrl = data['profileImageUrl'];
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading profile: $e')),
        );
      } finally {
        setState(() => isLoading = false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to view profile')),
      );
    }
  }

  Widget _buildInfoRow(String label, String? value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 20),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Expanded(
            child: Text(
              value ?? 'Not provided',
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColorDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 8,
        actions: [
          if (firstName != null) // Profile exists
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Profile(isEditMode: true)),
                ).then((_) => _loadProfileView()); // Reload after edit
              },
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : firstName == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: 0.7,
                        duration: const Duration(seconds: 2),
                        child: const Icon(Icons.person_outline, size: 80, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No profile created yet",
                        style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text("Create your profile to get started."),
                      const SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColorDark],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => Profile()),
                            ).then((_) => _loadProfileView());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text("Create Profile", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // PROFILE PHOTO
                      AnimatedOpacity(
                        opacity: profileImageUrl != null ? 1.0 : 0.8,
                        duration: const Duration(seconds: 1),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Theme.of(context).primaryColor, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage: profileImageUrl != null
                                ? NetworkImage(profileImageUrl!)
                                : const NetworkImage('https://via.placeholder.com/150?text=Profile'),
                            child: profileImageUrl == null
                                ? const Icon(Icons.person, size: 30, color: Colors.white)
                                : Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                      const Icon(Icons.edit, color: Colors.white, size: 30),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // NAME SECTION
                      AnimatedOpacity(
                        opacity: firstName != null ? 1.0 : 0.0,
                        duration: const Duration(seconds: 1),
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Theme.of(context).primaryColor.withOpacity(0.8), Theme.of(context).primaryColor],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text("Personal Information", style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                                ),
                                const SizedBox(height: 12),
                                _buildInfoRow("First Name", firstName, Icons.person),
                                _buildInfoRow("Middle Name", middleName, Icons.person),
                                _buildInfoRow("Last Name", lastName, Icons.person),
                                _buildInfoRow("Phone", phone, Icons.phone),
                                _buildInfoRow("Email", email, Icons.email),
                                _buildInfoRow("Gender", gender, Icons.wc),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ADDRESS SECTION
                      AnimatedOpacity(
                        opacity: city != null ? 1.0 : 0.0,
                        duration: const Duration(seconds: 1),
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Theme.of(context).primaryColor.withOpacity(0.8), Theme.of(context).primaryColor],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text("Address", style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                                ),
                                const SizedBox(height: 12),
                                _buildInfoRow("City", city, Icons.location_city),
                                _buildInfoRow("District", district, Icons.map),
                                _buildInfoRow("State", state, Icons.flag),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // MARKS SECTION
                      AnimatedOpacity(
                        opacity: tenthMarks != null ? 1.0 : 0.0,
                        duration: const Duration(seconds: 1),
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Theme.of(context).primaryColor.withOpacity(0.8), Theme.of(context).primaryColor],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text("Education", style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                                ),
                                const SizedBox(height: 12),
                                _buildInfoRow("10th Marks (%)", tenthMarks?.toString(), Icons.school),
                                _buildInfoRow("12th Marks (%)", twelfthMarks?.toString(), Icons.school),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}

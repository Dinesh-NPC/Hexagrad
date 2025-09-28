import 'dart:ui';
import 'package:flutter/material.dart';
import '../data/colleges_data.dart';

class CollegeExplorer extends StatelessWidget {
  const CollegeExplorer({Key? key}) : super(key: key);

  // Show college details in a modal
  void showCollegeDetails(BuildContext context, College college) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "College Details",
      pageBuilder: (context, anim1, anim2) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        college.name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(college.location,
                          style: TextStyle(color: Colors.grey[700])),
                      const SizedBox(height: 15),
                      Text(college.description),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text("Infrastructure",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(college.infrastructure),
                            ],
                          ),
                          Column(
                            children: [
                              const Text("Placement",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(college.placement),
                            ],
                          ),
                          Column(
                            children: [
                              const Text("Fees",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(college.fees),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Close"),
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (ctx, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: ScaleTransition(scale: anim1, child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  // Show comparison panel
  void showComparisonPanel(BuildContext context) {
    College? firstCollege;
    College? secondCollege;
    bool showTable = false;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Compare Colleges",
      pageBuilder: (context, anim1, anim2) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: StatefulBuilder(
            builder: (context, setStateModal) {
              // Build comparison table dynamically
              Widget buildComparisonTable(College c1, College c2) {
                // Convert College object to Map dynamically
                final Map<String, String> c1Map = {
                  'Name': c1.name,
                  'Location': c1.location,
                  'Infrastructure': c1.infrastructure,
                  'Placement': c1.placement,
                  'Fees': c1.fees,
                };

                final Map<String, String> c2Map = {
                  'Name': c2.name,
                  'Location': c2.location,
                  'Infrastructure': c2.infrastructure,
                  'Placement': c2.placement,
                  'Fees': c2.fees,
                };

                final keys = c1Map.keys.toList();

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20,
                    columns: [
                      const DataColumn(
                        label: SizedBox(
                          width: 120,
                          child: Text(
                            "Attribute",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 180,
                          child: Text(
                            c1.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            softWrap: true,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 180,
                          child: Text(
                            c2.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                    rows: keys
                        .map(
                          (key) => DataRow(
                            cells: [
                              DataCell(SizedBox(
                                  width: 120,
                                  child: Text(
                                    key,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ))),
                              DataCell(SizedBox(
                                  width: 180,
                                  child: Text(
                                    c1Map[key] ?? '',
                                    softWrap: true,
                                  ))),
                              DataCell(SizedBox(
                                  width: 180,
                                  child: Text(
                                    c2Map[key] ?? '',
                                    softWrap: true,
                                  ))),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                );
              }

              return Center(
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            "Compare Colleges",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),

                          // Dropdowns with padding
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButtonFormField<College>(
                              value: firstCollege,
                              decoration: const InputDecoration(
                                labelText: "Select First College",
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                              ),
                              items: collegesList
                                  .map((college) => DropdownMenuItem(
                                        value: college,
                                        child: Text(college.name),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setStateModal(() {
                                  firstCollege = val;
                                  showTable = false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButtonFormField<College>(
                              value: secondCollege,
                              decoration: const InputDecoration(
                                labelText: "Select Second College",
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                              ),
                              items: collegesList
                                  .map((college) => DropdownMenuItem(
                                        value: college,
                                        child: Text(college.name),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setStateModal(() {
                                  secondCollege = val;
                                  showTable = false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20),

                          ElevatedButton(
                            onPressed: (firstCollege != null &&
                                    secondCollege != null)
                                ? () => setStateModal(() => showTable = true)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 24),
                            ),
                            child: const Text("Compare"),
                          ),
                          const SizedBox(height: 20),

                          // Scrollable comparison table
                          if (showTable && firstCollege != null && secondCollege != null)
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: buildComparisonTable(
                                      firstCollege!, secondCollege!),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (ctx, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: ScaleTransition(scale: anim1, child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Colleges"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Compare button
            ElevatedButton.icon(
              onPressed: () => showComparisonPanel(context),
              icon: const Icon(Icons.compare_arrows),
              label: const Text("Compare Colleges"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            // College profiles
            Expanded(
              child: GridView.builder(
                itemCount: collegesList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.25,
                ),
                itemBuilder: (context, index) {
                  final college = collegesList[index];
                  return GestureDetector(
                    onTap: () => showCollegeDetails(context, college),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.school, size: 50, color: Colors.blue),
                          const SizedBox(height: 10),
                          Text(
                            college.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            college.location,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
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
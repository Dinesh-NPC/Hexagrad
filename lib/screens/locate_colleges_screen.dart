import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocateCollegesScreen extends StatefulWidget {
  const LocateCollegesScreen({super.key});

  @override
  State<LocateCollegesScreen> createState() => _LocateCollegesScreenState();
}

class _LocateCollegesScreenState extends State<LocateCollegesScreen> {
  late GoogleMapController mapController;

  final List<Map<String, dynamic>> colleges = [
    {
      "College Name": "Amar Singh College",
      "Mobile": "9419064621",
      "Landline": "2311674 / 2310227",
      "District": "Srinagar",
      "latitude": 34.05982,
      "longitude": 74.8076
    },
    {
      "College Name": "Government Degree College Handwara",
      "Mobile": "9419009427",
      "Landline": "01954-222308",
      "District": "Kupwara",
      "latitude": 34.4081824,
      "longitude": 74.2859868
    },
    {
      "College Name": "Gandhi Memorial College Srinagar",
      "Mobile": "0194-2471726",
      "District": "Srinagar",
      "latitude": 34.0861,
      "longitude": 74.8017
    },
    {
      "College Name": "Govt. College for Women M.A Road",
      "Mobile": "0194-2479432",
      "District": "Srinagar",
      "latitude": 34.0846,
      "longitude": 74.8053
    },
    {
      "College Name": "Govt. College For Women Nawakadal",
      "Mobile": "0194-2503456",
      "District": "Srinagar",
      "latitude": 34.0903,
      "longitude": 74.8361
    },
    {
      "College Name": "Govt. Dental College & Hospital",
      "Mobile": "0194-2504701",
      "District": "Srinagar",
      "latitude": 34.0825,
      "longitude": 74.8038
    },
    {
      "College Name": "National Institute of Technology Srinagar",
      "District": "Srinagar",
      "latitude": 34.1955,
      "longitude": 74.8691
    },
    {
      "College Name": "University of Kashmir, Kupwara Campus",
      "District": "Kupwara",
      "latitude": 34.4082,
      "longitude": 74.2859
    },
    {
      "College Name": "Government Degree College Bohipora",
      "District": "Kupwara",
      "latitude": 34.4692,
      "longitude": 74.2898
    },
    {
      "College Name": "Government Polytechnic College, Kupwara",
      "District": "Kupwara",
      "latitude": 34.4648,
      "longitude": 74.2903
    },
    {
      "College Name": "Government Women's Degree College Sulkoot",
      "District": "Kupwara",
      "latitude": 34.4692,
      "longitude": 74.2898
    },
    {
      "College Name": "Govt Degree College Sogam",
      "District": "Kupwara",
      "latitude": 34.4082,
      "longitude": 74.2859
    }
  ];

  Set<Marker> _createMarkers() {
    return colleges.map((college) {
      final lat = college['latitude'] as double;
      final lng = college['longitude'] as double;
      final name = college['College Name'] as String;
      final district = college['District'] as String;
      return Marker(
        markerId: MarkerId(name),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: name,
          snippet: district,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locate Colleges'),
        backgroundColor: Colors.blue.shade600,
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(34.0837, 74.7973), // Srinagar
          zoom: 10,
        ),
        markers: _createMarkers(),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}

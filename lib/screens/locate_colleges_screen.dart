import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocateCollegesScreen extends StatefulWidget {
  const LocateCollegesScreen({super.key});

  @override
  State<LocateCollegesScreen> createState() => _LocateCollegesScreenState();
}

class _LocateCollegesScreenState extends State<LocateCollegesScreen> {
  late GoogleMapController mapController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // ✅ Full dataset (kept from old version)
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
    },
    {
      "College Name": "Sri Pratap College (S.P. College)",
      "District": "Srinagar",
      "latitude": 34.0785,
      "longitude": 74.8090
    },
    {
      "College Name": "Government Degree College Bemina",
      "District": "Srinagar",
      "latitude": 34.0991,
      "longitude": 74.7735
    },
    {
      "College Name": "Government Degree College (Boys) Anantnag",
      "District": "Anantnag",
      "latitude": 33.7290,
      "longitude": 75.1500
    },
    {
      "College Name": "Government Women’s College Anantnag",
      "District": "Anantnag",
      "latitude": 33.7311,
      "longitude": 75.1480
    },
    {
      "College Name": "Government Degree College Ganderbal",
      "District": "Ganderbal",
      "latitude": 34.2259,
      "longitude": 74.7783
    },
    {
      "College Name": "Government Degree College Kangan",
      "District": "Ganderbal",
      "latitude": 34.2881,
      "longitude": 75.2671
    },
    {
      "College Name": "Government Degree College Budgam",
      "District": "Budgam",
      "latitude": 33.9637,
      "longitude": 74.7279
    },
    {
      "College Name": "Government Degree College Beerwah",
      "District": "Budgam",
      "latitude": 34.0216,
      "longitude": 74.5903
    },
    {
      "College Name": "Government Degree College Bandipora",
      "District": "Bandipora",
      "latitude": 34.4173,
      "longitude": 74.6439
    },
    {
      "College Name": "Government Degree College Gurez",
      "District": "Bandipora",
      "latitude": 34.6340,
      "longitude": 74.8030
    },
    {
      "College Name": "Government Degree College Pulwama",
      "District": "Pulwama",
      "latitude": 33.8740,
      "longitude": 74.8980
    },
    {
      "College Name": "Government Degree College Tral",
      "District": "Pulwama",
      "latitude": 33.9270,
      "longitude": 75.1100
    },
    {
      "College Name": "Government Degree College Shopian",
      "District": "Shopian",
      "latitude": 33.7189,
      "longitude": 74.8361
    },
    {
      "College Name": "Government Degree College Zainapora",
      "District": "Shopian",
      "latitude": 33.7132,
      "longitude": 74.9304
    },
    {
      "College Name": "Government Degree College Uri",
      "District": "Baramulla",
      "latitude": 34.0802,
      "longitude": 74.0509
    },
    {
      "College Name": "Government Degree College Sopore (Women)",
      "District": "Baramulla",
      "latitude": 34.2880,
      "longitude": 74.4723
    },
    {
      "College Name": "Government Degree College Bhaderwah",
      "District": "Doda",
      "latitude": 32.9806,
      "longitude": 75.7170
    },
    {
      "College Name": "Government Degree College Billawar",
      "District": "Kathua",
      "latitude": 32.6175,
      "longitude": 75.6402
    },
    {
      "College Name": "Government Degree College Kathua",
      "District": "Kathua",
      "latitude": 32.3690,
      "longitude": 75.5230
    },
    {
      "College Name": "Government Degree College Poonch",
      "District": "Poonch",
      "latitude": 33.7700,
      "longitude": 74.0926
    },
    {
      "College Name": "Government Degree College Rajouri",
      "District": "Rajouri",
      "latitude": 33.3865,
      "longitude": 74.3115
    },
    {
      "College Name": "Government Degree College Udhampur (Boys)",
      "District": "Udhampur",
      "latitude": 32.9300,
      "longitude": 75.1350
    },
    {
      "College Name": "Government Degree College Udhampur (Women)",
      "District": "Udhampur",
      "latitude": 32.9302,
      "longitude": 75.1372
    },
    {
      "College Name": "Government Degree College Reasi",
      "District": "Reasi",
      "latitude": 33.0810,
      "longitude": 74.8334
    },
    {
      "College Name": "Government Degree College Kishtwar",
      "District": "Kishtwar",
      "latitude": 33.3133,
      "longitude": 75.7670
    },

  
  {
    "College Name": "Presidency College, Chennai",
    "Mobile": "04428544894",
    "Landline": "04428544894",
    "District": "Chennai",
    "latitude": 13.0797,
    "longitude": 80.2824
  },
  {
    "College Name": "Queen Mary's College, Chennai",
    "Mobile": "04428444982",
    "Landline": "04428444982",
    "District": "Chennai",
    "latitude": 13.0515,
    "longitude": 80.2789
  },
  {
    "College Name": "Dr. Ambedkar Government Arts College, Vyasarpadi",
    "Mobile": "04425521117",
    "Landline": "04425521117",
    "District": "Chennai",
    "latitude": 13.1277,
    "longitude": 80.2581
  },
  {
    "College Name": "Government Arts College for Men, Nandanam",
    "Mobile": "04424350450",
    "Landline": "04424350450",
    "District": "Chennai",
    "latitude": 13.0293,
    "longitude": 80.2412
  },
  {
    "College Name": "Government Law College, Chennai",
    "Mobile": "04425360392",
    "Landline": "04425360392",
    "District": "Chennai",
    "latitude": 13.0845,
    "longitude": 80.2707
  },
  {
    "College Name": "Loyola College, Chennai",
    "Mobile": "04428178200",
    "Landline": "04428178200",
    "District": "Chennai",
    "latitude": 13.0670,
    "longitude": 80.2376
  },
  {
    "College Name": "Madras Christian College, Tambaram",
    "Mobile": "04422390675",
    "Landline": "04422390675",
    "District": "Chennai",
    "latitude": 12.9185,
    "longitude": 80.1256
  },
  {
    "College Name": "Ethiraj College for Women, Chennai",
    "Mobile": "04428279189",
    "Landline": "04428279189",
    "District": "Chennai",
    "latitude": 13.0682,
    "longitude": 80.2545
  },
  {
    "College Name": "Stella Maris College, Chennai",
    "Mobile": "04428111987",
    "Landline": "04428111987",
    "District": "Chennai",
    "latitude": 13.0394,
    "longitude": 80.2421
  },
  {
    "College Name": "Anna University, Guindy, Chennai",
    "Mobile": "04422351723",
    "Landline": "04422351723",
    "District": "Chennai",
    "latitude": 13.0109,
    "longitude": 80.2350
  },

  {
    "College Name": "Government College of Technology (GCT), Coimbatore",
    "Mobile": "04222573353",
    "Landline": "04222573353",
    "District": "Coimbatore",
    "latitude": 11.0189,
    "longitude": 76.9425
  },
  {
    "College Name": "PSG College of Technology, Coimbatore",
    "Mobile": "04222572647",
    "Landline": "04222572647",
    "District": "Coimbatore",
    "latitude": 11.0256,
    "longitude": 77.0011
  },
  {
    "College Name": "Coimbatore Institute of Technology (CIT)",
    "Mobile": "04222570403",
    "Landline": "04222570403",
    "District": "Coimbatore",
    "latitude": 11.0325,
    "longitude": 76.9515
  },
  {
    "College Name": "Kumaraguru College of Technology",
    "Mobile": "04222666111",
    "Landline": "04222666111",
    "District": "Coimbatore",
    "latitude": 11.0776,
    "longitude": 77.0028
  },
  {
    "College Name": "Sri Krishna College of Engineering and Technology",
    "Mobile": "04222670708",
    "Landline": "04222670708",
    "District": "Coimbatore",
    "latitude": 10.9014,
    "longitude": 76.9003
  },
  {
    "College Name": "Sri Ramakrishna Engineering College",
    "Mobile": "04222601905",
    "Landline": "04222601905",
    "District": "Coimbatore",
    "latitude": 11.1251,
    "longitude": 77.0144
  },
  {
    "College Name": "Karunya Institute of Technology and Sciences",
    "Mobile": "04222618000",
    "Landline": "04222618000",
    "District": "Coimbatore",
    "latitude": 10.9352,
    "longitude": 76.7395
  },
  {
    "College Name": "Dr. N.G.P. Institute of Technology",
    "Mobile": "04222666880",
    "Landline": "04222666880",
    "District": "Coimbatore",
    "latitude": 11.0805,
    "longitude": 77.0279
  },
  {
    "College Name": "Hindusthan College of Engineering and Technology",
    "Mobile": "04222666122",
    "Landline": "04222666122",
    "District": "Coimbatore",
    "latitude": 10.8730,
    "longitude": 77.0182
  },
  {
    "College Name": "Amrita Vishwa Vidyapeetham (Coimbatore Campus)",
    "Mobile": "04222684200",
    "Landline": "04222684200",
    "District": "Coimbatore",
    "latitude": 10.9005,
    "longitude": 76.9026
  },

  {
    "College Name": "Madurai Kamaraj University",
    "Mobile": "04522452170",
    "Landline": "04522452170",
    "District": "Madurai",
    "latitude": 9.9391,
    "longitude": 78.0108
  },
  {
    "College Name": "Thiagarajar College of Engineering",
    "Mobile": "04522488520",
    "Landline": "04522488520",
    "District": "Madurai",
    "latitude": 9.8824,
    "longitude": 78.0814
  },
  {
    "College Name": "The American College, Madurai",
    "Mobile": "04522458651",
    "Landline": "04522458651",
    "District": "Madurai",
    "latitude": 9.9332,
    "longitude": 78.1317
  },
  {
    "College Name": "Fatima College, Madurai",
    "Mobile": "04522448499",
    "Landline": "04522448499",
    "District": "Madurai",
    "latitude": 9.9287,
    "longitude": 78.1385
  },
  {
    "College Name": "Lady Doak College, Madurai",
    "Mobile": "04522459434",
    "Landline": "04522459434",
    "District": "Madurai",
    "latitude": 9.9381,
    "longitude": 78.1337
  },
  {
    "College Name": "Madurai Medical College",
    "Mobile": "04522402651",
    "Landline": "04522402651",
    "District": "Madurai",
    "latitude": 9.9187,
    "longitude": 78.1220
  },
  {
    "College Name": "Thiagarajar College, Madurai",
    "Mobile": "04522481759",
    "Landline": "04522481759",
    "District": "Madurai",
    "latitude": 9.9147,
    "longitude": 78.1390
  },
  {
    "College Name": "SACS MAVMM Engineering College",
    "Mobile": "04522678092",
    "Landline": "04522678092",
    "District": "Madurai",
    "latitude": 10.0075,
    "longitude": 78.2197
  },
  {
    "College Name": "P.T. Lee Chengalvaraya Naicker College of Engineering & Technology",
    "Mobile": "04522487510",
    "Landline": "04522487510",
    "District": "Madurai",
    "latitude": 9.9041,
    "longitude": 78.1442
  },
  {
    "College Name": "Velammal College of Engineering and Technology",
    "Mobile": "04522464100",
    "Landline": "04522464100",
    "District": "Madurai",
    "latitude": 9.9791,
    "longitude": 78.1978
  },
  {
    "College Name": "National Institute of Technology Tiruchirappalli (NIT Trichy)",
    "Mobile": "04312503300",
    "Landline": "04312503300",
    "District": "Tiruchirappalli",
    "latitude": 10.7598,
    "longitude": 78.8130
  },
  {
    "College Name": "Bharathidasan University, Tiruchirappalli",
    "Mobile": "04312407100",
    "Landline": "04312407100",
    "District": "Tiruchirappalli",
    "latitude": 10.7361,
    "longitude": 78.8130
  },
  {
    "College Name": "St. Joseph's College, Tiruchirappalli",
    "Mobile": "04312482800",
    "Landline": "04312482800",
    "District": "Tiruchirappalli",
    "latitude": 10.8057,
    "longitude": 78.6855
  },
  {
    "College Name": "Government Law College, Tiruchirappalli",
    "Mobile": "04312483867",
    "Landline": "04312483867",
    "District": "Tiruchirappalli",
    "latitude": 10.7993,
    "longitude": 78.6850
  },
  {
    "College Name": "Kongunadu College of Engineering and Technology",
    "Mobile": "04332233878",
    "Landline": "04332233878",
    "District": "Tiruchirappalli",
    "latitude": 11.0930,
    "longitude": 78.8139
  },
  {
    "College Name": "Indira Ganesan College of Engineering",
    "Mobile": "04312460001",
    "Landline": "04312460001",
    "District": "Tiruchirappalli",
    "latitude": 10.7256,
    "longitude": 78.7315
  },
  {
    "College Name": "Shri Angalamman College of Engineering and Technology",
    "Mobile": "04312605004",
    "Landline": "04312605004",
    "District": "Tiruchirappalli",
    "latitude": 10.9271,
    "longitude": 78.6867
  },
  {
    "College Name": "M.I.E.T. Engineering College",
    "Mobile": "04312555501",
    "Landline": "04312555501",
    "District": "Tiruchirappalli",
    "latitude": 10.8626,
    "longitude": 78.7034
  },
  {
    "College Name": "Jayaram College of Engineering and Technology",
    "Mobile": "04312675511",
    "Landline": "04312675511",
    "District": "Tiruchirappalli",
    "latitude": 10.9605,
    "longitude": 78.6594
  },
  {
    "College Name": "M.A.M. College of Engineering",
    "Mobile": "04312265550",
    "Landline": "04312265550",
    "District": "Tiruchirappalli",
    "latitude": 10.9193,
    "longitude": 78.7205
  },
  {
    "College Name": "Government Arts College, Salem",
    "Mobile": "04272416650",
    "Landline": "04272416650",
    "District": "Salem",
    "latitude": 11.6643,
    "longitude": 78.1460
  },
  {
    "College Name": "Periyar University, Salem",
    "Mobile": "04272448600",
    "Landline": "04272448600",
    "District": "Salem",
    "latitude": 11.7134,
    "longitude": 78.0777
  },
  {
    "College Name": "Sona College of Technology",
    "Mobile": "04272440554",
    "Landline": "04272440554",
    "District": "Salem",
    "latitude": 11.6537,
    "longitude": 78.1573
  },
  {
    "College Name": "Vinayaka Mission's Kirupananda Variyar Engineering College",
    "Mobile": "04272644501",
    "Landline": "04272644501",
    "District": "Salem",
    "latitude": 11.6806,
    "longitude": 78.2074
  },
  {
    "College Name": "Government College of Engineering, Salem",
    "Mobile": "04272624100",
    "Landline": "04272624100",
    "District": "Salem",
    "latitude": 11.6532,
    "longitude": 78.1569
  },
  {
    "College Name": "AVS Engineering College",
    "Mobile": "04272720000",
    "Landline": "04272720000",
    "District": "Salem",
    "latitude": 11.6587,
    "longitude": 78.1912
  },
  {
    "College Name": "Mahendra College of Engineering",
    "Mobile": "04288288216",
    "Landline": "04288288216",
    "District": "Salem",
    "latitude": 11.5308,
    "longitude": 78.0409
  },
  {
    "College Name": "Bharathiyar Institute of Engineering for Women",
    "Mobile": "04272241177",
    "Landline": "04272241177",
    "District": "Salem",
    "latitude": 11.5761,
    "longitude": 77.9759
  },
  {
    "College Name": "Ganesh College of Engineering",
    "Mobile": "04272423366",
    "Landline": "04272423366",
    "District": "Salem",
    "latitude": 11.7283,
    "longitude": 78.0910
  },
  {
    "College Name": "Knowledge Institute of Technology (KIOT)",
    "Mobile": "04272746262",
    "Landline": "04272746262",
    "District": "Salem",
    "latitude": 11.4709,
    "longitude": 77.9412
  },
  {
    "College Name": "Manonmaniam Sundaranar University",
    "Mobile": "04622507270",
    "Landline": "04622507270",
    "District": "Tirunelveli",
    "latitude": 8.6941,
    "longitude": 77.7383
  },
  {
    "College Name": "Government College of Engineering, Tirunelveli",
    "Mobile": "04622550226",
    "Landline": "04622550226",
    "District": "Tirunelveli",
    "latitude": 8.7490,
    "longitude": 77.7422
  },
  {
    "College Name": "Sarah Tucker College",
    "Mobile": "04622520614",
    "Landline": "04622520614",
    "District": "Tirunelveli",
    "latitude": 8.7177,
    "longitude": 77.7520
  },
  {
    "College Name": "St. Xavier's College, Palayamkottai",
    "Mobile": "04622560022",
    "Landline": "04622560022",
    "District": "Tirunelveli",
    "latitude": 8.7251,
    "longitude": 77.7398
  },
  {
    "College Name": "Sri Paramakalyani College, Alwarkurichi",
    "Mobile": "04634260410",
    "Landline": "04634260410",
    "District": "Tirunelveli",
    "latitude": 8.6290,
    "longitude": 77.4898
  },
  {
    "College Name": "Aditanar College of Arts and Science, Tiruchendur",
    "Mobile": "04639242021",
    "Landline": "04639242021",
    "District": "Tirunelveli",
    "latitude": 8.4994,
    "longitude": 78.1196
  },
  {
    "College Name": "Einstein College of Engineering",
    "Mobile": "04622509191",
    "Landline": "04622509191",
    "District": "Tirunelveli",
    "latitude": 8.6850,
    "longitude": 77.8236
  },
  {
    "College Name": "Francis Xavier Engineering College",
    "Mobile": "04622506565",
    "Landline": "04622506565",
    "District": "Tirunelveli",
    "latitude": 8.7257,
    "longitude": 77.7571
  },
  {
    "College Name": "Narayanaguru College of Engineering",
    "Mobile": "04635256401",
    "Landline": "04635256401",
    "District": "Tirunelveli",
    "latitude": 8.2833,
    "longitude": 77.5667
  },
  {
    "College Name": "PET Engineering College, Vallioor",
    "Mobile": "04637220221",
    "Landline": "04637220221",
    "District": "Tirunelveli",
    "latitude": 8.3690,
    "longitude": 77.6245
  },
  {
    "College Name": "Erode Sengunthar Engineering College",
    "Mobile": "9842721189",
    "Landline": "04294-232701",
    "District": "Erode",
    "latitude": 11.4102,
    "longitude": 77.6826
  },
  {
    "College Name": "Kongu Engineering College",
    "Mobile": "9443222229",
    "Landline": "04294-226555",
    "District": "Erode",
    "latitude": 11.2754,
    "longitude": 77.6078
  },
  {
    "College Name": "Bannari Amman Institute of Technology",
    "Mobile": "9894920017",
    "Landline": "04295-226000",
    "District": "Erode",
    "latitude": 11.4896,
    "longitude": 77.2761
  },
  {
    "College Name": "Vellalar College for Women",
    "Mobile": "9443214005",
    "Landline": "0424-2245766",
    "District": "Erode",
    "latitude": 11.3409,
    "longitude": 77.7172
  },
  {
    "College Name": "Nandha Engineering College",
    "Mobile": "9842734567",
    "Landline": "0424-2327802",
    "District": "Erode",
    "latitude": 11.3303,
    "longitude": 77.6783
  },
  {
    "College Name": "Government College of Engineering, Erode",
    "Mobile": "9443222334",
    "Landline": "0424-2533377",
    "District": "Erode",
    "latitude": 11.3352,
    "longitude": 77.7301
  },
  {
    "College Name": "Sri Vasavi College, Erode",
    "Mobile": "9443212567",
    "Landline": "0424-2251505",
    "District": "Erode",
    "latitude": 11.3456,
    "longitude": 77.7155
  },
  {
    "College Name": "Nandha Arts and Science College",
    "Mobile": "9842756789",
    "Landline": "0424-2328123",
    "District": "Erode",
    "latitude": 11.3255,
    "longitude": 77.6733
  },
  {
    "College Name": "Erode Arts and Science College",
    "Mobile": "9443265432",
    "Landline": "0424-2323482",
    "District": "Erode",
    "latitude": 11.3319,
    "longitude": 77.7136
  },
  {
    "College Name": "Vellalar College of Engineering and Technology",
    "Mobile": "9842223344",
    "Landline": "0424-2245767",
    "District": "Erode",
    "latitude": 11.3657,
    "longitude": 77.6938
  },
  {
    "College Name": "Vellore Institute of Technology (VIT) University",
    "Mobile": "04162282700",
    "Landline": "04162282700",
    "District": "Vellore",
    "latitude": 12.9716,
    "longitude": 79.1553
  },
  {
    "College Name": "Government College of Engineering, Vellore",
    "Mobile": "04162228430",
    "Landline": "04162228430",
    "District": "Vellore",
    "latitude": 12.9361,
    "longitude": 79.1320
  },
  {
    "College Name": "Christian Medical College, Vellore",
    "Mobile": "04162290000",
    "Landline": "04162290000",
    "District": "Vellore",
    "latitude": 12.9180,
    "longitude": 79.1322
  },
  {
    "College Name": "Thanthai Periyar Government Institute of Technology",
    "Mobile": "04162255115",
    "Landline": "04162255115",
    "District": "Vellore",
    "latitude": 12.9278,
    "longitude": 79.1365
  },
  {
    "College Name": "Jayam College of Engineering and Technology",
    "Mobile": "04162261010",
    "Landline": "04162261010",
    "District": "Vellore",
    "latitude": 12.9322,
    "longitude": 79.1389
  },
  {
    "College Name": "VELS University, Vellore Campus",
    "Mobile": "04162272345",
    "Landline": "04162272345",
    "District": "Vellore",
    "latitude": 12.9405,
    "longitude": 79.1420
  },
  {
    "College Name": "Ganesh Engineering College, Vellore",
    "Mobile": "04162254466",
    "Landline": "04162254466",
    "District": "Vellore",
    "latitude": 12.9492,
    "longitude": 79.1495
  },
  {
    "College Name": "Velammal College of Engineering and Technology, Vellore",
    "Mobile": "04162260123",
    "Landline": "04162260123",
    "District": "Vellore",
    "latitude": 12.9567,
    "longitude": 79.1510
  },
  {
    "College Name": "Kalvi Engineering College, Vellore",
    "Mobile": "04162251234",
    "Landline": "04162251234",
    "District": "Vellore",
    "latitude": 12.9621,
    "longitude": 79.1585
  },
  {
    "College Name": "Government Arts College for Women, Vellore",
    "Mobile": "04162250012",
    "Landline": "04162250012",
    "District": "Vellore",
    "latitude": 12.9680,
    "longitude": 79.1602
  },
  {
    "College Name": "PSR Engineering College, Tiruvallur",
    "Mobile": "04427142500",
    "Landline": "04427142500",
    "District": "Tiruvallur",
    "latitude": 13.2255,
    "longitude": 79.6664
  },
  {
    "College Name": "Sri Venkateswara College of Engineering, Tiruvallur",
    "Mobile": "04427146666",
    "Landline": "04427146666",
    "District": "Tiruvallur",
    "latitude": 13.1723,
    "longitude": 79.7005
  },
  {
    "College Name": "KCG College of Technology, Tiruvallur",
    "Mobile": "04427141234",
    "Landline": "04427141234",
    "District": "Tiruvallur",
    "latitude": 13.2061,
    "longitude": 79.6678
  },
  {
    "College Name": "St. Joseph's College of Engineering, Tiruvallur",
    "Mobile": "04427147890",
    "Landline": "04427147890",
    "District": "Tiruvallur",
    "latitude": 13.2450,
    "longitude": 79.6772
  },
  {
    "College Name": "SCSVMV University, Kanchipuram (near Tiruvallur)",
    "Mobile": "04427143000",
    "Landline": "04427143000",
    "District": "Tiruvallur",
    "latitude": 13.1012,
    "longitude": 79.7135
  },
  {
    "College Name": "Valliammai Engineering College, Tiruvallur",
    "Mobile": "04427145678",
    "Landline": "04427145678",
    "District": "Tiruvallur",
    "latitude": 13.1989,
    "longitude": 79.6894
  },
  {
    "College Name": "Sri Shakthi Institute of Engineering and Technology",
    "Mobile": "04427148912",
    "Landline": "04427148912",
    "District": "Tiruvallur",
    "latitude": 13.2345,
    "longitude": 79.6781
  },
  {
    "College Name": "Sri Sairam Engineering College, Tiruvallur",
    "Mobile": "04427142222",
    "Landline": "04427142222",
    "District": "Tiruvallur",
    "latitude": 13.2175,
    "longitude": 79.6907
  },
  {
    "College Name": "Velammal Engineering College, Tiruvallur",
    "Mobile": "04427140011",
    "Landline": "04427140011",
    "District": "Tiruvallur",
    "latitude": 13.2208,
    "longitude": 79.7021
  },
  {
    "College Name": "Srinivasa Engineering College, Tiruvallur",
    "Mobile": "04427141212",
    "Landline": "04427141212",
    "District": "Tiruvallur",
    "latitude": 13.2102,
    "longitude": 79.6940
  },
  {
    "College Name": "Bharathidasan College of Arts and Science, Thanjavur",
    "Mobile": "04362225111",
    "Landline": "04362225111",
    "District": "Thanjavur",
    "latitude": 10.7862,
    "longitude": 79.1380
  },
  {
    "College Name": "Government College of Engineering, Thanjavur",
    "Mobile": "04362222545",
    "Landline": "04362222545",
    "District": "Thanjavur",
    "latitude": 10.7875,
    "longitude": 79.1307
  },
  {
    "College Name": "A.V.V.M. Sri Pushpam College",
    "Mobile": "04362223678",
    "Landline": "04362223678",
    "District": "Thanjavur",
    "latitude": 10.7821,
    "longitude": 79.1372
  },
  {
    "College Name": "St. Joseph's College, Thanjavur",
    "Mobile": "04362224891",
    "Landline": "04362224891",
    "District": "Thanjavur",
    "latitude": 10.7835,
    "longitude": 79.1395
  },
  {
    "College Name": "Thanjavur Medical College",
    "Mobile": "04362221212",
    "Landline": "04362221212",
    "District": "Thanjavur",
    "latitude": 10.7850,
    "longitude": 79.1352
  },
  {
    "College Name": "Govt. College of Fine Arts, Thanjavur",
    "Mobile": "04362222111",
    "Landline": "04362222111",
    "District": "Thanjavur",
    "latitude": 10.7803,
    "longitude": 79.1401
  },
  {
    "College Name": "Bharathi College of Science and Management, Thanjavur",
    "Mobile": "04362229999",
    "Landline": "04362229999",
    "District": "Thanjavur",
    "latitude": 10.7815,
    "longitude": 79.1335
  },
  {
    "College Name": "SASTRA University, Thanjavur Campus",
    "Mobile": "04362225555",
    "Landline": "04362225555",
    "District": "Thanjavur",
    "latitude": 10.7828,
    "longitude": 79.1328
  },
  {
    "College Name": "Vivekananda College, Thanjavur",
    "Mobile": "04362224444",
    "Landline": "04362224444",
    "District": "Thanjavur",
    "latitude": 10.7840,
    "longitude": 79.1360
  },
  {
    "College Name": "Annai College of Arts and Science",
    "Mobile": "04362223333",
    "Landline": "04362223333",
    "District": "Thanjavur",
    "latitude": 10.7865,
    "longitude": 79.1385
  },
  {
    "College Name": "Government College of Engineering, Perambalur",
    "Mobile": "04328221111",
    "Landline": "04328221111",
    "District": "Perambalur",
    "latitude": 11.2301,
    "longitude": 78.8712
  },
  {
    "College Name": "Thiruvalluvar College, Perambalur",
    "Mobile": "04328223333",
    "Landline": "04328223333",
    "District": "Perambalur",
    "latitude": 11.2387,
    "longitude": 78.8650
  },
  {
    "College Name": "Anjalai Ammal Mahalingam Engineering College",
    "Mobile": "04328224444",
    "Landline": "04328224444",
    "District": "Perambalur",
    "latitude": 11.2275,
    "longitude": 78.8795
  },
  {
    "College Name": "Dr. N.G.P. Arts and Science College (Perambalur Extension)",
    "Mobile": "04328225555",
    "Landline": "04328225555",
    "District": "Perambalur",
    "latitude": 11.2332,
    "longitude": 78.8718
  },
  {
    "College Name": "Valliammai Engineering College, Perambalur Campus",
    "Mobile": "04328226666",
    "Landline": "04328226666",
    "District": "Perambalur",
    "latitude": 11.2298,
    "longitude": 78.8725
  },
  {
    "College Name": "Sriram College of Engineering",
    "Mobile": "04328227777",
    "Landline": "04328227777",
    "District": "Perambalur",
    "latitude": 11.2325,
    "longitude": 78.8750
  },
  {
    "College Name": "Government Arts and Science College, Perambalur",
    "Mobile": "04328228888",
    "Landline": "04328228888",
    "District": "Perambalur",
    "latitude": 11.2305,
    "longitude": 78.8703
  },
  {
    "College Name": "Velammal College of Engineering and Technology, Perambalur",
    "Mobile": "04328229999",
    "Landline": "04328229999",
    "District": "Perambalur",
    "latitude": 11.2312,
    "longitude": 78.8740
  },
  {
    "College Name": "Adhiyamaan College of Engineering (Perambalur Campus)",
    "Mobile": "04328220011",
    "Landline": "04328220011",
    "District": "Perambalur",
    "latitude": 11.2340,
    "longitude": 78.8732
  },
  {
    "College Name": "Maharaja College of Engineering and Technology, Perambalur",
    "Mobile": "04328220122",
    "Landline": "04328220122",
    "District": "Perambalur",
    "latitude": 11.2355,
    "longitude": 78.8765
  },
  {
    "College Name": "Annamalai University, Cuddalore Campus",
    "Mobile": "04142225888",
    "Landline": "04142225888",
    "District": "Cuddalore",
    "latitude": 11.4250,
    "longitude": 79.6521
  },
  {
    "College Name": "Chidambaram Government Arts College",
    "Mobile": "04142226666",
    "Landline": "04142226666",
    "District": "Cuddalore",
    "latitude": 11.3982,
    "longitude": 79.6963
  },
  {
    "College Name": "St. Joseph’s College of Engineering, Cuddalore",
    "Mobile": "04142227777",
    "Landline": "04142227777",
    "District": "Cuddalore",
    "latitude": 11.4501,
    "longitude": 79.6547
  },
  {
    "College Name": "Government Engineering College, Cuddalore",
    "Mobile": "04142228888",
    "Landline": "04142228888",
    "District": "Cuddalore",
    "latitude": 11.4305,
    "longitude": 79.6602
  },
  {
    "College Name": "RVS College of Engineering, Cuddalore",
    "Mobile": "04142229999",
    "Landline": "04142229999",
    "District": "Cuddalore",
    "latitude": 11.4221,
    "longitude": 79.6578
  },
  {
    "College Name": "Periyar College of Arts and Science, Cuddalore",
    "Mobile": "04142220011",
    "Landline": "04142220011",
    "District": "Cuddalore",
    "latitude": 11.4245,
    "longitude": 79.6590
  },
  {
    "College Name": "Shri Venkateswara College of Engineering, Cuddalore",
    "Mobile": "04142220122",
    "Landline": "04142220122",
    "District": "Cuddalore",
    "latitude": 11.4267,
    "longitude": 79.6612
  },
  {
    "College Name": "Muthayammal Engineering College, Cuddalore Campus",
    "Mobile": "04142220233",
    "Landline": "04142220233",
    "District": "Cuddalore",
    "latitude": 11.4288,
    "longitude": 79.6625
  },
  {
    "College Name": "KSR College of Engineering, Cuddalore Campus",
    "Mobile": "04142220344",
    "Landline": "04142220344",
    "District": "Cuddalore",
    "latitude": 11.4300,
    "longitude": 79.6640
  },
  {
    "College Name": "Government Arts College for Women, Cuddalore",
    "Mobile": "04142220455",
    "Landline": "04142220455",
    "District": "Cuddalore",
    "latitude": 11.4320,
    "longitude": 79.6655
  },
  {
    "College Name": "Annai College of Arts and Science, Nagapattinam",
    "Mobile": "04365225555",
    "Landline": "04365225555",
    "District": "Nagapattinam",
    "latitude": 10.7650,
    "longitude": 79.8445
  },
  {
    "College Name": "Government Arts College, Nagapattinam",
    "Mobile": "04365226666",
    "Landline": "04365226666",
    "District": "Nagapattinam",
    "latitude": 10.7672,
    "longitude": 79.8456
  },
  {
    "College Name": "Sankara College of Science and Commerce, Nagapattinam",
    "Mobile": "04365227777",
    "Landline": "04365227777",
    "District": "Nagapattinam",
    "latitude": 10.7688,
    "longitude": 79.8468
  },
  {
    "College Name": "Bharathidasan College, Nagapattinam",
    "Mobile": "04365228888",
    "Landline": "04365228888",
    "District": "Nagapattinam",
    "latitude": 10.7701,
    "longitude": 79.8475
  },
  {
    "College Name": "St. John’s College, Nagapattinam",
    "Mobile": "04365229999",
    "Landline": "04365229999",
    "District": "Nagapattinam",
    "latitude": 10.7715,
    "longitude": 79.8482
  },
  {
    "College Name": "Thiruvalluvar Arts and Science College, Nagapattinam",
    "Mobile": "04365220011",
    "Landline": "04365220011",
    "District": "Nagapattinam",
    "latitude": 10.7728,
    "longitude": 79.8490
  },
  {
    "College Name": "Ponnaiyah Ramajayam College, Nagapattinam Campus",
    "Mobile": "04365220122",
    "Landline": "04365220122",
    "District": "Nagapattinam",
    "latitude": 10.7740,
    "longitude": 79.8498
  },
  {
    "College Name": "Shri Shakthi Institute of Engineering and Technology, Nagapattinam",
    "Mobile": "04365220233",
    "Landline": "04365220233",
    "District": "Nagapattinam",
    "latitude": 10.7755,
    "longitude": 79.8505
  },
  {
    "College Name": "Sri Krishna College of Engineering and Technology, Nagapattinam",
    "Mobile": "04365220344",
    "Landline": "04365220344",
    "District": "Nagapattinam",
    "latitude": 10.7768,
    "longitude": 79.8512
  },
  {
    "College Name": "Government College of Education, Nagapattinam",
    "Mobile": "04365220455",
    "Landline": "04365220455",
    "District": "Nagapattinam",
    "latitude": 10.7780,
    "longitude": 79.8520
  },
  {
    "College Name": "Government Arts College, Tiruvarur",
    "Mobile": "04366221111",
    "Landline": "04366221111",
    "District": "Tiruvarur",
    "latitude": 10.7675,
    "longitude": 79.6340
  },
  {
    "College Name": "Annamalai Arts and Science College, Tiruvarur",
    "Mobile": "04366222222",
    "Landline": "04366222222",
    "District": "Tiruvarur",
    "latitude": 10.7688,
    "longitude": 79.6352
  },
  {
    "College Name": "Kamarajar Arts and Science College, Tiruvarur",
    "Mobile": "04366223333",
    "Landline": "04366223333",
    "District": "Tiruvarur",
    "latitude": 10.7701,
    "longitude": 79.6365
  },
  {
    "College Name": "Thiruvarur Institute of Technology",
    "Mobile": "04366224444",
    "Landline": "04366224444",
    "District": "Tiruvarur",
    "latitude": 10.7715,
    "longitude": 79.6378
  },
  {
    "College Name": "St. Joseph’s College, Tiruvarur",
    "Mobile": "04366225555",
    "Landline": "04366225555",
    "District": "Tiruvarur",
    "latitude": 10.7728,
    "longitude": 79.6390
  },
  {
    "College Name": "Bharathi Arts and Science College, Tiruvarur",
    "Mobile": "04366226666",
    "Landline": "04366226666",
    "District": "Tiruvarur",
    "latitude": 10.7740,
    "longitude": 79.6402
  },
  {
    "College Name": "Vivekananda College, Tiruvarur",
    "Mobile": "04366227777",
    "Landline": "04366227777",
    "District": "Tiruvarur",
    "latitude": 10.7755,
    "longitude": 79.6415
  },
  {
    "College Name": "Sri Krishna Arts and Science College, Tiruvarur",
    "Mobile": "04366228888",
    "Landline": "04366228888",
    "District": "Tiruvarur",
    "latitude": 10.7768,
    "longitude": 79.6428
  },
  {
    "College Name": "Government College of Education, Tiruvarur",
    "Mobile": "04366229999",
    "Landline": "04366229999",
    "District": "Tiruvarur",
    "latitude": 10.7780,
    "longitude": 79.6440
  },
  {
    "College Name": "PSGR College, Tiruvarur Campus",
    "Mobile": "04366220011",
    "Landline": "04366220011",
    "District": "Tiruvarur",
    "latitude": 10.7795,
    "longitude": 79.6452
  },

  {
    "College Name": "Madurai Kamaraj University",
    "Mobile": "04522451833",
    "Landline": "04522451833",
    "District": "Madurai",
    "latitude": 9.9170,
    "longitude": 78.1198
  },
  {
    "College Name": "Thiagarajar College of Engineering",
    "Mobile": "04522455444",
    "Landline": "04522455444",
    "District": "Madurai",
    "latitude": 9.9452,
    "longitude": 78.1275
  },
  {
    "College Name": "American College, Madurai",
    "Mobile": "04522453333",
    "Landline": "04522453333",
    "District": "Madurai",
    "latitude": 9.9201,
    "longitude": 78.1215
  },
  {
    "College Name": "Bharathidasan College of Arts and Science, Madurai",
    "Mobile": "04522456666",
    "Landline": "04522456666",
    "District": "Madurai",
    "latitude": 9.9225,
    "longitude": 78.1238
  },
  {
    "College Name": "Lady Doak College, Madurai",
    "Mobile": "04522457777",
    "Landline": "04522457777",
    "District": "Madurai",
    "latitude": 9.9188,
    "longitude": 78.1245
  },
  {
    "College Name": "V.V.Vanniaperumal College for Women",
    "Mobile": "04522458888",
    "Landline": "04522458888",
    "District": "Madurai",
    "latitude": 9.9212,
    "longitude": 78.1260
  },
  {
    "College Name": "Government Arts College, Madurai",
    "Mobile": "04522459999",
    "Landline": "04522459999",
    "District": "Madurai",
    "latitude": 9.9235,
    "longitude": 78.1272
  },
  {
    "College Name": "K.L.N. College of Engineering, Madurai Campus",
    "Mobile": "04522450011",
    "Landline": "04522450011",
    "District": "Madurai",
    "latitude": 9.9260,
    "longitude": 78.1285
  },
  {
    "College Name": "Thiagarajar Polytechnic College, Madurai",
    "Mobile": "04522450122",
    "Landline": "04522450122",
    "District": "Madurai",
    "latitude": 9.9282,
    "longitude": 78.1298
  },
  {
    "College Name": "Sri Meenakshi Government Arts College for Women",
    "Mobile": "04522450233",
    "Landline": "04522450233",
    "District": "Madurai",
    "latitude": 9.9305,
    "longitude": 78.1310
  },

  ];

  // ✅ Filtering by district
  List<Map<String, dynamic>> get filteredColleges {
    if (_searchQuery.isEmpty) return colleges;
    return colleges.where((college) {
      final district = college['District'].toString().toLowerCase();
      return district.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  // ✅ Markers for map
  Set<Marker> _createMarkers() {
    if (_searchQuery.isEmpty) return {};
    return filteredColleges.map((college) {
      final lat = college['latitude'] as double;
      final lng = college['longitude'] as double;
      final name = college['College Name'] as String;
      final district = college['District'] as String;
      return Marker(
        markerId: MarkerId(name),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: name, snippet: district),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    }).toSet();
  }

  // ✅ Zoom into selected college
  void _showDirections(double lat, double lng) {
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locate Colleges'),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Column(
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by District...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),

          // 📋 Colleges list
          if (filteredColleges.isNotEmpty)
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: filteredColleges.length,
                itemBuilder: (context, index) {
                  final college = filteredColleges[index];
                  final name = college['College Name'] as String;
                  final district = college['District'] as String;
                  final mobile = college['Mobile'] as String?;
                  final landline = college['Landline'] as String?;
                  final lat = college['latitude'] as double;
                  final lng = college['longitude'] as double;

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('District: $district'),
                          if (mobile != null) ...[
                            const SizedBox(height: 4),
                            Text('Mobile: $mobile'),
                          ],
                          if (landline != null) ...[
                            const SizedBox(height: 4),
                            Text('Landline: $landline'),
                          ],
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () => _showDirections(lat, lng),
                              child: const Text('Get Directions'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

          if (filteredColleges.isEmpty && _searchQuery.isNotEmpty)
            const Expanded(
              flex: 2,
              child: Center(
                child: Text('No colleges found for this district.'),
              ),
            ),

          // 🗺 Google Map
          Expanded(
            flex: 3,
            child: GoogleMap(
              onMapCreated: (controller) => mapController = controller,
              initialCameraPosition: const CameraPosition(
                target: LatLng(34.0837, 74.7973), // Srinagar
                zoom: 10,
              ),
              markers: _createMarkers(),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'screens/splash_screen.dart';
import 'screens/chatbot_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase with options for web
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize Gemini
    Gemini.init(
      apiKey: 'AIzaSyA5KVxZ0w7kCpjanGJKriDS7h0HUl1xbIY', // Replace with your actual API key
      enableDebugging: true,
    );

    runApp(const MyApp());
  } catch (e) {
    print('Initialization error: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HexaGrad',
      home: const SplashScreen(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart'; // Make sure this imports your existing HomeScreen

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  // Controllers
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _otpCtrl = TextEditingController();

  String _verificationId = "";
  bool _loading = false;
  bool _otpSent = false;

  // Toggle screens: "login", "signup", "phone"
  String _currentScreen = "login";

  // Sign Up with Email
  void _signup() async {
    setState(() => _loading = true);
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
      );
      _goToHome();
    } on FirebaseException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError("$e");
    } finally {
      setState(() => _loading = false);
    }
  }

  // Login with Email
  void _login() async {
    setState(() => _loading = true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
      );
      _goToHome();
    } on FirebaseException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError("$e");
    } finally {
      setState(() => _loading = false);
    }
  }

  // Send OTP
  void _sendOtp() async {
    setState(() => _loading = true);
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneCtrl.text.trim(),
        verificationCompleted: (cred) async {
          await _auth.signInWithCredential(cred);
          _goToHome();
        },
        verificationFailed: (e) => _showError((e is FirebaseException) ? e.message : "$e"),
        codeSent: (verificationId, _) {
          setState(() {
            _verificationId = verificationId;
            _otpSent = true;
          });
        },
        codeAutoRetrievalTimeout: (_) {},
      );
    } catch (e) {
      _showError("$e");
    } finally {
      setState(() => _loading = false);
    }
  }

  // Verify OTP
  void _verifyOtp() async {
    setState(() => _loading = true);
    try {
      PhoneAuthCredential cred = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpCtrl.text.trim(),
      );
      await _auth.signInWithCredential(cred);
      _goToHome();
    } catch (e) {
      _showError("Invalid OTP");
    } finally {
      setState(() => _loading = false);
    }
  }

  // Navigate to HomeScreen
  void _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  // Show error
  void _showError(String? msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg ?? "Error")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("HexaGrad Auth", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),

              // Tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _tabButton("Login", "login"),
                  _tabButton("Signup", "signup"),
                  _tabButton("Phone", "phone"),
                ],
              ),
              const SizedBox(height: 20),

              // Email login/signup
              if (_currentScreen == "login" || _currentScreen == "signup") ...[
                TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: "Email")),
                const SizedBox(height: 10),
                TextField(controller: _passwordCtrl, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
                const SizedBox(height: 20),
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _currentScreen == "login" ? _login : _signup,
                        child: Text(_currentScreen == "login" ? "Login" : "Sign Up"),
                      ),
              ],

              // Phone login
              if (_currentScreen == "phone") ...[
                if (!_otpSent)
                  TextField(controller: _phoneCtrl, decoration: const InputDecoration(labelText: "Phone (+91...)")),
                if (_otpSent)
                  TextField(controller: _otpCtrl, decoration: const InputDecoration(labelText: "Enter OTP")),
                const SizedBox(height: 20),
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _otpSent ? _verifyOtp : _sendOtp,
                        child: Text(_otpSent ? "Verify OTP" : "Send OTP"),
                      ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabButton(String text, String screen) {
    bool selected = _currentScreen == screen;
    return GestureDetector(
      onTap: () => setState(() {
        _currentScreen = screen;
        _otpSent = false;
        _emailCtrl.clear();
        _passwordCtrl.clear();
        _phoneCtrl.clear();
        _otpCtrl.clear();
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text, style: TextStyle(color: selected ? Colors.white : Colors.black)),
      ),
    );
  }
}

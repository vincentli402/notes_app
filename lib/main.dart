import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'firebase_option.dart'; // Import the new file
import 'screens/home_page.dart';
import 'screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  // Ensure that Firebase is initialized before the app runs
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with web support
  await FirebaseConfig.initialize(); // Call Firebase initialization from the separate file


  runApp(const NotebookApp());
}

class NotebookApp extends StatelessWidget {
  const NotebookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthCheck(),
      // home: Scaffold(
      //   body: LoginScreen(),
      // ),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  User? user;

  @override
  void initState() {
    super.initState();
    // Check for current user when app starts
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        this.user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const LoginScreen(); // Show login page if not logged in
    } else {
      return const HomePage(); // Show home page if already logged in
    }
  }
}

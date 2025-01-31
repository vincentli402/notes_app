import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:notesbook_app/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Controllers for email, password, and confirm password fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Method to handle user registration with Firebase
  Future<void> _registerUser() async {
    // Check if passwords match
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        // Create user with email and password
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        print("User registered: ${userCredential.user?.email}");

        // Check if the widget is still mounted before using the context
        if (mounted) {
          // Navigate to another screen or show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
        }
      } catch (e) {
        print("Registration failed: $e");
        // Show error message (e.g., email already in use)
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration failed: $e')),
          );
        }
      }
    } else {
      // Show error if passwords do not match
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // Left side - Form
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 50.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo
                      const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.grid_view_rounded, // Placeholder for your logo
                          size: 60,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Create an Account Title
                      const Text(
                        'Create an account',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),

                      // Email TextField
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'mail@abc.com',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password TextField
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Confirm Password TextField
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Re-enter your password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Create Account Button
                      ElevatedButton(
                        onPressed: _registerUser, // Handle create account
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.purple, // Background color
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ), // Text color
                        ),
                        child: const Text('Create account'),
                      ),

                      const SizedBox(height: 20),

                      // Already Have an Account Link
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: "Already Have an Account? ",
                            style: const TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: const TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Right side - Image and text
            Expanded(
              flex: 3,
              child: Container(
                color: const Color(0xFFFCE0CC), // Background color
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/laptop_image.png',
                        height: 300,
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Goodbye, memorization.\nHello, productivity!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

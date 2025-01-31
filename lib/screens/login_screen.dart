import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:notesbook_app/screens/sign_up.dart';
import 'package:notesbook_app/screens/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // Left Side - Image and Text
            Expanded(
              flex: 1,
              child: Container(
                color: const Color(0xFFFCE0CC),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/laptop_image.png',
                        height: 250,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Keep things easy \n        by recording it.',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Right Side - Login Form
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Logo
                        const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.grid_view_rounded,
                            size: 60,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Login to your account
                        const Text(
                          'Login to your Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // For the Google Sign-In Button
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            side:
                                const BorderSide(color: Colors.grey, width: 1),
                          ),
                          onPressed: () {
                            _googleSignIn();
                          },
                          icon: Image.asset(
                            'assets/google_logo.png',
                            height: 20,
                          ),
                          label: const Text('Continue with Google'),
                        ),

                        const SizedBox(height: 20),

                        const Divider(thickness: 1, color: Colors.grey),

                        const SizedBox(height: 20),

                        // Email Field
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'mail@abc.com',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Password Field
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Handle forgot password
                            },
                            child: const Text('Forgot Password?'),
                          ),
                        ),

                        // Remember Me & Login Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value!;
                                    });
                                  },
                                ),
                                const Text('Remember Me'),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // For the Login Button
                        ElevatedButton(
                          onPressed: () async {
                            await _loginUser();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            textStyle: const TextStyle(fontSize: 18),
                            foregroundColor: Colors.white,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text('Login'),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Register Link
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: "Not Registered Yet? ",
                              style: const TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: "Create an account",
                                  style: const TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Navigate to Sign Up Screen when clicked
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen(),
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loginUser() async {
    // Show loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logging in...')),
    );

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Ensure the widget is still mounted before using context
      if (!mounted) return;

      // Check if userCredential has a user
      if (userCredential.user != null) {
        // Navigate to the Home Page after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        // Show a success message
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Login successful!'),
              duration: Duration(seconds: 1)),
        );
      }
    } catch (e) {
      // Ensure the widget is still mounted before using context
      if (!mounted) return;
      // Show a failure message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed!')),
      );
    }
  }

  Future<void> _googleSignIn() async {
    try {
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider.addScope('email');

      // Force Google to prompt for account selection
      googleProvider.setCustomParameters({
        'prompt': 'select_account',
      });

      // Sign in with popup using FirebaseAuth
      await _auth.signInWithPopup(googleProvider);

      // Ensure the widget is still mounted before using context
      if (!mounted) return;

      // Navigate to the Home Page after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Google sign-in successful!'),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      // Show a failure message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Google sign-in failed!'),
            duration: Duration(seconds: 2)),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './home_screen.dart';
import 'package:paradox_25/main.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('https://paradox-2025.vercel.app/api/v1/auth/signIn'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token =
            data['data']['token']; // Adjust this based on your API response structure

        if (token != null) {
          await storage.write(key: 'authToken', value: token); // Store token
          // Navigate to the MainScreen or HomeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ), // Replace with your main screen
          );
        } else {
          // Handle case where token is not in the response
          print('Token not found in response');
          _showErrorDialog('Token not found in response');
        }
      } else {
        // Handle login errors
        print('Login failed: ${response.statusCode}');
        // Show an error message to the user
        String errorMessage = 'Invalid email or password'; // Default error
        if (response.body.isNotEmpty) {
          try {
            final errorData = jsonDecode(response.body);
            if (errorData['message'] != null) {
              errorMessage = errorData['message']; // Use message from backend
            }
          } catch (e) {
            print('Error decoding error response: $e');
          }
        }
        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      // Handle network errors
      print('Error: $e');
      // Show an error message to the user
      _showErrorDialog('Network error. Please try again.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double screenWidth = constraints.maxWidth;
          final double screenHeight = constraints.maxHeight;

          // Responsive scaling function
          double scale(double value) =>
              value * (screenWidth / 375); // Base width

          // Font Scaling: Clamping to reasonable values
          double fontScale = screenWidth / 375;
          fontScale = fontScale.clamp(0.8, 1.4);

          return Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/all_bg.png',
                  fit: BoxFit.cover,
                ),
              ),
              // Content
              SingleChildScrollView(
                // Added SingleChildScrollView
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.08,
                    ), // Proportional Spacing
                    // Paradox Text Image
                    SizedBox(
                      height: scale(60), // Scaled height
                      child: Image.asset(
                        'assets/images/paradox_text.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.06,
                    ), // Proportional Spacing
                    // Centered Form Content
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                      ), // Proportional Padding
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Sign In Title
                          Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: scale(28), // Scaled font size
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ), // Proportional Spacing
                          // Email TextField
                          TextField(
                            controller: _emailController,
                            style: const TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(scale(10)),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ), // Proportional Spacing
                          // Password TextField
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(scale(10)),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ), // Proportional Spacing
                          // Sign In Button
                          ElevatedButton(
                            onPressed: _signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.1),
                              foregroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(scale(30)),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    screenWidth * 0.25, // Proportional Padding
                                vertical:
                                    screenHeight * 0.02, // Proportional Padding
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: scale(18), // Scaled font size
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

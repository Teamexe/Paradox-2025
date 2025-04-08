import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './home_screen.dart';
import 'package:paradox_25/main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();
  bool showOtpField = false;
  final storage = const FlutterSecureStorage();

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  Future<void> _sendOTP() async {
    final email = _emailController.text.trim();
    final name = _nameController.text.trim();
    final password = _passwordController.text;

    // Validate inputs
    setState(() {
      _nameError = name.isEmpty ? 'Name cannot be empty' : null;
      _emailError =
          _validateCollegeEmail(email)
              ? null
              : 'Please enter your college email ID';
      _passwordError =
          password.isEmpty || password.length < 6
              ? 'Password must be at least 6 characters'
              : null;
    });

    if (_nameError != null || _emailError != null || _passwordError != null) {
      return; // Stop execution if there are validation errors
    }

    try {
      final response = await http.post(
        Uri.parse(
          'https://paradox-2025.vercel.app/api/v1/auth/signup/send-otp',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // OTP sent successfully
        setState(() {
          showOtpField = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please check your spam folder for the OTP email.'),
            duration: Duration(seconds: 3),
          ),
        );
        print('OTP sent successfully');
      } else if (response.statusCode == 409) {
        // Email already in use
        _showErrorDialog(
          'Email is already in use. Please use a different email.',
        );
      } else {
        print('Failed to send OTP: ${response.statusCode}');
        String errorMessage = 'Error sending OTP';
        if (response.body.isNotEmpty) {
          try {
            final errorData = jsonDecode(response.body);
            if (errorData['message'] != null) {
              errorMessage = errorData['message'];
            }
          } catch (e) {
            print('Error decoding error response: $e');
          }
        }
        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      print('Error: $e');
      _showErrorDialog('Network error. Please try again.');
    }
  }

  Future<void> _signUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final otp = _otpController.text.trim();

    if (!_validateCollegeEmail(email)) {
      _showErrorDialog('Please enter your college email ID.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://paradox-2025.vercel.app/api/v1/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'otp': otp,
        }),
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
      } else if (response.statusCode == 409) {
        // Email already in use
        _showErrorDialog(
          'Email is already in use. Please use a different email.',
        );
      } else {
        // Handle signup errors
        print('Signup failed: ${response.statusCode}');
        String errorMessage = 'Signup failed. Please check your details.';
        if (response.body.isNotEmpty) {
          try {
            final errorData = jsonDecode(response.body);
            if (errorData['message'] != null) {
              errorMessage = errorData['message'];
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
      _showErrorDialog('Network error. Please try again.');
    }
  }

  bool _validateCollegeEmail(String email) {
    final regex = RegExp(r'^\d{2}[a-zA-Z]{3}\d{3}@nith\.ac\.in$');
    return regex.hasMatch(email);
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

          return Stack(
            children: [
              // Background Image
              Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/all_bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Content
              SingleChildScrollView(
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
                          // Sign Up Title
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: scale(28), // Scaled font size
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ), // Proportional Spacing
                          // Name TextField
                          TextField(
                            controller: _nameController,
                            style: const TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(scale(10)),
                                borderSide: BorderSide.none,
                              ),
                              errorText: _nameError, // Show error text
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
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
                              errorText: _emailError, // Show error text
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
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
                              errorText: _passwordError, // Show error text
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ), // Proportional Spacing
                          if (showOtpField)
                            Column(
                              children: [
                                // OTP TextField
                                TextField(
                                  controller: _otpController,
                                  style: const TextStyle(color: Colors.grey),
                                  decoration: InputDecoration(
                                    labelText: 'Enter OTP',
                                    labelStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        scale(10),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.03,
                                ), // Proportional Spacing
                                // Verify Button
                                ElevatedButton(
                                  onPressed: _signUp,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white.withOpacity(
                                      0.1,
                                    ),
                                    foregroundColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        scale(30),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth *
                                          0.25, // Proportional Padding
                                      vertical:
                                          screenHeight *
                                          0.02, // Proportional Padding
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'Verify',
                                    style: TextStyle(
                                      fontSize: scale(18), // Scaled font size
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            // Get OTP Button
                            ElevatedButton(
                              onPressed: _sendOTP,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.1),
                                foregroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    scale(30),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      screenWidth *
                                      0.25, // Proportional Padding
                                  vertical:
                                      screenHeight *
                                      0.02, // Proportional Padding
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Get OTP',
                                style: TextStyle(
                                  fontSize: scale(18), // Scaled font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          SizedBox(
                            height: screenHeight * 0.05,
                          ), // Proportional Spacing
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

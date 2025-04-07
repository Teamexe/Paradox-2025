import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:paradox_25/screens/auth_choice_screen.dart';
import 'package:paradox_25/screens/splash_screen.dart';
import 'question_screen.dart';
import './sign_in_screen.dart';
import './prizes_screen.dart';
import './leaderboard_screen.dart';
import './rules_screen.dart';
import './profile_screen.dart';
import 'package:paradox_25/widgets/bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLevel1Completed = false;
  String? userName;
  int? userScore;

  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkAuthAndFetchData();
  }

  Future<void> _checkAuthAndFetchData() async {
    final token = await storage.read(key: 'authToken'); // Get token
    if (token == null) {
      // User is not logged in, redirect to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ), // Replace with your login screen
      );
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
          'https://paradox-2025.vercel.app/api/v1/home',
        ), // Replace with your API URL
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userName = data['name']; // Adjust this based on your API response
          userScore = data['score']; // Adjust this based on your API response
          isLevel1Completed =
              data['level1Completed'] ??
              false; // Adjust this based on your backend response
        });
      } else if (response.statusCode == 401) {
        // Unauthorized, token is invalid, redirect to login
        await storage.delete(key: 'authToken'); // Clear stored token
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ), // Replace with your login screen
        );
        return; // Return to prevent further execution
      } else {
        // Handle other errors
        print('Error fetching user data: ${response.statusCode}');
        _showErrorDialog('Error fetching user data'); // Use _showErrorDialog
        return; // Return to prevent further execution
      }
    } catch (e) {
      print('Error: $e');
      // Handle network errors
      _showErrorDialog(
        'Network error. Please try again.',
      ); // Use _showErrorDialog
      return; // Return to prevent further execution
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

  void _showLevelLockedDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Level Locked'),
            content: const Text(
              'Level 2 is locked. Complete Level 1 to unlock it.',
            ),
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
          double scale(double value) => value * (screenWidth / 390);

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/all_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.07),
                // Paradox logo
                SizedBox(
                  height: screenHeight * 0.07,
                  child: Image.asset(
                    'assets/images/paradox_text.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Center(
                  child: Container(
                    height: screenHeight * 0.6,
                    width: screenWidth * 0.85,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/leaderboard_list_bg.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(scale(20)),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // "Let's Begin" with Nimbus and EXE logos
                        Positioned(
                          top: screenHeight * 0.035,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/exe_logo.png',
                                height: scale(32),
                                width: scale(32),
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                "Let's Begin",
                                style: TextStyle(
                                  fontFamily: 'PixelFont',
                                  fontSize: scale(21),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Image.asset(
                                'assets/images/Nimbus_white_logo.png',
                                height: scale(32),
                                width: scale(32),
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),

                        // Profile Section
                        Positioned(
                          top: screenHeight * 0.12,
                          child: Container(
                            height: screenHeight * 0.32,
                            width: screenWidth * 0.6,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/profile_section.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(scale(15)),
                            ),
                          ),
                        ),

                        // Level 1 Button
                        Positioned(
                          top: screenHeight * 0.22,
                          child: Container(
                            width: screenWidth * 0.55,
                            height: screenHeight * 0.08,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/level_image.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(scale(10)),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => QuestionScreen(
                                          level: 1,
                                          onLevelComplete: () {
                                            setState(() {
                                              isLevel1Completed = true;
                                            });
                                          },
                                        ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: Text(
                                'Level 1',
                                style: TextStyle(
                                  fontSize: scale(35), // Increased font size
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'RaviPrakash',
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Level 2 Button
                        Positioned(
                          top: screenHeight * 0.33,
                          child: Container(
                            width: screenWidth * 0.55,
                            height: screenHeight * 0.08,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/level_image.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(scale(10)),
                            ),
                            child: ElevatedButton(
                              onPressed:
                                  isLevel1Completed
                                      ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => QuestionScreen(
                                                  level: 2,
                                                  onLevelComplete: () {
                                                    // Handle Level 2 completion
                                                  },
                                                ),
                                          ),
                                        );
                                      }
                                      : _showLevelLockedDialog, // Show dialog if locked
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: Text(
                                'Level 2',
                                style: TextStyle(
                                  fontSize: scale(35), // Increased font size
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'RaviPrakash',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

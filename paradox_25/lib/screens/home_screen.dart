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
  const HomeScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final Size size = constraints.biggest;
          final double width = size.width;
          final double height = size.height;

          // Responsive scaling function
          double scale(double value) => value * (width / 390); // Base width

          final double topSpacing = height * 0.07;
          final double logoHeight = height * 0.07;
          final double cardHeight = height * 0.6;
          final double cardWidth = width * 0.85;
          final double buttonWidth = width * 0.55;
          final double buttonHeight = height * 0.08;
          final double titleFontSize = width * 0.06;
          final double buttonFontSize = width * 0.055;

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
                SizedBox(height: topSpacing),
                // Paradox logo
                SizedBox(
                  height: logoHeight,
                  child: Image.asset(
                    'assets/images/paradox_text.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: height * 0.05),
                Center(
                  child: Container(
                    height: cardHeight,
                    width: cardWidth,
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
                        Positioned(
                          top: height * 0.035,
                          child: Text(
                            "Let's Begin",
                            style: TextStyle(
                              fontFamily: 'PixelFont',
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Profile Section
                        Positioned(
                          top: height * 0.12,
                          child: Container(
                            height: height * 0.32,
                            width: width * 0.6,
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
                          top: height * 0.22,
                          child: Container(
                            width: buttonWidth,
                            height: buttonHeight,
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
                                  fontSize: buttonFontSize,
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
                          top: height * 0.33,
                          child: Container(
                            width: buttonWidth,
                            height: buttonHeight,
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
                                      : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: Text(
                                'Level 2',
                                style: TextStyle(
                                  fontSize: buttonFontSize,
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

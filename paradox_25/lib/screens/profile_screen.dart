import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;
  int? userScore;
  String? userRank;
  String? profilePictureUrl;

  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    final token = await storage.read(key: 'authToken'); // Get token
    if (token == null) {
      // User is not logged in, redirect to login
      // ... (Your login redirection logic)
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
          userRank =
              data['rank'] ?? '#1'; // Assuming rank is provided, default to #1
          profilePictureUrl =
              data['profilePicture']; // Adjust this based on your API response
        });
      } else {
        // Handle API errors
        print('Error fetching profile data: ${response.statusCode}');
        _showErrorDialog('Error fetching profile data');
        return;
      }
    } catch (e) {
      // Handle network errors
      print('Error: $e');
      _showErrorDialog('Network error. Please try again.');
      return;
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
              value * (screenWidth / 390); // Base width

          // Font Scaling: Clamping to reasonable values
          double fontScale = screenWidth / 375;
          fontScale = fontScale.clamp(0.8, 1.4);

          return SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage('assets/images/all_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                  ), // Proportional padding
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.05,
                      ), // Spacing above paradox_text.png
                      SizedBox(
                        height: screenHeight * 0.07,
                        child: Image.asset(
                          'assets/images/paradox_text.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.1,
                      ), // Increased spacing to move the container lower
                      Stack(
                        alignment:
                            Alignment
                                .center, // Center the inner container over the outer container
                        children: [
                          // Outer Container
                          Container(
                            width:
                                screenWidth *
                                0.9, // Outer container width (greater than inner container)
                            height:
                                screenHeight *
                                0.5, // Outer container height (greater than inner container)
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/leaderboard_list_bg.png',
                                ),
                                fit: BoxFit.cover, // Cover the entire container
                              ),
                              borderRadius: BorderRadius.circular(
                                scale(25),
                              ), // Rounded corners
                            ),
                          ),
                          // Inner Container
                          Container(
                            width: screenWidth * 0.85, // Inner container width
                            padding: EdgeInsets.all(
                              screenWidth * 0.02,
                            ), // Padding for inner content
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF333333,
                              ).withOpacity(0.7), // Same background color
                              borderRadius: BorderRadius.circular(
                                scale(20),
                              ), // Rounded corners
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/profile_section.png',
                                ),
                                fit:
                                    BoxFit
                                        .fill, // Background image for inner container
                              ),
                            ),
                            child: Column(
                              children: [
                                // Profile Image
                                Container(
                                  width: screenWidth * 0.25, // Reduced width
                                  height: screenWidth * 0.25, // Reduced height
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade800,
                                      width: scale(3), // Border width
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: ClipOval(
                                    child:
                                        profilePictureUrl != null
                                            ? Image.network(
                                              profilePictureUrl!,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => const Center(
                                                    child: Text(
                                                      'Image not available',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                            )
                                            : Image.asset(
                                              'assets/images/profile_image.png',
                                              fit: BoxFit.cover,
                                            ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ), // Spacing
                                // Name
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6, // Vertical padding
                                    horizontal: 10, // Horizontal padding
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(
                                      scale(10),
                                    ), // Rounded corners
                                  ),
                                  child: Text(
                                    userName ?? 'Guest',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: fontScale * 16, // Font size
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ), // Spacing
                                // Leaderboard Box
                                _buildInfoBox(
                                  context,
                                  icon: Icons.bar_chart,
                                  iconColor: Colors.blue.shade300,
                                  value: userRank ?? '#--',
                                  label: 'LeaderBoard',
                                  fontSize: fontScale * 14, // Font size
                                ),
                                SizedBox(
                                  height: screenHeight * 0.015,
                                ), // Spacing
                                // Score Box
                                _buildInfoBox(
                                  context,
                                  icon: Icons.star,
                                  iconColor: Colors.orange.shade300,
                                  value: userScore?.toString() ?? '0',
                                  label: 'Score',
                                  fontSize: fontScale * 14, // Font size
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoBox(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
    required double fontSize,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon and Value
          Row(
            children: [
              Icon(icon, color: iconColor, size: fontSize),
              const SizedBox(width: 8),
              Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Label
          Text(
            label,
            style: TextStyle(color: Colors.black, fontSize: fontSize),
          ),
        ],
      ),
    );
  }
}

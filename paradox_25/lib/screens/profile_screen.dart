import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
                      SizedBox(height: screenHeight * 0.05),
                      SizedBox(
                        height: screenHeight * 0.07,
                        child: Image.asset(
                          'assets/images/paradox_text.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(screenWidth * 0.03),
                        decoration: BoxDecoration(
                          color: const Color(0xFF333333).withOpacity(0.7),
                          borderRadius: BorderRadius.circular(scale(30)),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/profile_section.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Profile Image
                            Container(
                              width: screenWidth * 0.35,
                              height: screenWidth * 0.35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.shade800,
                                  width: scale(5),
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
                                              (context, error, stackTrace) =>
                                                  const Center(
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
                            SizedBox(height: screenHeight * 0.025),

                            // Name
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(scale(15)),
                              ),
                              child: Text(
                                userName ?? 'Guest',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: fontScale * 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),

                            // Leaderboard Box
                            _buildInfoBox(
                              context,
                              icon: Icons.bar_chart,
                              iconColor: Colors.blue.shade300,
                              value: userRank ?? '#--',
                              label: 'LeaderBoard',
                              fontSize: fontScale * 16,
                            ),
                            SizedBox(height: screenHeight * 0.02),

                            // Score Box
                            _buildInfoBox(
                              context,
                              icon: Icons.star,
                              iconColor: Colors.orange.shade300,
                              value: userScore?.toString() ?? '0',
                              label: 'Score',
                              fontSize: fontScale * 16,
                            ),
                          ],
                        ),
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

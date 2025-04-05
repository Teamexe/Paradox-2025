import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double responsiveFont(double size) => size * screenWidth / 375;

    return Scaffold(
      body: SafeArea(
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
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/leaderboard_list_bg.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE58B87),
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/profile_section.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.03,
                            horizontal: screenWidth * 0.05,
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
                                    width: 5,
                                  ),
                                  color: Colors.white,
                                ),
                                child: ClipOval(
                                  child: Image.asset(
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
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  'Aanya',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: responsiveFont(18),
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
                                value: '#1',
                                label: 'LeaderBoard',
                                fontSize: responsiveFont(16),
                              ),
                              SizedBox(height: screenHeight * 0.02),

                              // Score Box
                              _buildInfoBox(
                                context,
                                icon: Icons.star,
                                iconColor: Colors.orange.shade300,
                                value: '220',
                                label: 'Score',
                                fontSize: responsiveFont(16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                ],
              ),
            ),
          ),
        ),
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
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}

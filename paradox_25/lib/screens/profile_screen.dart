import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Comment: Add the space background with red swirl from assets
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/all_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // PARADOX Logo
            const SizedBox(height: 60),
            // PARADOX Logo
            SizedBox(
              height: 60, // Adjusted height
              child: Image.asset('assets/images/paradox_text.png'),
            ),
            const SizedBox(height: 20),
            // Main Content Card
            Expanded(
              child: Center(
                child: Container(
                  height: 538, // Outer container height
                  width: 352, // Outer container width
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF333333).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/leaderboard_list_bg.png',
                      ), // Add the background image
                      fit:
                          BoxFit
                              .fill, // Ensure the image covers the entire container
                    ),
                  ),
                  child: Column(
                    children: [
                      // Inner container
                      Container(
                        height: 458, // Inner container height
                        width: 292, // Inner container width
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE58B87),
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/profile_section.png',
                            ), // Add the background image
                            fit:
                                BoxFit
                                    .fill, // Ensure the image covers the entire container
                          ),
                        ),
                        child: Column(
                          children: [
                            // Profile Image and Name in Circular Box
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                              ), // Add padding to move it downward
                              child: Container(
                                width:
                                    200, // Adjust the size of the circular container
                                height:
                                    200, // Ensure width and height are equal for a circle
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        Colors
                                            .grey
                                            .shade800, // Outer circle border color (black or grey)
                                    width:
                                        5, // Border width for the outer circle
                                  ),
                                  color:
                                      Colors
                                          .white, // Background color of the circular container
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Profile Image
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                              Colors
                                                  .black, // Border color for the profile image
                                          width:
                                              3, // Border width for the profile image
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/profile_image.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // Name
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Aanya',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Stats
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  // Leaderboard Position
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal:
                                          15, // Add horizontal padding for equal spacing
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween, // Distribute items evenly
                                      children: [
                                        // Icon and #1 on the left
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.bar_chart,
                                              color: Colors.blue.shade300,
                                            ),
                                            const SizedBox(width: 10),
                                            const Text(
                                              '#1',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Leaderboard text on the right
                                        const Text(
                                          'LeaderBoard',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  // Level and Score
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildStatItem(
                                          icon: Icons.trending_up,
                                          value: '15',
                                          label: 'Level',
                                          iconColor: Colors.orange,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: _buildStatItem(
                                          icon: Icons.track_changes,
                                          value: '220',
                                          label: 'Score',
                                          iconColor: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  // Coins and Attempts
                                  Row(
                                    children: [
                                      Flexible(
                                        child: _buildStatItem(
                                          icon: Icons.monetization_on,
                                          value: '15000',
                                          label: 'Coins',
                                          iconColor: Colors.amber,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ), // Reduce the width
                                      Flexible(
                                        child: _buildStatItem(
                                          icon: Icons.refresh,
                                          value: '30',
                                          label: 'Attempts',
                                          iconColor: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
    bool customIcon = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ), // Uniform padding
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15), // Uniform border radius
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Align items consistently
        children: [
          if (customIcon) ...[
            Image.asset(
              'assets/images/${label.toLowerCase()}_icon.png',
              height: 24, // Uniform icon size
              color: iconColor,
            ),
          ] else ...[
            Icon(icon, color: iconColor, size: 24), // Uniform icon size
          ],
          const SizedBox(width: 10), // Uniform spacing between icon and text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18, // Uniform font size for value
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14, // Uniform font size for label
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

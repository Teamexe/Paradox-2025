import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Background with space and red swirl
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/all_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            // Paradox Logo
            SizedBox(
              height: 60, // Adjusted height
              child: Image.asset('assets/images/paradox_text.png'),
            ),
            const SizedBox(height: 20),
            // Main Content Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent background
                borderRadius: BorderRadius.circular(30), // Rounded corners
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/leaderboard_bg.png',
                  ), // Background image
                  fit: BoxFit.none, // Keeps the image in its original size
                  alignment:
                      Alignment.topCenter, // Aligns the image to the top center
                ),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Blue crystal logo
                        Image.asset('assets/images/exe_logo.png', height: 36),
                        const SizedBox(width: 40),
                        const Text(
                          'Leaderboard',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'PixelFont', // Pixel-like font
                          ),
                        ),
                        const SizedBox(width: 42),
                        // Hexagon logo
                        Image.asset(
                          'assets/images/nimbus_blacklogo.png',
                          height: 47,
                        ),
                      ],
                    ),
                  ),
                  // Podium
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 250,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          // Podium image
                          Positioned(
                            bottom:
                                45, // Adjust this value to move the image upward
                            child: Image.asset(
                              'assets/images/leaderboard_podium.png', // Podium image
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Leaderboard list
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ), // Rounded corners
                    ),
                    child: Column(
                      children: [
                        _buildLeaderboardItem(5, 'Utkarsh', 'Level 1'),
                        const SizedBox(height: 10),
                        _buildLeaderboardItem(4, 'Harsh', 'Level 1'),
                        const SizedBox(height: 10),
                        _buildLeaderboardItem(3, 'Piyush', 'Level 1'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardItem(int rank, String name, String level) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          // Avatar placeholder
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.red, width: 2),
            ),
          ),
          const SizedBox(width: 15),
          // Name and level
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily:
                          'KdamThmorPro', // Use the custom font for the name
                    ),
                  ),
                  Text(
                    level,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Kenia', // Use the Kenia font for the level
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

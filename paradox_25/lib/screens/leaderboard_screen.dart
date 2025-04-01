import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/all_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            SizedBox(
              height: 60,
              child: Image.asset('assets/images/paradox_text.png'),
            ),
            const SizedBox(height: 20),
            Container(
              width: 374,
              height: 326,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                  image: AssetImage('assets/images/leaderboard_bg.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/exe_logo.png', height: 36),
                        const SizedBox(width: 40),
                        const Text(
                          'Leaderboard',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'PixelFont',
                          ),
                        ),
                        const SizedBox(width: 42),
                        Image.asset(
                          'assets/images/nimbus_blacklogo.png',
                          height: 47,
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 145, // Adjusted to move the podium slightly downward
                    child: Image.asset(
                      'assets/images/leaderboard_podium.png',
                      width: 280,
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // 1st Place Avatar (Center Avatar)
                  _buildPodiumAvatar(
                    top: 40, // Adjusted to move the avatar slightly downward
                    left: null,
                    right: null,
                    name: "Aanya",
                    avatarPath: 'assets/images/avatar_1.png',
                  ),
                  // Medal for 1st Place
                  Positioned(
                    top: 28, // Positioned slightly above the avatar
                    left: null,
                    right: null,
                    child: Image.asset(
                      'assets/images/medal.png', // Medal image
                      width: 40,
                      height: 40,
                    ),
                  ),
                  // 2nd Place Avatar
                  _buildPodiumAvatar(
                    top: 65, // Adjusted to move the avatar slightly downward
                    left: 60,
                    right: null,
                    name: "Sona",
                    avatarPath: 'assets/images/avatar_2.png',
                  ),
                  // 3rd Place Avatar
                  _buildPodiumAvatar(
                    top: 85, // Adjusted to move the avatar slightly downward
                    left: null,
                    right: 65,
                    name: "Anjali",
                    avatarPath: 'assets/images/avatar_3.png',
                  ),
                  // Level Buttons
                  Positioned(
                    top: 160, // Adjusted position for Level 3 button
                    left: 60, // Positioned to the left
                    child: Container(
                      width: 67.18,
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDB8A8B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Level 3',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 130, // Adjusted position for Level 2 button
                    left: null,
                    right: null,
                    child: Container(
                      width: 67.18,
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDB8A8B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Level 2',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 180, // Adjusted position for Level 4 button
                    right: 65, // Positioned to the right
                    child: Container(
                      width: 67.18,
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDB8A8B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Level 4',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Leaderboard List
            _buildLeaderboardItem(5, 'Utkarsh', 'Level 1'),
            _buildLeaderboardItem(4, 'Harsh', 'Level 1'),
            _buildLeaderboardItem(3, 'Piyush', 'Level 1'),
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumAvatar({
    double? top,
    double? left,
    double? right,
    required String name,
    required String avatarPath, // Added parameter for avatar image path
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 67,
                height: 67,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: ClipOval(
                  child: Image.asset(
                    avatarPath, // Use the passed avatar image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/india_flag.png',
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(int rank, String name, String level) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
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
                      fontSize: 20,
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

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
                  _buildPodiumAvatar(
                    top: 40,
                    left: null,
                    right: null,
                    name: "Aanya",
                    avatarPath: 'assets/images/avatar_1.png',
                  ),
                  Positioned(
                    top: 28,
                    left: null,
                    right: null,
                    child: Image.asset(
                      'assets/images/medal.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  _buildPodiumAvatar(
                    top: 65,
                    left: 60,
                    right: null,
                    name: "Sona",
                    avatarPath: 'assets/images/avatar_2.png',
                  ),
                  _buildPodiumAvatar(
                    top: 85,
                    left: null,
                    right: 65,
                    name: "Anjali",
                    avatarPath: 'assets/images/avatar_3.png',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // ✅ Wrap in Expanded to make it scrollable
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: leaderboardData.length,
                itemBuilder: (context, index) {
                  return _buildLeaderboardItem(
                    leaderboardData[index]['rank'],
                    leaderboardData[index]['name'],
                    leaderboardData[index]['level'],
                  );
                },
              ),
            ),
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
    required String avatarPath,
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
                    avatarPath,
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
      margin: const EdgeInsets.symmetric(vertical: 5),
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
                      fontFamily: 'KdamThmorPro',
                    ),
                  ),
                  Text(
                    level,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Kenia',
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

// Dummy Data for Leaderboard
final List<Map<String, dynamic>> leaderboardData = [
  {'rank': 1, 'name': 'Utkarsh', 'level': 'Level 1'},
  {'rank': 2, 'name': 'Harsh', 'level': 'Level 1'},
  {'rank': 3, 'name': 'Piyush', 'level': 'Level 1'},
  {'rank': 4, 'name': 'Ananya', 'level': 'Level 2'},
  {'rank': 5, 'name': 'Sona', 'level': 'Level 3'},
  {'rank': 6, 'name': 'Raj', 'level': 'Level 4'},
  {'rank': 7, 'name': 'Kritika', 'level': 'Level 2'},
  {'rank': 8, 'name': 'Amit', 'level': 'Level 3'},
  {'rank': 9, 'name': 'Pooja', 'level': 'Level 1'},
  {'rank': 10, 'name': 'Rohan', 'level': 'Level 4'},
];

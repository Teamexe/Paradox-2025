import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    double scale(double value) => value * (width / 390); // 390 is base width used for scaling

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/all_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: height * 0.08),
            SizedBox(
              height: height * 0.07,
              child: Image.asset('assets/images/paradox_text.png'),
            ),
            SizedBox(height: height * 0.02),
            Container(
              width: width * 0.9,
              height: height * 0.4,
              decoration: BoxDecoration(
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
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/exe_logo.png', height: height * 0.045),
                        Text(
                          'Leaderboard',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: scale(16),
                            fontFamily: 'PixelFont',
                          ),
                        ),
                        Image.asset('assets/images/Nimbus_white_logo.png', height: height * 0.06),
                      ],
                    ),
                  ),
                  Positioned(
                    top: height * 0.18,
                    child: Image.asset(
                      'assets/images/leaderboard_podium.png',
                      width: width * 0.7,
                    ),
                  ),
                  _buildPodiumAvatar(
                    top: height * 0.05,
                    name: "Aanya",
                    score: 500,
                    avatarPath: 'assets/images/avatar_1.png',
                    scale: scale,
                  ),
                  Positioned(
                    top: height * 0.04,
                    child: Image.asset(
                      'assets/images/medal.png',
                      width: width * 0.1,
                    ),
                  ),
                  _buildPodiumAvatar(
                    top: height * 0.07,
                    left: width * 0.13,
                    name: "Sona",
                    score: 450,
                    avatarPath: 'assets/images/avatar_2.png',
                    scale: scale,
                  ),
                  _buildPodiumAvatar(
                    top: height * 0.1,
                    right: width * 0.14,
                    name: "Anjali",
                    score: 400,
                    avatarPath: 'assets/images/avatar_3.png',
                    scale: scale,
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                itemCount: leaderboardData.length,
                itemBuilder: (context, index) {
                  final data = leaderboardData[index];
                  return _buildLeaderboardItem(
                    rank: data['rank'],
                    name: data['name'],
                    score: data['score'],
                    size: size,
                    scale: scale,
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
    required double top,
    double? left,
    double? right,
    required String name,
    required int? score,
    required String avatarPath,
    required double Function(double) scale,
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
                width: scale(67),
                height: scale(67),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: scale(3)),
                ),
                child: ClipOval(
                  child: Image.asset(avatarPath, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/india_flag.png',
                  width: scale(20),
                  height: scale(20),
                ),
              ),
            ],
          ),
          SizedBox(height: scale(5)),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: scale(14),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: scale(5)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: scale(8), vertical: scale(3)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(scale(8)),
            ),
            child: Text(
              'Score: ${score ?? 0}',
              style: TextStyle(
                color: Colors.white,
                fontSize: scale(10),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem({
    required int rank,
    required String name,
    required int? score,
    required Size size,
    required double Function(double) scale,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(
        horizontal: scale(12),
        vertical: scale(10),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: scale(38),
            height: scale(38),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: scale(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: scale(15)),
          Container(
            width: scale(38),
            height: scale(38),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.red, width: 2),
            ),
          ),
          SizedBox(width: scale(15)),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: scale(15),
                vertical: scale(8),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: scale(16),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'KdamThmorPro',
                    ),
                  ),
                  Text(
                    '${score ?? 0}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: scale(16),
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

// Dummy Data
final List<Map<String, dynamic>> leaderboardData = [
  {'rank': 1, 'name': 'Utkarsh', 'score': 500},
  {'rank': 2, 'name': 'Harsh', 'score': 450},
  {'rank': 3, 'name': 'Piyush', 'score': 400},
  {'rank': 4, 'name': 'Ananya', 'score': 350},
  {'rank': 5, 'name': 'Sona', 'score': 300},
  {'rank': 6, 'name': 'Raj', 'score': 250},
  {'rank': 7, 'name': 'Kritika', 'score': 200},
  {'rank': 8, 'name': 'Amit', 'score': 150},
  {'rank': 9, 'name': 'Pooja', 'score': 100},
  {'rank': 10, 'name': 'Rohan', 'score': 50},
];

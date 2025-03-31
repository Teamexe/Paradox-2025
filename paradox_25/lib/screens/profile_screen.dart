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
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            // PARADOX Logo
            const Text(
              'PARADOX',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                // Comment: Use the stencil-like font from assets
                fontFamily: 'Stencil',
              ),
            ),
            const SizedBox(height: 20),
            // Main Content Card
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: const Color(0xFF333333).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    // Profile Card
                    Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE58B87),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          // Profile Image and Name
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE5C0BE),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                // Profile Image with #1 and Flag
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 3),
                                      ),
                                      // Comment: Add the avatar image from assets
                                      child: const Center(
                                        child: Text(
                                          "A",
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      // child: Image.asset('assets/images/avatar_aanya.png'),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade800,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        '#1',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      // Comment: Add the Indian flag from assets
                                      child: Image.asset(
                                        'assets/images/india_flag.png',
                                        height: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                // Name
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                          // Stats
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                // Leaderboard Position
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.bar_chart, color: Colors.blue.shade300),
                                      const SizedBox(width: 10),
                                      const Text(
                                        '#1',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
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
                                    Expanded(
                                      child: _buildStatItem(
                                        icon: Icons.monetization_on,
                                        value: '15000',
                                        label: 'Coins',
                                        iconColor: Colors.amber,
                                        customIcon: true,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: _buildStatItem(
                                        icon: Icons.refresh,
                                        value: '30',
                                        label: 'Attempts',
                                        iconColor: Colors.blue,
                                        customIcon: true,
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          if (customIcon) ...[
            // Comment: Add custom icon from assets if needed
            Image.asset(
              'assets/images/${label.toLowerCase()}_icon.png',
              height: 24,
              color: iconColor,
            ),
          ] else ...[
            Icon(icon, color: iconColor),
          ],
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
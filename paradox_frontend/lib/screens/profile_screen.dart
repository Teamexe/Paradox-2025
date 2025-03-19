import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/space_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // PARADOX title
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                'PARADOX',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'Stencil',
                ),
              ),
            ),
            
            // Profile content
            Expanded(
              child: Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFF75049).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Profile card
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF333333),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            // Avatar section
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Color(0xFFE58B87),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Rank indicator
                                  Positioned(
                                    top: 20,
                                    right: 20,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        '#1',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  // Flag
                                  Positioned(
                                    top: 20,
                                    right: 80,
                                    child: Image.asset('assets/images/india_flag.png', width: 40),
                                  ),
                                  
                                  // Avatar
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: ClipOval(
                                      child: Image.asset('assets/images/avatar1.png', fit: BoxFit.cover),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Name
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Color(0xFFF75049), width: 2),
                              ),
                              child: Center(
                                child: Text(
                                  'Aanya',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            
                            // Stats
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  // Leaderboard position
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFCCCCCC),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.bar_chart, color: Colors.blue),
                                        SizedBox(width: 10),
                                        Text(
                                          '#1',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          'LeaderBoard',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  // Stats grid
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildStatItem(
                                          'assets/images/level_icon.png',
                                          '15',
                                          'Level',
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: _buildStatItem(
                                          'assets/images/score_icon.png',
                                          '220',
                                          'Score',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildStatItem(
                                          'assets/images/coin_icon.png',
                                          '15000',
                                          'Coins',
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: _buildStatItem(
                                          'assets/images/attempts_icon.png',
                                          '30',
                                          'Attempts',
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ParadoxBottomNavBar(currentIndex: 4),
    );
  }
  
  Widget _buildStatItem(String iconPath, String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFFCCCCCC),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(iconPath, width: 30),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
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
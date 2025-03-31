import 'package:flutter/material.dart';

class TopScorersScreen extends StatelessWidget {
  const TopScorersScreen({super.key});

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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: const Color(0xFF333333).withOpacity(0.7),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Comment: Add the blue crystal logo from assets
                        Image.asset(
                          'assets/images/crystal_logo.png',
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Top Scorers',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontFamily: 'PixelFont', // Comment: Use pixel-like font from assets
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Comment: Add the hexagon logo from assets
                        Image.asset(
                          'assets/images/hexagon_logo.png',
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  // Badges
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildLevelBadge(2, Colors.blue),
                        _buildLevelBadge(4, Colors.orange),
                        _buildLevelBadge(1, Colors.green),
                      ],
                    ),
                  ),
                  // Level Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        _buildLevelButton('Level 1'),
                        const SizedBox(height: 20),
                        _buildLevelButton('Level 2'),
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

  Widget _buildLevelBadge(int level, Color color) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.yellow, width: 3),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: color.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
              ),
            ],
          ),
          child: Center(
            child: Text(
              level.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: color.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'LEVEL UP',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLevelButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade600, width: 2),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
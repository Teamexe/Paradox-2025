import 'package:flutter/material.dart';

class PrizesScreen extends StatelessWidget {
  const PrizesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Background with the all_bg.png image
          image: DecorationImage(
            image: AssetImage(
              'assets/images/all_bg.png',
            ), // Add the background image
            fit: BoxFit.cover, // Ensure the image covers the entire screen
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            // PARADOX Logo (Image)
            SizedBox(
              height: 60, // Adjust the height of the image
              child: Image.asset(
                'assets/images/paradox_text.png', // Replace text with the image
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            // Main Content Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(
                  0xFF333333,
                ).withOpacity(0.7), // Semi-transparent background
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
                        // Blue crystal logo
                        Image.asset(
                          'assets/images/crystal_logo.png',
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Top Prizes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontFamily:
                                'PixelFont', // Use pixel-like font from assets
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Hexagon logo
                        Image.asset(
                          'assets/images/hexagon_logo.png',
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  // Prizes
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildPrize('Speaker', Colors.purple),
                        _buildPrize('Cash prize', Colors.red),
                        _buildPrize('Watch', Colors.blue),
                      ],
                    ),
                  ),
                  // Announcement
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        // Diamond icon
                        Image.asset(
                          'assets/images/diamond_icon.png',
                          height: 24,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'The prize will be announced soon',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
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

  Widget _buildPrize(String name, Color ribbonColor) {
    return Column(
      children: [
        // Medal with ribbon
        Stack(
          alignment: Alignment.topCenter,
          children: [
            // Ribbon
            Container(
              width: 60,
              height: 20,
              decoration: BoxDecoration(
                color: ribbonColor,
                border: Border.all(color: Colors.yellow, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 2, height: 18, color: Colors.yellow),
                  const SizedBox(width: 5),
                  Container(width: 2, height: 18, color: Colors.yellow),
                  const SizedBox(width: 5),
                  Container(width: 2, height: 18, color: Colors.yellow),
                ],
              ),
            ),
            // Medal
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.orange.shade800, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                // Medal image (optional)
                // child: Image.asset('assets/images/medal.png'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

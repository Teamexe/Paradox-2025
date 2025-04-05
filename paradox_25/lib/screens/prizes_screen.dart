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
              height:
                  MediaQuery.of(context).size.height *
                  0.55, // Reduced height to 55% of the screen
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(
                  0xFF333333,
                ).withOpacity(0.7), // Semi-transparent background
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
              child: Stack(
                children: [
                  // Inner container
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 377,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(
                          0.5,
                        ), // Adjust color and opacity
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(
                            50,
                          ), // Make the bottom area more curvy
                          bottomRight: Radius.circular(
                            50,
                          ), // Make the bottom area more curvy
                        ),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/prizes_bg.png',
                          ), // Add the background image
                          fit:
                              BoxFit
                                  .cover, // Ensure the image covers the entire container
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/exe_logo.png',
                              height: 36.0, // Slightly reduced height
                              width: 36.0, // Slightly reduced width
                            ),
                            const SizedBox(width: 8.0), // Uniform spacing
                            const Text(
                              'Top Prizes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontFamily:
                                    'PixelFont', // Use pixel-like font from assets
                              ),
                            ),
                            const SizedBox(width: 8.0), // Uniform spacing
                            Image.asset(
                              'assets/images/Nimbus_white_logo.png',
                              height: 36.0, // Slightly reduced height
                              width: 36.0, // Slightly reduced width
                            ),
                          ],
                        ),
                      ),
                      // Prizes
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            _buildPrize(
                              'assets/images/cash_prize.png',
                              'Cash prize',
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildPrize(
                                  'assets/images/speaker.png',
                                  'Speaker',
                                ),
                                _buildPrize('assets/images/watch.png', 'Watch'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Positioned(
                    bottom: 10, // Add a 10-pixel space from the bottom
                    left: 20, // Add a 20-pixel space from the left
                    right: 20, // Add a 20-pixel space from the right
                    child: Container(
                      height: 40,
                      width:
                          MediaQuery.of(context).size.width -
                          40, // Adjusted width
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10), // Space from the left
                          Image.asset(
                            'assets/images/Rectangle 82.png',
                            height: 22, // Slightly increased height
                            width: 21, // Slightly increased width
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            width: 10,
                          ), // Space between image and text
                          const Text(
                            'The prize will be announced soon',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Overlock', // Set font to Overlock
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrize(String imagePath, String prizeName) {
    return Column(
      children: [
        SizedBox(
          height: 100, // Keep the height unchanged
          width: 110, // Slightly increased width
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
        const SizedBox(height: 8),
        Text(
          prizeName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18, // Increased font size
            fontWeight: FontWeight.bold,
            fontFamily: 'Overlock', // Set font to Overlock
          ),
        ),
      ],
    );
  }
}

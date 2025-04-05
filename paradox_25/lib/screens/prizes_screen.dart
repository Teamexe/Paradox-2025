import 'package:flutter/material.dart';

class PrizesScreen extends StatelessWidget {
  const PrizesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth, // Full width of the screen
        height: screenHeight, // Full height of the screen
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/all_bg.png'),
            fit: BoxFit.cover, // Ensure the background image covers the screen
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Logo
                SizedBox(
                  height: 60,
                  child: Image.asset(
                    'assets/images/paradox_text.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),

                // Main card with background
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      // Background
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: screenHeight * 0.6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/leaderboard_list_bg.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Foreground content
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          // Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/exe_logo.png',
                                height: 32,
                                width: 32,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Top Prizes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontFamily: 'PixelFont',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Image.asset(
                                'assets/images/Nimbus_white_logo.png',
                                height: 32,
                                width: 32,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Inner content with inner background
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.symmetric(
                              vertical: 30,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/prizes_bg.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              children: [
                                _buildPrize(
                                  'assets/images/cash_prize.png',
                                  'Cash prize',
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildPrize(
                                      'assets/images/speaker.png',
                                      'Speaker',
                                    ),
                                    _buildPrize(
                                      'assets/images/watch.png',
                                      'Watch',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Bottom message
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/Rectangle 82.png',
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 10),
                                  const Expanded(
                                    child: Text(
                                      'The prize will be announced soon',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Overlock',
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrize(String imagePath, String prizeName) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 110,
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
        const SizedBox(height: 8),
        Text(
          prizeName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Overlock',
          ),
        ),
      ],
    );
  }
}

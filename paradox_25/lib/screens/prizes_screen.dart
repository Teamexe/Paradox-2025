import 'package:flutter/material.dart';

class PrizesScreen extends StatelessWidget {
  const PrizesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          // Responsive scaling function
          double scale(double value) =>
              value * (screenWidth / 390); // Base width

          // Responsive font size function
          double responsiveFont(double size) =>
              size * (screenWidth / 375); // Use screenWidth for scaling

          return Container(
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/all_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.03,
                    ), // Proportional Spacing
                    // Logo
                    SizedBox(
                      height: scale(60), // Scaled height
                      child: Image.asset(
                        'assets/images/paradox_text.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ), // Proportional Spacing
                    // Main card with background
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                      ), // Proportional Margin
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(scale(30)),
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
                              borderRadius: BorderRadius.circular(scale(30)),
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/leaderboard_list_bg.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          // Foreground content
                          Padding(
                            padding: EdgeInsets.all(
                              screenWidth * 0.04,
                            ), // Proportional Padding
                            child: Column(
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ), // Proportional Spacing
                                // Header
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/exe_logo.png',
                                      height: scale(32), // Scaled height
                                      width: scale(32), // Scaled width
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.02,
                                    ), // Proportional Spacing
                                    Text(
                                      'Top Prizes',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: responsiveFont(26),
                                        fontFamily: 'PixelFont',
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.02,
                                    ), // Proportional Spacing
                                    Image.asset(
                                      'assets/images/Nimbus_white_logo.png',
                                      height: scale(32), // Scaled height
                                      width: scale(32), // Scaled width
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ), // Proportional Spacing
                                // Inner content with inner background
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                        screenHeight *
                                        0.04, // Proportional Padding
                                    horizontal:
                                        screenWidth *
                                        0.04, // Proportional Padding
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      scale(30),
                                    ),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/prizes_bg.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      // Prize List
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        spacing:
                                            screenWidth *
                                            0.04, // Proportional Spacing
                                        runSpacing:
                                            screenHeight *
                                            0.02, // Proportional Spacing
                                        children: [
                                          _buildPrize(
                                            'assets/images/cash_prize.png',
                                            'Cash prize',
                                            scale, // Pass scale function
                                            screenWidth,
                                            screenHeight,
                                          ),
                                          _buildPrize(
                                            'assets/images/speaker.png',
                                            'Speaker',
                                            scale, // Pass scale function
                                            screenWidth,
                                            screenHeight,
                                          ),
                                          _buildPrize(
                                            'assets/images/watch.png',
                                            'Watch',
                                            scale, // Pass scale function
                                            screenWidth,
                                            screenHeight,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.02,
                                      ), // Proportional Spacing
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: screenHeight * 0.04,
                                ), // Proportional Spacing
                                // Bottom message
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Container(
                                    height: scale(40), // Scaled height
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(
                                        scale(20),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/Rectangle 82.png',
                                          height: scale(20), // Scaled height
                                          width: scale(20), // Scaled width
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.025,
                                        ), // Proportional Spacing
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
                                SizedBox(
                                  height: screenHeight * 0.03,
                                ), // Proportional Spacing
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
          );
        },
      ),
    );
  }

  Widget _buildPrize(
    String imagePath,
    String prizeName,
    double Function(double) scale,
    double screenWidth,
    double screenHeight,
  ) {
    return Column(
      children: [
        SizedBox(
          height: scale(100), // Scaled height
          width: scale(110), // Scaled width
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
        SizedBox(height: screenHeight * 0.01), // Proportional Spacing
        Text(
          prizeName,
          style: TextStyle(
            color: Colors.white,
            fontSize: scale(16), // Scaled font size
            fontWeight: FontWeight.bold,
            fontFamily: 'Overlock',
          ),
        ),
      ],
    );
  }
}

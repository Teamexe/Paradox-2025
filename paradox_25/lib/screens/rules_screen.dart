import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          double scale(double value) => value * (screenWidth / 390);
          double fontScale(double size) => size * (screenWidth / 375);

          return Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage('assets/images/all_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.06),
                SizedBox(
                  height: screenHeight * 0.07,
                  child: Image.asset('assets/images/paradox_text.png'),
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(
                  height: screenHeight * 0.06,
                  child: Image.asset('assets/images/RULES.png'),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Main Instruction Container
                Expanded(
                  child: Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(scale(30)),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(screenWidth * 0.04),
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(scale(20)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Instructions',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontScale(44), // Bigger title
                                fontFamily: 'Oswald',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildRuleItem(
                                    context,
                                    'Eligibility: The game is open to all.',
                                    scale,
                                    fontScale,
                                  ),
                                  _buildSpacing(screenHeight),
                                  _buildRuleItem(
                                    context,
                                    'Participation: The game must be played solo throughout all levels.',
                                    scale,
                                    fontScale,
                                  ),
                                  _buildSpacing(screenHeight),
                                  _buildRuleItem(
                                    context,
                                    'Levels: The game consists of two levels — Level 1 includes 40 image-based word guessing questions, while Level 2 contains 10 text-based riddles or puzzles.',
                                    scale,
                                    fontScale,
                                  ),
                                  _buildSpacing(screenHeight),
                                  _buildRuleItem(
                                    context,
                                    'Scoring: Each correct answer will increase the score by 50 points.',
                                    scale,
                                    fontScale,
                                  ),
                                  _buildSpacing(screenHeight),
                                  _buildRuleItem(
                                    context,
                                    'Use of Hint: Using a hint will decrease the score by 10 points.',
                                    scale,
                                    fontScale,
                                  ),
                                  _buildSpacing(screenHeight),
                                  _buildRuleItem(
                                    context,
                                    'Qualification: Only the top 50 scorers from Level 1 will be eligible to move on to Level 2.',
                                    scale,
                                    fontScale,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSpacing(double screenHeight) =>
      SizedBox(height: screenHeight * 0.025);

  Widget _buildRuleItem(
    BuildContext context,
    String text,
    double Function(double) scale,
    double Function(double) fontScale,
  ) {
    final bulletSize = scale(28); // Larger bullet
    final textSize = fontScale(22); // Larger text

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: scale(6), right: scale(10)),
          child: Icon(Icons.diamond, color: Colors.white, size: bulletSize),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: textSize,
              fontFamily: 'Overlock',
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

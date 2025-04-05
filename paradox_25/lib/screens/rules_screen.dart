import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;

    double responsiveFont(double size) => size * MediaQuery.of(context).textScaleFactor;

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

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: screenWidth * 0.9,
                  margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(screenWidth * 0.05),
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Instructions',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsiveFont(isSmallScreen ? 28 : 36),
                              fontFamily: 'Oswald',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        _buildRuleItem(
                          context,
                          'Eligibility: The game is open to all.',
                        ),
                        _buildSpacing(screenHeight),
                        _buildRuleItem(
                          context,
                          'Participation: Participants can choose to play the game in solo format or can choose their partners by choice during or at the end of level 1.',
                        ),
                        _buildSpacing(screenHeight),
                        _buildRuleItem(
                          context,
                          'Partner Matching: If any qualified candidate for level 2 from level 1 to get into a team, they will be randomly matched with another partner by the organizers.',
                        ),
                        _buildSpacing(screenHeight),
                        _buildRuleItem(
                          context,
                          'Scoring: Each correct answer will increase the score by 50 points.',
                        ),
                        _buildSpacing(screenHeight),
                        _buildRuleItem(
                          context,
                          'Use of Hint: Using hint will decrease the score by 10 points.',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Spacing widget
  Widget _buildSpacing(double screenHeight) =>
      SizedBox(height: screenHeight * 0.025);

  // Rule builder
  Widget _buildRuleItem(BuildContext context, String text) {
    final isSmallScreen = MediaQuery.of(context).size.width < 400;
    double fontSize = isSmallScreen ? 15 : 19;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5, right: 10),
          child: const Icon(Icons.diamond, color: Colors.white, size: 20),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontFamily: 'Overlock',
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}


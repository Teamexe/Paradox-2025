import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Comment: Add the space background with red swirl from assets
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/all_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            // PARADOX Logo
            SizedBox(
              height: 60, // Adjusted height
              child: Image.asset('assets/images/paradox_text.png'),
            ),
            const SizedBox(height: 20),
            // RULES Title
            SizedBox(
              height: 60, // Adjusted height
              child: Image.asset('assets/images/RULES.png'),
            ),
            const SizedBox(height: 20),

            // Main Content Card
            Expanded(
              child: Center(
                child: Container(
                  height: 571, // Set the height
                  width: 350, // Set the width
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      // Instructions
                      Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Instructions',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontFamily: 'Oswald',
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildRuleItem(
                              'Eligibility: The game is open to all.',
                            ),
                            const SizedBox(height: 20),
                            _buildRuleItem(
                              'Participation: Participants can choose to play the game in solo format or can choose their partners by choice during or at the end of level 1.',
                            ),
                            const SizedBox(height: 20),
                            _buildRuleItem(
                              'Partner Matching: If any qualified candidate for level 2 from level 1 to get into a team, they will be randomly matched with another partner by the organizers.',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleItem(String text) {
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
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }
}

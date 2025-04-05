import 'package:flutter/material.dart';
import 'question_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLevel1Completed = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    final double topSpacing = height * 0.07;
    final double logoHeight = height * 0.07;
    final double cardHeight = height * 0.6;
    final double cardWidth = width * 0.85;
    final double buttonWidth = width * 0.55;
    final double buttonHeight = height * 0.08;
    final double titleFontSize = width * 0.06;
    final double buttonFontSize = width * 0.055;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/all_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: topSpacing),
            // Paradox logo
            SizedBox(
              height: logoHeight,
              child: Image.asset(
                'assets/images/paradox_text.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: height * 0.05),
            Center(
              child: Container(
                height: cardHeight,
                width: cardWidth,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/leaderboard_list_bg.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: height * 0.035,
                      child: Text(
                        "Let's Begin",
                        style: TextStyle(
                          fontFamily: 'PixelFont',
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Profile Section
                    Positioned(
                      top: height * 0.12,
                      child: Container(
                        height: height * 0.32,
                        width: width * 0.6,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/profile_section.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    // Level 1 Button
                    Positioned(
                      top: height * 0.22,
                      child: Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/level_image.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuestionScreen(
                                  level: 1,
                                  onLevelComplete: () {
                                    setState(() {
                                      isLevel1Completed = true;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(
                            'Level 1',
                            style: TextStyle(
                              fontSize: buttonFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'RaviPrakash',
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Level 2 Button
                    Positioned(
                      top: height * 0.33,
                      child: Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/level_image.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: isLevel1Completed
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QuestionScreen(
                                        level: 2,
                                        onLevelComplete: () {
                                          // Handle Level 2 completion
                                        },
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(
                            'Level 2',
                            style: TextStyle(
                              fontSize: buttonFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'RaviPrakash',
                            ),
                          ),
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
    );
  }
}


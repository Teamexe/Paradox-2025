import 'package:flutter/material.dart';
import 'question_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLevel1Completed = false; // Track if Level 1 is completed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Ensure full width
        height: double.infinity, // Ensure full height
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/all_bg.png'),
            fit: BoxFit.cover, // Cover the entire screen
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60), // Add spacing at the top
            // Add the paradox_text.png image at the top
            SizedBox(
              height: 60, // Adjust the height of the image
              child: Image.asset(
                'assets/images/paradox_text.png', // Add the paradox_text.png image
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 40,
            ), // Add spacing between the image and buttons
            // Add spacing to lower the container
            const SizedBox(
              height: 20,
            ), // Adjust this value to move the container lower
            // Add the container with leaderboard_list_bg.png
            Center(
              child: Container(
                height: 500, // Set the height of the outer container
                width: 370, // Set the width of the outer container
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/leaderboard_list_bg.png'),
                    fit: BoxFit.fill, // Cover the entire container
                  ),
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // Add rounded corners
                ),
                child: Stack(
                  alignment: Alignment.center, // Center the buttons
                  children: [
                    // Add text "Let's Begin" at the top center
                    const Positioned(
                      top: 20, // Position the text at the top
                      child: Text(
                        "Let's Begin",
                        style: TextStyle(
                          fontFamily: 'PixelFont', // Use PixelFont
                          fontSize: 24, // Font size
                          fontWeight: FontWeight.bold, // Bold text
                          color: Colors.white, // White text color
                        ),
                      ),
                    ),
                    // Background container for Level 1 and Level 2 buttons
                    Positioned(
                      top: 100, // Position the background container
                      child: Container(
                        height: 300, // Smaller height than the outer container
                        width: 300, // Smaller width than the outer container
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/profile_section.png',
                            ),
                            fit: BoxFit.cover, // Cover the entire container
                          ),
                          borderRadius: BorderRadius.circular(
                            15,
                          ), // Rounded corners
                        ),
                      ),
                    ),
                    // Level 1 Button with background image
                    Positioned(
                      top: 150, // Position Level 1 button
                      child: Container(
                        width: 220, // Set the width of the button container
                        height: 70, // Set the height of the button container
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/level_image.png'),
                            fit: BoxFit.cover, // Cover the entire container
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ), // Rounded corners
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to Level 1 Question Screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => QuestionScreen(
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
                            backgroundColor:
                                Colors.transparent, // Transparent background
                            shadowColor: Colors.transparent, // Remove shadow
                          ),
                          child: const Text(
                            'Level 1',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Change text color to black
                              fontFamily:
                                  'RaviPrakash', // Use RaviPrakash-Regular.ttf font
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Level 2 Button with background image
                    Positioned(
                      top: 250, // Position Level 2 button below Level 1
                      child: Container(
                        width: 220, // Set the width of the button container
                        height: 70, // Set the height of the button container
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/level_image.png'),
                            fit: BoxFit.cover, // Cover the entire container
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ), // Rounded corners
                        ),
                        child: ElevatedButton(
                          onPressed:
                              isLevel1Completed
                                  ? () {
                                    // Navigate to Level 2 Question Screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => QuestionScreen(
                                              level: 2,
                                              onLevelComplete: () {
                                                // Handle Level 2 completion if needed
                                              },
                                            ),
                                      ),
                                    );
                                  }
                                  : null, // Disable button if Level 1 is not completed
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.transparent, // Transparent background
                            shadowColor: Colors.transparent, // Remove shadow
                          ),
                          child: const Text(
                            'Level 2',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Change text color to black
                              fontFamily:
                                  'RaviPrakash', // Use RaviPrakash-Regular.ttf font
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

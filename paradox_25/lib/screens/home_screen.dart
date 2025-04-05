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
                width: 370, 
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/leaderboard_list_bg.png'),
                    fit: BoxFit.fill, 
                  ),
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center, 
                  children: [
                   
                    const Positioned(
                      top: 20, 
                      child: Text(
                        "Let's Begin",
                        style: TextStyle(
                          fontFamily: 'PixelFont', 
                          fontSize: 24,
                          fontWeight: FontWeight.bold, 
                          color: Colors.white, 
                        ),
                      ),
                    ),
                  
                    Positioned(
                      top: 100, 
                      child: Container(
                        height: 300, 
                        width: 300, 
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/profile_section.png',
                            ),
                            fit: BoxFit.cover, 
                          ),
                          borderRadius: BorderRadius.circular(
                            15,
                          ), 
                        ),
                      ),
                    ),
                   
                    Positioned(
                      top: 150, 
                      child: Container(
                        width: 220, 
                        height: 70, 
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/level_image.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ), 
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                           
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
                                Colors.transparent, 
                            shadowColor: Colors.transparent, 
                          ),
                          child: const Text(
                            'Level 1',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, 
                              fontFamily:
                                  'RaviPrakash', 
                            ),
                          ),
                        ),
                      ),
                    ),
                
                    Positioned(
                      top: 250, 
                      child: Container(
                        width: 220, 
                        height: 70, 
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/level_image.png'),
                            fit: BoxFit.cover, 
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ), 
                        ),
                        child: ElevatedButton(
                          onPressed:
                              isLevel1Completed
                                  ? () {
                                    
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => QuestionScreen(
                                              level: 2,
                                              onLevelComplete: () {
                                                
                                              },
                                            ),
                                      ),
                                    );
                                  }
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.transparent, 
                            shadowColor: Colors.transparent, 
                          ),
                          child: const Text(
                            'Level 2',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, 
                              fontFamily:
                                  'RaviPrakash', 
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

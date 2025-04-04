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
      appBar: AppBar(title: const Text('Home'), backgroundColor: Colors.blue),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/all_bg.png',
            ), // Set background image
            fit: BoxFit.cover, // Cover the entire screen
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
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
                                isLevel1Completed =
                                    true; // Mark Level 1 as completed
                              });
                            },
                          ),
                    ),
                  );
                },
                child: const Text('Level 1'),
              ),
              ElevatedButton(
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
                child: const Text('Level 2 (Locked)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

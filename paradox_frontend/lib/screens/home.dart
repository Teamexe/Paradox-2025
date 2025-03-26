import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_paradox.png', // Home screen background
              fit: BoxFit.cover,
            ),
          ),

          // Center Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Paradox Logo
                SizedBox(
                  height: 200,
                  child: Image.asset('assets/images/paradox_logo.png'),
                ),
                const SizedBox(height: 20),

                // Double-Colored "PARADOX" Text
                Stack(
                  children: [
                    // Shadow Effect
                    Positioned(
                      top: 2,
                      left: 2,
                      child: Text(
                        'PARADOX',
                        style: TextStyle(
                          fontFamily: 'Stencil',
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700, // Shadow
                        ),
                      ),
                    ),
                    // Main Text
                    const Text(
                      'PARADOX',
                      style: TextStyle(
                        fontFamily: 'Stencil',
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ParadoxBottomNavBar(currentIndex: 0),
    );
  }
}

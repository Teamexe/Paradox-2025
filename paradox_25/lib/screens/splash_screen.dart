import 'package:flutter/material.dart';
import '../main.dart'; // Import MainScreen

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/home_bg.png',
              fit: BoxFit.cover, // Ensures full-screen coverage
            ),
          ),

          // Centered Content
          Center(
            child: Transform.translate(
              offset: const Offset(0, -120), // Moves everything upward
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Paradox Logo (inside the vortex)
                  SizedBox(
                    height: 400, // Adjusted size
                    child: Image.asset('assets/images/paradox_logo.png'),
                  ),

                  const SizedBox(height: 10), // Reduced space
                  // Paradox Text
                  SizedBox(
                    height: 60, // Adjusted height
                    child: Image.asset('assets/images/paradox_text.png'),
                  ),

                  const SizedBox(height: 30), // Reduced space
                  // Google Sign-In Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to MainScreen (with navigation bar)
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );
                      },
                      icon: SizedBox(
                        height: 24,
                        width: 24,
                        child: Image.asset('assets/images/google_logo.png'),
                      ),
                      label: const Text(
                        'Google',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white.withOpacity(
                          0.1,
                        ), // Transparency
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 16,
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

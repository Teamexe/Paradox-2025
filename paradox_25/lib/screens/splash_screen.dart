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
              offset: const Offset(0, -80), // Adjusted offset to move content lower
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

                  const SizedBox(height: 50), // Increased space to move buttons lower
                  // Sign In Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Sign In Screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(), // Replace with SignInScreen
                          ),
                        );
                      },
                      child: const Text(
                        'Sign In',
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

                  const SizedBox(height: 20), // Space between buttons

                  // Sign Up Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Sign Up Screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(), // Replace with SignUpScreen
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
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

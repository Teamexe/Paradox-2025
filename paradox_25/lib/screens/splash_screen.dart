import 'package:flutter/material.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/home_bg.png', fit: BoxFit.cover),
          ),
          Center(
            child: Transform.translate(
              offset: const Offset(0, -80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Paradox Logo
                  SizedBox(
                    height: 400,
                    child: Image.asset('assets/images/paradox_logo.png'),
                  ),
                  const SizedBox(height: 10),
                  // Paradox Text
                  SizedBox(
                    height: 60,
                    child: Image.asset('assets/images/paradox_text.png'),
                  ),
                  const SizedBox(height: 50),
                  // Sign In Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to SignInScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(
                          0.1,
                        ), // Transparent background
                        foregroundColor:
                            Colors.grey.shade300, // Greyish white text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 120, // Increased width
                          vertical: 18, // Increased height
                        ),
                        elevation: 0, // Remove shadow
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Sign Up Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to SignUpScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(
                          0.1,
                        ), // Transparent background
                        foregroundColor:
                            Colors.grey.shade300, // Greyish white text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 120, // Increased width
                          vertical: 18, // Increased height
                        ),
                        elevation: 0, // Remove shadow
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
    );
  }
}

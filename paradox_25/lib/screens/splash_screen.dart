import 'package:flutter/material.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    double fontScale = screenWidth / 375;
    fontScale = fontScale.clamp(0.8, 1.4);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset('assets/images/home_bg.png', fit: BoxFit.cover),
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              child: Transform.translate(
                offset: Offset(
                  0,
                  screenHeight * 0.1,
                ), // Adjusted offset to move content further down
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Removed Paradox Logo
                    SizedBox(
                      height: screenHeight * 0.15,
                    ), // Increased spacing to move Paradox Text downward
                    // Paradox Text
                    SizedBox(
                      height: screenHeight * 0.08,
                      child: Image.asset('assets/images/paradox_text.png'),
                    ),

                    SizedBox(
                      height: screenHeight * 0.1,
                    ), // Spacing between Paradox Text and buttons
                    // Sign In Button
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.1),
                          foregroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.2,
                            vertical: screenHeight * 0.022,
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 18 * fontScale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.04,
                    ), // Spacing between buttons
                    // Sign Up Button
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.1),
                          foregroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.2,
                            vertical: screenHeight * 0.022,
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18 * fontScale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import './sign_in_screen.dart';
import './sign_up_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double screenWidth = constraints.maxWidth;
          final double screenHeight = constraints.maxHeight;

          // Responsive scaling function
          double scale(double value) =>
              value * (screenWidth / 390); // Base width

          // Font Scaling: Clamping to reasonable values
          double fontScale = screenWidth / 375;
          fontScale = fontScale.clamp(0.8, 1.4);

          return Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/first.png',
                  fit: BoxFit.cover,
                ),
              ),
              // Content
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Align content to the top
                    children: [
                      SizedBox(
                        height:
                            screenHeight *
                            0.2, // Add vertical spacing to push content lower
                      ),
                      // Paradox Text Image
                      SizedBox(
                        height: scale(80), // Scaled height
                        child: Image.asset('assets/images/paradox_text.png'),
                      ),
                      SizedBox(
                        height:
                            screenHeight *
                            0.05, // Reduced spacing between image and button
                      ),
                      // Sign In Button
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                        ), // Proportional Padding
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
                              borderRadius: BorderRadius.circular(scale(30)),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  screenWidth *
                                  0.2, // Proportional Horizontal Padding
                              vertical:
                                  screenHeight *
                                  0.022, // Proportional Vertical Padding
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: fontScale * 18, // Scaled font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.04, // Proportional Spacing
                      ),
                      // Sign Up Button
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                        ), // Proportional Padding
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
                              borderRadius: BorderRadius.circular(scale(30)),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  screenWidth *
                                  0.2, // Proportional Horizontal Padding
                              vertical:
                                  screenHeight *
                                  0.022, // Proportional Vertical Padding
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: fontScale * 18, // Scaled font size
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
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../main.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/all_bg.png',
              fit: BoxFit.cover, // Cover the entire screen
            ),
          ),
          // Content
          Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Align content to the top
            children: [
              const SizedBox(height: 40), // Spacing from the top
              // Paradox Text Image
              SizedBox(
                height: 60, // Adjust the height of the image
                child: Image.asset(
                  'assets/images/paradox_text.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 30), // Increased spacing below the image
              // Centered Form Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Sign In Title
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey, // Greyish white color
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ), // Adjusted spacing below the title
                    // Email TextField
                    TextField(
                      style: const TextStyle(
                        color: Colors.grey, // Whitish grey text color
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          color: Colors.grey, // Whitish grey label color
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(
                          0.1,
                        ), // Transparent background
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none, // No border
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ), // Adjusted spacing between fields
                    // Password TextField
                    TextField(
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.grey, // Whitish grey text color
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: Colors.grey, // Whitish grey label color
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(
                          0.1,
                        ), // Transparent background
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none, // No border
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ), // Adjusted spacing before the button
                    // Sign In Button
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to MainScreen after successful sign-in
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(
                          0.1,
                        ), // Transparent background
                        foregroundColor:
                            Colors.grey, // Greyish white text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 16,
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

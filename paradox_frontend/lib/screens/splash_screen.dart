import 'package:flutter/material.dart';
import '../widgets/google_sign_in_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png', // Background
              fit: BoxFit.fill,
            ),
          ),

          // Center Google Button
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GoogleSignInButton(
                  onTap: () {
                    // Navigate to Home Screen after sign-in
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

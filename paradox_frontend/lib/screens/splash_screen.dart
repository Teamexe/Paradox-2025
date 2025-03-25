import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Navigate to home after splash
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(
          context, '/home'); // Ensure '/home' is correctly defined in routes
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Correct Path
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/background_paradox.jpg'), // ✅ Corrected Path
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Fading Title "Paradox"
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                'PARADOX',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'Stencil',
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ParadoxBottomNavBar(currentIndex: 0),
    );
  }
}

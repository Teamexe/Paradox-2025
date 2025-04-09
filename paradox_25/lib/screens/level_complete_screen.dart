import 'package:flutter/material.dart';

class HurrayScreen extends StatefulWidget {
  const HurrayScreen({super.key});

  @override
  State<HurrayScreen> createState() => _HurrayScreenState();
}

class _HurrayScreenState extends State<HurrayScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
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
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/home_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // Paradox Text Image at the Top
          Positioned(
            top: 50, // Adjust the top position as needed
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/paradox_text.png', // Replace with your actual image path
              height: 100, // Adjust the height as needed
            ),
          ),

          // Centered Animated Text
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: const Text(
                  'Hurray! You have completed level 1 , Proceed to Level 2',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
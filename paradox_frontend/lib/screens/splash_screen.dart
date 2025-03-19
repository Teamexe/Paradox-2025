import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/space_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Pink geometric shapes
            Positioned(
              top: 20,
              left: 20,
              child: Image.asset('assets/images/pink_shape.png', width: 60),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Image.asset('assets/images/pink_shape.png', width: 60),
            ),
            Positioned(
              top: 100,
              right: 60,
              child: Image.asset('assets/images/pink_shape.png', width: 40),
            ),
            
            // Main content
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // PARADOX title
                Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Text(
                    'PARADOX',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontFamily: 'Stencil',
                    ),
                  ),
                ),
                
                // Center logo
                Expanded(
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Color(0xFF333333),
                            Colors.black,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'P',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Google search bar
                Padding(
                  padding: EdgeInsets.only(bottom: 100),
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF333333),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        Image.asset('assets/images/google_logo.png', height: 24),
                        SizedBox(width: 10),
                        Text(
                          'Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: ParadoxBottomNavBar(currentIndex: 0),
    );
  }
}
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/all_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            SizedBox(
              height: 60, // Adjusted height
              child: Image.asset('assets/images/paradox_text.png'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Container(
                  height: 500, // Slightly reduced outer container height
                  width: 352, // Outer container width remains the same
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF333333).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/leaderboard_list_bg.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Inner container
                      Container(
                        height: 400, // Inner container height remains the same
                        width: 292, // Inner container width remains the same
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE58B87),
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/profile_section.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Profile Image in Circular Box
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                width:
                                    150, // Adjusted size of the circular container
                                height:
                                    150, // Ensure width and height are equal for a circle
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.shade800,
                                    width: 5,
                                  ),
                                  color: Colors.white,
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/profile_image.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ), // Increased spacing below profile image
                            // Name (Aanya) above Leaderboard Box
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                'Aanya',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ), // Increased spacing below the name
                            // Leaderboard Box
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ), // Add margin
                              padding: const EdgeInsets.symmetric(
                                vertical: 8, // Reduced vertical padding
                                horizontal: 12, // Reduced horizontal padding
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Icon and #1 on the left
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.bar_chart,
                                        color: Colors.blue.shade300,
                                        size: 20, // Reduced icon size
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        '#1',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16, // Reduced font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Leaderboard text on the right
                                  const Text(
                                    'LeaderBoard',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16, // Reduced font size
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ), // Increased spacing between boxes
                            // Score Box (same size as Leaderboard Box)
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ), // Add margin
                              padding: const EdgeInsets.symmetric(
                                vertical: 8, // Reduced vertical padding
                                horizontal: 12, // Reduced horizontal padding
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Icon and Score on the left
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange.shade300,
                                        size: 20, // Reduced icon size
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        '220',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16, // Reduced font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Score text on the right
                                  const Text(
                                    'Score',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16, // Reduced font size
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

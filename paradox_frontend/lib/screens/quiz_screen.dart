import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() =>
      QuizScreenState(); // Remove underscore to make it public
}

class QuizScreenState extends State<QuizScreen> {
  final TextEditingController _answerController = TextEditingController();

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

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
        child: Column(
          children: [
            // Question container
            Container(
              margin: EdgeInsets.only(top: 60, left: 20, right: 20),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFCCCCCC),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'Q1. What is the message that image signifies.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Image placeholder
            Expanded(
              child: Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/question_image.png'), // Ensure this exists
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Hint
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFF333333),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade600),
              ),
              child: Row(
                children: [
                  Text(
                    'Hint: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'The place known for coffee',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // Answer input
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFF333333),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade600),
              ),
              child: TextField(
                controller: _answerController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'What do you think?',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),

            // Submit button
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle submission
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ParadoxBottomNavBar(currentIndex: 2),
    );
  }
}

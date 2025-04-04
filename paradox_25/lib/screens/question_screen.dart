import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  final int level;
  final VoidCallback onLevelComplete;

  const QuestionScreen({
    super.key,
    required this.level,
    required this.onLevelComplete,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final TextEditingController _answerController = TextEditingController();
  int _currentQuestionIndex = 0;
  bool _isHintVisible = false; // Track hint visibility

  // Questions for Level 1 and Level 2
  final Map<int, List<Map<String, String>>> _questions = {
    1: [
      {
        'question': 'Q1. What is the capital of France?',
        'answer': 'paris',
        'image': 'assets/images/france.png',
        'hint': 'It is known as the city of love.',
      },
      {
        'question': 'Q2. What is 2 + 2?',
        'answer': '4',
        'image': 'assets/images/math.png',
        'hint': 'It is the first even number.',
      },
    ],
    2: [
      {
        'question': 'Q1. What is the capital of Germany?',
        'answer': 'berlin',
        'image': 'assets/images/germany.png',
        'hint': 'It is a famous European city.',
      },
      {
        'question': 'Q2. What is 5 * 5?',
        'answer': '25',
        'image': 'assets/images/multiplication.png',
        'hint': 'It is a square of 5.',
      },
    ],
  };

  void _checkAnswer() {
    String userAnswer = _answerController.text.trim().toLowerCase();
    String correctAnswer =
        _questions[widget.level]![_currentQuestionIndex]['answer']!
            .toLowerCase();

    if (userAnswer == correctAnswer) {
      if (_currentQuestionIndex < _questions[widget.level]!.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _answerController.clear();
          _isHintVisible = false; // Hide hint for the next question
        });
      } else {
        widget.onLevelComplete(); // Notify that the level is complete
        Navigator.pop(context); // Go back to the HomeScreen
      }
    } else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Incorrect Answer'),
              content: const Text('Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level ${widget.level}'),
        backgroundColor: Colors.blue,
      ),
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
            // Question
            Container(
              margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                _questions[widget.level]![_currentQuestionIndex]['question']!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            // Image Area
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  _questions[widget.level]![_currentQuestionIndex]['image']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'Image not available',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Spacer(),
            // Hint Icon and Hint Text
            GestureDetector(
              onTap: () {
                setState(() {
                  _isHintVisible = !_isHintVisible; // Toggle hint visibility
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.yellow),
                  const SizedBox(width: 5),
                  const Text(
                    'Hint',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            if (_isHintVisible)
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _questions[widget.level]![_currentQuestionIndex]['hint']!,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            const SizedBox(height: 15),
            // Answer Input
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade700),
              ),
              child: TextField(
                controller: _answerController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Enter your answer',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Submit Button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: _checkAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

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
  bool _isHintVisible = false;
  int _score = 0;

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
    String correctAnswer = _questions[widget.level]![_currentQuestionIndex]['answer']!.toLowerCase();

    if (userAnswer == correctAnswer) {
      setState(() {
        _score += 50;
        if (_currentQuestionIndex < _questions[widget.level]!.length - 1) {
          _currentQuestionIndex++;
          _answerController.clear();
          _isHintVisible = false;
        } else {
          widget.onLevelComplete();
          Navigator.pop(context);
        }
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Wrong Answer'),
          content: const Text('Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final double padding = width * 0.05;
    final double smallFont = width * 0.035;
    final double normalFont = width * 0.045;
    final double largeFont = width * 0.06;
    final double imageHeight = height * 0.28;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Level ${widget.level}',
          style: TextStyle(
            color: Colors.white,
            fontSize: largeFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/all_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding * 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Question Container
                Container(
                  padding: EdgeInsets.all(padding * 0.75),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    _questions[widget.level]![_currentQuestionIndex]['question']!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: normalFont + 2,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: height * 0.03),

                // Image Box
                Container(
                  height: imageHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade200,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      _questions[widget.level]![_currentQuestionIndex]['image']!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Text(
                          'Image not available',
                          style: TextStyle(color: Colors.grey, fontSize: smallFont),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.025),

                // Hint and Score Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isHintVisible = !_isHintVisible;
                          if (_isHintVisible) _score -= 10;
                        });
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.lightbulb_outline, color: Colors.yellow),
                          SizedBox(width: 5),
                          Text(
                            'Hint',
                            style: TextStyle(color: Colors.white, fontSize: normalFont),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Score: $_score',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: normalFont,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                // Hint Text
                if (_isHintVisible)
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _questions[widget.level]![_currentQuestionIndex]['hint']!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: normalFont * 0.95,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                SizedBox(height: height * 0.025),

                // Answer Field
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _answerController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Type your answer here...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.025),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: height * 0.065,
                  child: ElevatedButton(
                    onPressed: _checkAnswer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: normalFont + 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

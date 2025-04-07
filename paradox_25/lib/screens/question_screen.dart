import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './home_screen.dart';
import 'package:paradox_25/main.dart';

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
  Map<String, dynamic>? _currentQuestion;
  bool _isHintVisible = false;
  int _score = 0;

  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _fetchCurrentQuestion();
  }

  Future<void> _fetchCurrentQuestion() async {
    final token = await storage.read(key: 'authToken'); // Get token
    if (token == null) {
      // User is not logged in, redirect to login
      // ... (Your login redirection logic)
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
          'https://paradox-2025.vercel.app/api/v1/question/current',
        ), // Replace with your API URL
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _currentQuestion = data; // Assuming the API returns question data
        });
      } else {
        // Handle API errors
        print('Error fetching current question: ${response.statusCode}');
        _showErrorDialog('Error fetching question');
        return;
      }
    } catch (e) {
      // Handle network errors
      print('Error: $e');
      _showErrorDialog('Network error. Please try again.');
      return;
    }
  }

  Future<void> _checkAnswer() async {
    final token = await storage.read(key: 'authToken'); // Get token
    if (token == null) {
      // User is not logged in, redirect to login
      // ... (Your login redirection logic)
      return;
    }

    try {
      final response = await http.patch(
        Uri.parse(
          'https://paradox-2025.vercel.app/api/v1/question/next',
        ), // Replace with your API URL
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'answer': _answerController.text.trim()}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['message'] == "Level is finished") {
          widget.onLevelComplete();
          Navigator.pop(context);
        } else {
          setState(() {
            _score =
                data['score']; // Assuming the API returns the updated score
            _currentQuestion =
                data['data']; // Assuming the API returns the next question
            _answerController.clear();
            _isHintVisible = false;
          });
        }
      } else {
        // Handle incorrect answer or other API errors
        print('Incorrect answer or API error: ${response.statusCode}');
        _showErrorDialog('Incorrect answer');
        return;
      }
    } catch (e) {
      // Handle network errors
      print('Error: $e');
      _showErrorDialog('Network error. Please try again.');
      return;
    }
  }

  Future<void> _fetchHint() async {
    final token = await storage.read(key: 'authToken'); // Get token
    if (token == null) {
      // User is not logged in, redirect to login
      // ... (Your login redirection logic)
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
          'https://paradox-2025.vercel.app/api/v1/question/hint',
        ), // Replace with your API URL
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _isHintVisible = true;
          _score -= 10;
          _currentQuestion!['hint'] =
              data['hint']; // Assuming hint is returned in 'hint' field
        });
      } else {
        // Handle API errors
        print('Error fetching hint: ${response.statusCode}');
        _showErrorDialog('Error fetching hint');
        return;
      }
    } catch (e) {
      // Handle network errors
      print('Error: $e');
      _showErrorDialog('Network error. Please try again.');
      return;
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Level ${widget.level}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          final double height = constraints.maxHeight;

          // Responsive scaling function
          double scale(double value) => value * (width / 390); // Base width

          final double padding = width * 0.05;
          final double smallFont = width * 0.035;
          final double normalFont = width * 0.045;
          final double largeFont = width * 0.06;
          final double imageHeight = height * 0.28;

          return Container(
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
                padding: EdgeInsets.symmetric(
                  horizontal: padding,
                  vertical: padding * 0.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Question Container
                    Container(
                      padding: EdgeInsets.all(padding * 0.75),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(scale(15)),
                      ),
                      child: Text(
                        _currentQuestion?['question'] ??
                            'Loading...', // Display question or loading text
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: normalFont,
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
                        borderRadius: BorderRadius.circular(scale(15)),
                        color: Colors.grey.shade200,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(scale(15)),
                        child:
                            _currentQuestion?['image'] != null
                                ? Image.network(
                                  _currentQuestion!['image'], // Display image from URL
                                  fit: BoxFit.contain,
                                  errorBuilder:
                                      (context, error, stackTrace) => Center(
                                        child: Text(
                                          'Image not available',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: smallFont,
                                          ),
                                        ),
                                      ),
                                )
                                : Center(
                                  child: Text(
                                    'Loading Image...',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: smallFont,
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
                            if (!_isHintVisible) {
                              _fetchHint(); // Fetch hint from API
                            } else {
                              setState(() {
                                _isHintVisible = false;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                color: Colors.yellow,
                                size: scale(20),
                              ),
                              SizedBox(width: scale(5)),
                              Text(
                                _isHintVisible ? 'Hide Hint' : 'Hint',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: normalFont,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: scale(15),
                            vertical: scale(8),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(scale(10)),
                          ),
                          child: Text(
                            'Score: $_score', // Display the score
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: normalFont,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.025),

                    // Answer Field
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: scale(15)),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(scale(10)),
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
                        onPressed: _checkAnswer, // Submit answer to API
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(scale(10)),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: normalFont,
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
          );
        },
      ),
    );
  }
}

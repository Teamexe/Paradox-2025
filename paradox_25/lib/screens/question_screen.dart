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

class _QuestionScreenState extends State<QuestionScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _answerController = TextEditingController();
  Map<String, dynamic>? _currentQuestion;
  bool _isHintVisible = false;
  bool _isHintUsed =
      false; // Flag to track if hint has been used for the current question
  int _score = 0;
  int _questionNumber = 1; // Track the current question number

  final storage = const FlutterSecureStorage();
  AnimationController? _animationController; // Animation Controller
  Animation<double>? _animation; // Animation
  final FocusNode _focusNode = FocusNode(); // FocusNode for TextField

  @override
  void initState() {
    super.initState();
    _fetchCurrentQuestion();

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000), // Adjust duration as needed
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose(); // Dispose animation controller
    _focusNode.dispose(); // Dispose FocusNode
    super.dispose();
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

      if (response.statusCode == 200 || response.statusCode == 202) {
        print('Raw Response: ${response.body}');
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('Decoded Data: ${data}');

        if (data['success'] == true && data['data']['ques'].isNotEmpty) {
          setState(() {
            _currentQuestion = data['data']['ques'][0];
            _score = data['data']['score'] ?? 0;
            print('_currentQuestion: $_currentQuestion');
            _isHintUsed = false; // Reset hint usage flag for the new question
            _questionNumber =
                _currentQuestion?['id'] ?? 1; // Initialize question number
          });
        } else {
          _showErrorDialog(
            data['message'] ?? 'No question found for the current level.',
          );
        }
      } else {
        // Handle API errors
        print('API Error: ${response.statusCode} - ${response.reasonPhrase}');
        _showErrorDialog(
          'Error fetching question: ${response.statusCode} - ${response.reasonPhrase ?? "An error occurred"}',
        );
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

      print('Response Status Code (Answer): ${response.statusCode}'); // DEBUG
      print('Raw Response (Answer): ${response.body}'); // DEBUG

      final Map<String, dynamic> data = jsonDecode(response.body);
      print('Decoded Data (Answer): ${data}'); // DEBUG

      if (response.statusCode == 200 || response.statusCode == 202) {
        if (data['success'] == true) {
          // Check if the level is finished (if that's still a possibility)
          if (data['data'] == "Level is finished") {
            // Determine the total number of questions for the current level
            int totalQuestions = widget.level == 1 ? 40 : 10;

            // Check if all questions for the current level are completed
            if (data['questionsCompleted'] == totalQuestions) {
              // All questions for the current level are completed
              _animationController?.forward(); // Start animation
              await Future.delayed(
                const Duration(seconds: 2),
              ); // Wait for animation
            }

            widget.onLevelComplete();
            Navigator.pop(context); // Go back to Home Screen
          } else {
            setState(() {
              _score = data['data']['score'];
              _currentQuestion = data['data']['newQues'];
              _answerController.clear();
              _isHintVisible = false;
              _isHintUsed = false;
              _questionNumber =
                  data['data']['newQues']['id']; // Update question number
            });

            // Unlock Level 2 Logic
            if (widget.level == 1) {
              // Store a flag to indicate level 2 is unlocked
              await storage.write(key: 'level2Unlocked', value: 'true');
            }
          }
        } else {
          _showErrorDialog(data['message'] ?? 'Incorrect answer or error.');
        }
      } else {
        // Handle incorrect answer or other API errors
        print(
          'API Error (Answer): ${response.statusCode} - ${response.reasonPhrase}',
        ); // DEBUG
        _showErrorDialog(
          'Incorrect answer: ${response.statusCode} - ${response.reasonPhrase ?? "An error occurred"}',
        );
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

      if (response.statusCode == 200 || response.statusCode == 202) {
        final Map<String, dynamic> data = jsonDecode(
          response.body,
        ); // Hint API might return a JSON
        if (data['success'] == true &&
            data['data'] != null &&
            data['data']['hint'] != null) {
          String hint = data['data']['hint'];
          // Generic Hint Correction (Example)
          // You can add more complex logic here if needed
          if (hint.toLowerCase() == "place") {
            hint = "Location"; // Or any other appropriate word
          } else if (hint.toLowerCase() == "some other incorrect word") {
            hint = "Corrected Value";
          }
          // If you have a list of incorrect words:
          // const incorrectWords = ["place", "word1", "word2"];
          // if (incorrectWords.contains(hint.toLowerCase())) {
          //  hint = "Corrected Value";
          // }

          setState(() {
            _isHintVisible = true;
            if (!_isHintUsed) {
              _isHintUsed = true; // Mark hint as used for this question
            }
            if (_currentQuestion != null) {
              _currentQuestion!['hint'] = hint;
            }
          });
        } else {
          _showErrorDialog(data['message'] ?? 'Error fetching hint.');
        }
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
            fontFamily: 'PixelFont', // Use the pixel font
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
                        'Q$_questionNumber: ${_currentQuestion?['title'] ?? 'Loading...'}',
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
                      constraints: BoxConstraints(
                        maxHeight:
                            height * 0.6, // Maximum height for the white box
                        maxWidth:
                            width * 0.9, // Maximum width for the white box
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(scale(15)),
                        color: Colors.grey.shade200,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(scale(15)),
                        child:
                            _currentQuestion?['descriptionOrImgUrl'] != null
                                ? Image.network(
                                  _currentQuestion!['descriptionOrImgUrl'],
                                  fit: BoxFit.contain,
                                  loadingBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
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

                    // Hint Section
                    if (_isHintVisible && _currentQuestion?['hint'] != null)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(padding * 0.5),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade100,
                          borderRadius: BorderRadius.circular(scale(10)),
                        ),
                        child: Text(
                          'Hint: ${_currentQuestion!['hint']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: normalFont,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (_isHintVisible && _currentQuestion?['hint'] != null)
                      SizedBox(height: height * 0.015),

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
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(
                          context,
                        ).requestFocus(_focusNode); // Request focus
                      },
                      child: Container(
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
                          focusNode: _focusNode, // Assign the FocusNode
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

import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/top_scorers_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/rules_screen.dart';
import 'screens/quiz_screen.dart';

void main() {
  runApp(ParadoxApp());
}

class ParadoxApp extends StatelessWidget {
  const ParadoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paradox',
      theme: ThemeData(
        primaryColor: Color(0xFFF75049),
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Orbitron',
      ),
      home: SplashScreen(),
      routes: {
        '/leaderboard': (context) => LeaderboardScreen(),
        '/top_scorers': (context) => TopScorersScreen(),
        '/profile': (context) => ProfileScreen(),
        '/rules': (context) => RulesScreen(),
        '/quiz': (context) => QuizScreen(),
      },
    );
  }
}
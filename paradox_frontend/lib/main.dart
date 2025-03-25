import 'package:flutter/material.dart';
import 'screens/splash_screen.dart' as splash;
import 'screens/leaderboard_screen.dart';
import 'screens/top_scorers_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/rules_screen.dart';
import 'screens/quiz_screen.dart';

void main() {
  runApp(const ParadoxApp());
}

class ParadoxApp extends StatelessWidget {
  const ParadoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paradox',
      theme: ThemeData(
        primaryColor: const Color(0xFFF75049),
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Orbitron',
      ),
      home: const splash.SplashScreen(),
      routes: {
        '/leaderboard': (context) => const LeaderboardScreen(),
        '/top_scorers': (context) => const TopScorersScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/rules': (context) => const RulesScreen(),
        '/quiz': (context) => const QuizScreen(),
      },
    );
  }
}


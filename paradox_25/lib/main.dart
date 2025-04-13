import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'screens/splash_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/prizes_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/rules_screen.dart';
import 'screens/question_screen.dart';
import 'screens/home_screen.dart';
import 'widgets/bottom_navigation.dart';
import 'screens/auth_choice_screen.dart'; // Import the AuthChoiceScreen

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ParadoxApp());
}

class ParadoxApp extends StatelessWidget {
  const ParadoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Wrap MaterialApp with ChangeNotifierProvider
      create: (context) => LeaderboardProvider(), // Provide LeaderboardProvider
      child: MaterialApp(
        title: 'PARADOX',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFFF75049),
          scaffoldBackgroundColor: Colors.black,
          fontFamily: 'Roboto', // Replace with your actual font
        ),
        home: const AuthScreen(), // Change home to AuthChoiceScreen
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(), // Add HomeScreen as the first screen
    const LeaderboardScreen(),
    const RulesScreen(),
    const PrizesScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: ParadoxBottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

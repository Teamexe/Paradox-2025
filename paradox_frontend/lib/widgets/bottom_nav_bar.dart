import 'package:flutter/material.dart';

class ParadoxBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const ParadoxBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF555555),
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade700,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, 0, Icons.home, 'Home', '/'),
          _buildNavItem(context, 1, Icons.bar_chart, 'Leaderboard', '/leaderboard'),
          _buildNavItem(context, 2, Icons.menu, 'Rules', '/rules'),
          _buildNavItem(context, 3, Icons.emoji_events, 'Prizes', '/prizes'), // Fix added
          _buildNavItem(context, 4, Icons.person, 'Profile', '/profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label, String route) {
    final isSelected = currentIndex == index;

    return InkWell(
      onTap: () {
        if (!isSelected) {
          Navigator.pushNamed(context, route); // pushNamed for better navigation
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

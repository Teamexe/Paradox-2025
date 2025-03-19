import 'package:flutter/material.dart';

class ParadoxBottomNavBar extends StatelessWidget {
  final int currentIndex;
  
  const ParadoxBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Color(0xFF555555),
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
          _buildNavItem(context, 0, Icons.home, 'Home'),
          _buildNavItem(context, 1, Icons.bar_chart, 'Leaderboard'),
          _buildNavItem(context, 2, Icons.menu, 'Rules'),
          _buildNavItem(context, 3, Icons.emoji_events, 'Prizes'),
          _buildNavItem(context, 4, Icons.person, 'Profile'),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    final isSelected = currentIndex == index;
    
    return InkWell(
      onTap: () {
        if (!isSelected) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/leaderboard');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/rules');
              break;
            case 3:
              // Navigate to prizes
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
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
          SizedBox(height: 4),
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
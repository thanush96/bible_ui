import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';

class ButtonNav extends StatefulWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onMapPressed;
  final VoidCallback onFavoritePressed;
  final VoidCallback onProfilePressed;

  const ButtonNav({
    required this.onHomePressed,
    required this.onMapPressed,
    required this.onFavoritePressed,
    required this.onProfilePressed,
    super.key,
  });

  @override
  _ButtonNavState createState() => _ButtonNavState();
}

class _ButtonNavState extends State<ButtonNav> {
  int _selectedIndex = 0; // Track the selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Call the corresponding callback based on the selected index
    switch (index) {
      case 0:
        widget.onHomePressed();
        break;
      case 1:
        widget.onMapPressed();
        break;
      case 2:
        widget.onFavoritePressed();
        break;
      case 3:
        widget.onProfilePressed();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: globalGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavIcon(Icons.home, 0),
          _buildNavIcon(Icons.map, 1),
          _buildNavIcon(Icons.favorite, 2),
          _buildNavIcon(Icons.person, 3),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    bool isActive = _selectedIndex == index; // Check if this index is active
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(2),
      child: IconButton(
        icon: Icon(
          icon,
          color: isActive ? Colors.black : Colors.white54,
        ),
        onPressed: () => _onItemTapped(index), // Handle item tap
      ),
    );
  }
}

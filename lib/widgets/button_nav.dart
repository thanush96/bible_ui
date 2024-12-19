import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/screens/bible/bible_home.dart';
import 'package:flutter_app/screens/book_history/book_history_view.dart';
import 'package:flutter_app/screens/favourite_book/favourite_book_view.dart';

class ButtonNav extends StatefulWidget {
  int selectedIndex;
  ButtonNav({super.key, this.selectedIndex = 0});

  @override
  _ButtonNavState createState() => _ButtonNavState();
}

class _ButtonNavState extends State<ButtonNav> {
  void _onItemTapped(int index) {
    if (widget.selectedIndex == index) {
      return;
    }

    setState(() {
      widget.selectedIndex = index;
    });

    // Call the corresponding callback based on the selected index
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BibleHomePage(),
          ),
        );

        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BookHistoryView(),
          ),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FavouriteBookView(),
          ),
        );
        break;
      case 3:
        () {};
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
    bool isActive =
        widget.selectedIndex == index; // Check if this index is active
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

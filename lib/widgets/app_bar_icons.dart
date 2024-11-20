import 'package:flutter/material.dart';

class AppBarIcons extends StatelessWidget {
  final Function(String) onSectionChange;
  final String currentSection;

  const AppBarIcons({
    Key? key,
    required this.onSectionChange,
    required this.currentSection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: currentSection == 'chapters' ? Colors.red : Colors.black,
            ),
            onPressed: () => onSectionChange('chapters'),
          ),
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: currentSection == 'bookmarks' ? Colors.red : Colors.black,
            ),
            onPressed: () => onSectionChange('bookmarks'),
          ),
          IconButton(
            icon: Icon(
              Icons.edit,
              color: currentSection == 'notes' ? Colors.red : Colors.black,
            ),
            onPressed: () => onSectionChange('notes'),
          ),
          IconButton(
            icon: Icon(
              Icons.nightlight_round,
              color: currentSection == 'theme' ? Colors.red : Colors.black,
            ),
            onPressed: () => onSectionChange('theme'),
          ),
          IconButton(
            icon: Icon(
              Icons.file_upload,
              color: currentSection == 'download' ? Colors.red : Colors.black,
            ),
            onPressed: () => onSectionChange('download'),
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: currentSection == 'settings' ? Colors.red : Colors.black,
            ),
            onPressed: () => onSectionChange('settings'),
          ),
        ],
      ),
    );
  }
}

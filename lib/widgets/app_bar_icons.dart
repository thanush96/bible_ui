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
      padding: const EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: currentSection == 'chapters'
                ? const BoxDecoration(
                    color: Colors.white, // White background
                    shape: BoxShape.circle, // Circular shape
                  )
                : null, // No decoration for other sections
            child: IconButton(
              icon: Icon(
                Icons.menu,
                size: 20,
                color:
                    currentSection == 'chapters' ? Colors.black : Colors.white,
              ),
              onPressed: () => onSectionChange('chapters'),
            ),
          ),
          Container(
            decoration: currentSection == 'bookmarks'
                ? const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  )
                : null,
            child: IconButton(
              icon: Icon(
                Icons.bookmark,
                size: 20,
                color:
                    currentSection == 'bookmarks' ? Colors.black : Colors.white,
              ),
              onPressed: () => onSectionChange('bookmarks'),
            ),
          ),
          Container(
            decoration: currentSection == 'add'
                ? const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  )
                : null,
            child: IconButton(
              icon: Icon(
                Icons.edit_square,
                size: 20,
                color: currentSection == 'add' ? Colors.black : Colors.white,
              ),
              onPressed: () => onSectionChange('add'),
            ),
          ),
          Container(
            decoration: currentSection == 'notes'
                ? const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  )
                : null,
            child: IconButton(
              icon: Icon(
                Icons.edit,
                size: 20,
                color: currentSection == 'notes' ? Colors.black : Colors.white,
              ),
              onPressed: () => onSectionChange('notes'),
            ),
          ),
          Container(
            decoration: currentSection == 'theme'
                ? const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  )
                : null,
            child: IconButton(
              icon: Icon(
                Icons.nightlight_round,
                size: 20,
                color: currentSection == 'theme' ? Colors.black : Colors.white,
              ),
              onPressed: () => onSectionChange('theme'),
            ),
          ),
          Container(
            decoration: currentSection == 'download'
                ? const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  )
                : null,
            child: IconButton(
              icon: Icon(
                Icons.file_upload,
                size: 20,
                color:
                    currentSection == 'download' ? Colors.black : Colors.white,
              ),
              onPressed: () => onSectionChange('download'),
            ),
          ),
          Container(
            decoration: currentSection == 'settings'
                ? const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  )
                : null,
            child: IconButton(
              icon: Icon(
                Icons.settings,
                size: 20,
                color:
                    currentSection == 'settings' ? Colors.black : Colors.white,
              ),
              onPressed: () => onSectionChange('settings'),
            ),
          ),
        ],
      ),
    );
  }
}

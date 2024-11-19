import 'package:flutter/material.dart';

class AppBarIcons extends StatelessWidget {
  final Function(String) onSectionChange;

  const AppBarIcons({Key? key, required this.onSectionChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.red),
          onPressed: () => onSectionChange('chapters'),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.bookmark, color: Colors.red),
              onPressed: () => onSectionChange('bookmarks'),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.red),
              onPressed: () => onSectionChange('notes'),
            ),
            IconButton(
              icon: const Icon(Icons.nightlight_round, color: Colors.red),
              onPressed: () => onSectionChange('theme'),
            ),
            IconButton(
              icon: const Icon(Icons.file_download, color: Colors.red),
              onPressed: () => onSectionChange('download'),
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.red),
              onPressed: () => onSectionChange('settings'),
            ),
          ],
        ),
      ],
    );
  }
}

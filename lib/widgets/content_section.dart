import 'package:flutter/material.dart';

class ContentSection extends StatelessWidget {
  final String currentSection;

  const ContentSection({Key? key, required this.currentSection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (currentSection) {
      case 'chapters':
        return _buildChaptersList();
      case 'bookmarks':
        return _buildBookmarksList();
      case 'notes':
        return _buildNotesList();
      case 'theme':
        return _buildThemeSettings();
      case 'download':
        return _buildDownloadSection();
      case 'settings':
        return _buildSettingsPanel();
      default:
        return const Center(
            child:
                Text('Select a section', style: TextStyle(color: Colors.red)));
    }
  }

  Widget _buildChaptersList() {
    final chapters = [
      {"id": "1", "title": "Chapter 1"},
      {"id": "2", "title": "Chapter 2"},
      {"id": "3", "title": "Chapter 3"},
    ];

    return SizedBox(
      height: 300, // Adjust this to the desired height
      child: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(chapters[index]['title']!,
                style: const TextStyle(color: Colors.red)),
            trailing: const Icon(Icons.chevron_right, color: Colors.red),
            onTap: () {},
          );
        },
      ),
    );
  }

  Widget _buildBookmarksList() {
    return const Center(
        child: Text('Bookmarks', style: TextStyle(color: Colors.red)));
  }

  Widget _buildNotesList() {
    return const Center(
        child: Text('Notes', style: TextStyle(color: Colors.red)));
  }

  Widget _buildThemeSettings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Theme Settings',
            style: TextStyle(color: Colors.red, fontSize: 20)),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Toggle Dark Mode'),
        ),
      ],
    );
  }

  Widget _buildDownloadSection() {
    return const Center(
        child: Text('Download Section', style: TextStyle(color: Colors.red)));
  }

  Widget _buildSettingsPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Font', style: TextStyle(color: Colors.red)),
        DropdownButton<String>(
          value: 'Time New Rome',
          dropdownColor: Colors.black.withOpacity(0.8),
          style: const TextStyle(color: Colors.red),
          onChanged: (String? newValue) {},
          items: <String>['Time New Rome', 'Arial', 'Georgia']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        const Text('Font Size', style: TextStyle(color: Colors.red)),
        Slider(
          value: 16,
          min: 12,
          max: 24,
          divisions: 12,
          label: '16',
          onChanged: (double value) {},
        ),
      ],
    );
  }
}

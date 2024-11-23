import 'package:flutter/material.dart';

class ContentSection extends StatelessWidget {
  final List<Map<String, String>> chapters;
  final String currentSection;

  const ContentSection(
      {super.key, required this.chapters, required this.currentSection});

  @override
  Widget build(BuildContext context) {
    switch (currentSection) {
      case 'chapters':
        return _buildChaptersList();
      case 'add':
        return _buildAddNew();
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
          child: Text('Select a section', style: TextStyle(color: Colors.red)),
        );
    }
  }

  Widget _buildChaptersList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      child: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              chapters[index]['title']!,
              style: const TextStyle(color: Colors.red),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }

  Widget _buildBookmarksList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      child: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              chapters[index]['title']!,
              style: const TextStyle(color: Colors.red),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }

  Widget _buildAddNew() => Center(child: Text('add new Section'));

  Widget _buildNotesList() => Center(child: Text('Notes Section'));

  Widget _buildThemeSettings() => Center(child: Text('Theme Settings'));

  Widget _buildDownloadSection() => Center(child: Text('Download Section'));

  Widget _buildSettingsPanel() => Center(child: Text('Settings Panel'));
}

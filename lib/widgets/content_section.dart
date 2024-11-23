import 'package:flutter/material.dart';
import 'package:flutter_app/model/bible_content.dart';

class ContentSection extends StatelessWidget {
  final List<Map<String, String>> chapters;
  final List<Map<String, dynamic>> highlightedList;
  final String currentSection;
  final List highlight;
  final Function(Color) onSelectedHighlighter;
  final Function(Map<String, String>) onChangeChapter;

  const ContentSection(
      {super.key,
      required this.chapters,
      required this.highlight,
      required this.currentSection,
      required this.onSelectedHighlighter,
      required this.highlightedList,
      required this.onChangeChapter});

  @override
  Widget build(BuildContext context) {
    switch (currentSection) {
      case 'chapters':
        return _buildChaptersList();
      case 'add':
        return _buildAddNew();
      case 'bookmarks':
        return _buildBookmarksList();
      case 'Highlights':
        return _buildHighlights();
      case 'theme':
        return _buildThemeSettings();
      case 'download':
        return _buildDownloadSection();
      case 'settings':
        return _buildSettingsPanel();
      default:
        return const Center(
          child:
              Text('Select a section', style: TextStyle(color: Colors.white)),
        );
    }
  }

  Widget _buildChaptersList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      child: ListView.builder(
        itemCount: mockChapters.length, // Use mockChapters for chapter data
        itemBuilder: (context, index) {
          final chapter = mockChapters[index]; // Get the current chapter
          return GestureDetector(
            onTap: () {
              onChangeChapter(
                {'id': '$index', 'title': 'Chapter 2'},
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(
                    52, 245, 247, 252), // Set the background color
                // borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chapter ${chapter.chapterNumber}",
                    style: const TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                ],
              ),
            ),
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
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }

  Widget _buildAddNew() => Center(child: Text('add new Section'));

  Widget _buildHighlights() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Column(
          children: [
            // Row for color options
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: highlight.map((color) {
                  return GestureDetector(
                    onTap: () {
                      onSelectedHighlighter(color);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      width: 30,
                      height: 30,
                      color: color,
                    ),
                  );
                }).toList(),
              ),
            ),
            // ListView for highlighted verses
            Expanded(
              // Ensures the ListView gets proper space
              child: ListView.builder(
                itemCount: highlightedList.length,
                itemBuilder: (context, index) {
                  final item = highlightedList[index];
                  return GestureDetector(
                    onTap: () {
                      onSelectedHighlighter(item['color']);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
                      decoration: BoxDecoration(
                        color: item['color'], // Set the background color
                        // borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (item.containsKey('chapter'))
                            Text(
                              '${item['time']}',
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.white70),
                            ),
                          Text(
                            'Chapter ${item['chapter']}',
                            style: const TextStyle(
                                fontSize: 13, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSettings() => Center(child: Text('Theme Settings'));

  Widget _buildDownloadSection() => Center(child: Text('Download Section'));

  Widget _buildSettingsPanel() => Center(child: Text('Settings Panel'));
}

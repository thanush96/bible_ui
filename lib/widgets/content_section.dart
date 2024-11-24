import 'package:flutter/material.dart';
import 'package:flutter_app/model/bible_content.dart';
import 'package:intl/intl.dart';

class ContentSection extends StatefulWidget {
  final List<Map<String, dynamic>> chapters;
  final List<Map<String, dynamic>> noteList;
  final List<Map<String, dynamic>> highlightedList;
  final String currentSection;
  final List highlight;
  final Function(Color) onSelectedHighlighter;
  final Function(Map<String, String>) onChangeChapter;
  final Function(Map<String, String>) onChangeReadingStyle;
  final Function(Map<String, String>) onChangeNewNote;

  const ContentSection({
    super.key,
    required this.chapters,
    required this.highlight,
    required this.currentSection,
    required this.onSelectedHighlighter,
    required this.highlightedList,
    required this.onChangeChapter,
    required this.onChangeReadingStyle,
    required this.onChangeNewNote,
    required this.noteList,
  });

  @override
  _ContentSectionState createState() => _ContentSectionState();
}

class _ContentSectionState extends State<ContentSection> {
  String _selectedFont = 'Times New Roman';
  double _fontSize = 16.0;

  List<Map<String, dynamic>> noteList = [];

  final List<String> _fontStyles = [
    'Times New Roman',
    'Arial',
    'Courier New',
    'Verdana'
  ];

  @override
  Widget build(BuildContext context) {
    switch (widget.currentSection) {
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
              widget.onChangeChapter(
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
        itemCount: widget.chapters.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            decoration: const BoxDecoration(
              color:
                  Color.fromARGB(52, 245, 247, 252), // Set the background color
              // borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.chapters[index]['time'],
                  style: const TextStyle(fontSize: 10, color: Colors.white70),
                ),
                Text(
                  'Chapter ${index + 1}',
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddNew() {
    final TextEditingController _noteController = TextEditingController();
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: ElevatedButton(
                onPressed: () {
                  final inputText = _noteController.text;

                  setState(() {
                    noteList.add({
                      'id': '01',
                      'note': inputText,
                      'time': DateFormat('dd/MM/yyyy').format(DateTime.now())
                    }); // Add new content
                  });

                  widget.onChangeNewNote({
                    'id': '01',
                    'note': inputText,
                  });
                  _noteController.clear();

                  // print('Inputted text: $noteList');
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Border radius set to 0
                  ),
                ),
                child: const Text('Save'),
              ),
            ),

            // Row for color options
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: const Color.fromARGB(52, 245, 247, 252),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        child: TextField(
                          controller: _noteController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your note here',
                            hintStyle: TextStyle(
                              color: Colors.white70, // Hint text color
                            ),
                            border: InputBorder.none, // Remove the border
                          ),
                          style: const TextStyle(
                              color: Colors.white), // Input text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: widget.noteList.length,
                itemBuilder: (context, index) {
                  final item = widget.noteList[index];
                  print(
                      "Note List Updated: ${item['note']}"); // Check if the list updates
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(52, 245, 247, 252),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item['time']}',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.white70),
                        ),
                        Text(
                          '${item['note']}',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

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
                children: widget.highlight.map((color) {
                  return GestureDetector(
                    onTap: () {
                      widget.onSelectedHighlighter(color);
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
                itemCount: widget.highlightedList.length,
                itemBuilder: (context, index) {
                  final item = widget.highlightedList[index];
                  return GestureDetector(
                    onTap: () {
                      widget.onSelectedHighlighter(item['color']);
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

  Widget _buildSettingsPanel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Font',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(96, 255, 255, 255),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _selectedFont,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFont = newValue!;
                    });

                    widget.onChangeReadingStyle(
                      {
                        '_selectedFont': '$_selectedFont',
                        '_fontSize': '$_fontSize'
                      },
                    );
                  },
                  items:
                      _fontStyles.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  dropdownColor: Colors.black.withOpacity(0.8),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey.shade300,
                  ),
                  underline: SizedBox(), // Remove the underline from dropdown
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.0),
                ),
              ),
              const SizedBox(width: 8.0),
              const Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ],
          ),
          const Text(
            'Font Size',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.grey.shade600,
              thumbColor: Colors.white,
              trackHeight: 4.0,
            ),
            child: Slider(
              value: _fontSize,
              min: 8.0,
              max: 32.0,
              onChanged: (value) {
                setState(() {
                  _fontSize = value;
                });

                widget.onChangeReadingStyle(
                  {
                    '_selectedFont': '$_selectedFont',
                    '_fontSize': '$_fontSize'
                  },
                );

                // print('Font Size: $_fontSize'); // Print the font size
              },
            ),
          ),
        ],
      ),
    );
  }
}

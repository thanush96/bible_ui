import 'package:flutter/material.dart';
import 'package:flutter_app/model/bible_content.dart';
import 'package:flutter_app/widgets/app_bar_icons.dart';
import 'package:flutter_app/widgets/build_highlighted_text.dart';
import 'package:flutter_app/widgets/content_section.dart';
import '../../constants/constants.dart';
import '../../widgets/reader_header.dart';
import '../../widgets/custom_selector_toolbar.dart';
import 'package:intl/intl.dart';

// New list to track highlighted verses
List<Map<String, dynamic>> highlightedVerses = [];

class BibleReaderPage extends StatefulWidget {
  const BibleReaderPage({super.key});

  @override
  State<BibleReaderPage> createState() => _BibleReaderPageState();
}

class _BibleReaderPageState extends State<BibleReaderPage> {
  List<Map<String, String>> chapters = [
    {"id": "1", "title": "Chapter 1"},
  ];

  final List<Color> colorsList = [
    Colors.yellow.shade200,
    Colors.blue.shade200,
    Colors.red.shade200,
  ];

  Color highlight = Colors.red.shade200;

  void addToFavorites(String id, String title) {
    print("addToFavorites--");

    setState(() {
      chapters.add({"id": id, "title": title}); // Add new content
    });
  }

  void selectedHighlighterColor(Color color) {
    print("highlight--");
    print(color);

    setState(() {
      highlight = color;
    });
  }

  void toggleHighlight(String verse) {
    print("toggleHighlight");
    print(verse);

    setState(() {
      // Check if the verse already exists in the highlightedVerses list
      bool verseExists =
          highlightedVerses.any((highlight) => highlight['verse'] == verse);

      if (verseExists) {
        // Remove the verse from highlightedVerses
        highlightedVerses
            .removeWhere((highlight) => highlight['verse'] == verse);
      } else {
        // Add the verse to highlightedVerses with the current color
        highlightedVerses.add({
          'chapter': '1',
          'time': DateFormat('dd/mm/yyyy').format(DateTime.now()),
          'verse': verse,
          'color': highlight,
        });
      }
    });

    print(highlightedVerses);
  }

  bool isPlaying = false;
  bool showVerses = false;
  bool isPlayerExpanded = false;
  double audioProgress = 0.3;
  String _currentSection = 'chapters';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ReaderHeader(
              onBackPressed: () => Navigator.pop(context),
              isPlaying: isPlaying,
              onPlayPause: () {
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: () {},
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Chapters',
                                  style: TextStyle(
                                    fontFamily: 'Times',
                                    color: !showVerses
                                        ? Colors.white
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 1,
                                  height: 20,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Verse',
                                  style: TextStyle(
                                    fontFamily: 'Times',
                                    color:
                                        showVerses ? Colors.white : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                ...mockChapter.verses
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final index = entry.key;
                                  final verse = entry.value;
                                  if (index == 0) {
                                    return RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontFamily: 'Times',
                                            height: 1.5),
                                        children: [
                                          TextSpan(
                                            text: verse.content[0],
                                            style: TextStyle(
                                              fontSize: 60,
                                              fontFamily: 'Times',
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                            ),
                                          ),
                                          TextSpan(
                                            text: verse.content.substring(1),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: SelectableText.rich(
                                        buildHighlightedText(
                                          verse.verseNumber,
                                          verse.content,
                                          highlightedVerses,
                                        ),
                                        selectionControls:
                                            CustomTextSelectionControls(
                                          onAddToFavorite: (id, title) {
                                            addToFavorites(
                                                id, title); // Add to favorites
                                          },
                                          onHighlight: (verseNumber) {
                                            toggleHighlight(verseNumber);
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: globalGradient,
                    ),
                    // decoration: BoxDecoration(
                    //   color: const Color.fromARGB(255, 255, 0, 0),
                    //   borderRadius: BorderRadius.circular(20),
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppBarIcons(
                            onSectionChange: (String section) {
                              print('Previous section: $_currentSection');
                              print('New section: $section');

                              // Update the parent state and modal state
                              setState(() {
                                _currentSection = section;
                              });
                              setModalState(() {}); // Rebuild the modal content
                            },
                            currentSection: _currentSection,
                          ),
                          const Divider(
                            thickness: 1, // Line thickness
                            color: Colors.grey, // Line color
                            indent:
                                20, // Optional: add space from the left side
                            endIndent:
                                20, // Optional: add space from the right side
                          ),
                          Flexible(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.27,
                              ),
                              child: ContentSection(
                                chapters: chapters, // Pass the chapters list
                                currentSection: _currentSection,
                                highlight: colorsList,
                                highlightedList: highlightedVerses,
                                onSelectedHighlighter: (Color color) {
                                  selectedHighlighterColor(
                                      color); // Add to favorites
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

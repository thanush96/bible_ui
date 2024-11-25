import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../model/bible_content.dart';
import '../../widgets/app_bar_icons.dart';
import '../../widgets/build_highlighted_text.dart';
import '../../widgets/content_section.dart';
import '../../widgets/music_player.dart';
import '../../widgets/reader_header.dart';
import '../../widgets/custom_selector_toolbar.dart';
import 'package:intl/intl.dart';

// New list to track highlighted verses
List<Map<String, dynamic>> highlightedVerses = [];

class BibleReaderPage extends StatefulWidget {
  const BibleReaderPage({
    super.key,
  });

  @override
  State<BibleReaderPage> createState() => _BibleReaderPageState();
}

class _BibleReaderPageState extends State<BibleReaderPage> {
  List<Map<String, String>> chapters = [];
  List<Map<String, dynamic>> noteList = [];
  // List<Map<String, String>> fontStyleData = [];
  Map<String, dynamic> fontStyle = {
    "_selectedFont": "Times New Roman",
    "_fontSize": 16.721590283890844
  };

  late int currentChapterIndex = 0;
  late Color highlight = Colors.red.shade200;

  final List<Color> colorsList = [
    Colors.yellow.shade200,
    Colors.blue.shade200,
    Colors.red.shade200,
  ];

  @override
  void initState() {
    super.initState();
  }

  void loadChapter(int index) {
    setState(() {
      currentChapterIndex = index;
    });
  }

  void changeChapter(chapter) {
    setState(() {
      currentChapterIndex = int.parse(chapter['id'] ?? '0');
    });
  }

  void changeFontStyle(Map<String, dynamic> newFontStyle) {
    setState(() {
      fontStyle = newFontStyle;
    });
  }

  void addToFavorites(String id, String title) {
    setState(() {
      chapters.add({
        "id": id,
        "title": title,
        'time': DateFormat('dd/MM/yyyy').format(DateTime.now())
      }); // Add new content
    });
  }

  void addNewNote(note) {
    setState(() {
      noteList.add({
        'id': note['id'],
        'note': note['note'],
        'time': DateFormat('dd/MM/yyyy').format(DateTime.now())
      }); // Add new content
    });
  }

  void selectedHighlighterColor(Color color) {
    setState(() {
      highlight = color;
    });
  }

  void toggleHighlight(String verse) {
    setState(() {
      bool verseExists =
          highlightedVerses.any((highlight) => highlight['verse'] == verse);

      if (verseExists) {
        highlightedVerses
            .removeWhere((highlight) => highlight['verse'] == verse);
      } else {
        highlightedVerses.add({
          'chapter': '1',
          'time': DateFormat('dd/MM/yyyy').format(DateTime.now()),
          'verse': verse,
          'color': highlight,
        });
      }
    });
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
              onPlayOpen: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => const PopupMusicPlayer(),
                );

                // setState(() {
                //   isPlaying = !isPlaying;
                // });
              },
            ),
            Center(
              child: Container(
                constraints:
                    const BoxConstraints(maxWidth: 150), // Set the max width
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the Row
                  children: [
                    Text(
                      'Chapters',
                      style: TextStyle(
                        fontFamily: 'Times',
                        color: !showVerses ? Colors.white : Colors.grey,
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
                        color: showVerses ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: () {},
                          ),
                          Text(
                            'Chapters ${currentChapterIndex + 1} ',
                            style: const TextStyle(
                                fontFamily: 'Times',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),

                    const Divider(
                      thickness: 1, // Line thickness
                      color: Colors.grey, // Line color
                      indent: 40, // Optional: add space from the left side
                      endIndent: 40, // Optional: add space from the right side
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
                                ...mockChapters[currentChapterIndex]
                                    .verses
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final index = entry.key;
                                  final verse = entry.value;
                                  if (index == 0) {
                                    return RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily:
                                                fontStyle["_selectedFont"],
                                            fontSize: double.parse(
                                                fontStyle["_fontSize"]
                                                    .toString()),
                                            height: 1.5),
                                        children: [
                                          TextSpan(
                                            text: verse.content[0],
                                            style: TextStyle(
                                              fontSize: 60,
                                              fontFamily:
                                                  fontStyle["_selectedFont"],
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
                                            fontStyle),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  // Handle the tap here
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
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
                                      // print('Previous section: $_currentSection');
                                      // print('New section: $section');

                                      // Update the parent state and modal state
                                      setState(() {
                                        _currentSection = section;
                                      });
                                      setModalState(
                                          () {}); // Rebuild the modal content
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
                                            MediaQuery.of(context).size.height *
                                                0.27,
                                      ),
                                      child: ContentSection(
                                        chapters:
                                            chapters, // Pass the chapters list
                                        noteList:
                                            noteList, // Pass the chapters list
                                        currentSection: _currentSection,
                                        highlight: colorsList,
                                        highlightedList: highlightedVerses,
                                        onSelectedHighlighter: (Color color) {
                                          selectedHighlighterColor(color);
                                        },
                                        onChangeChapter: (chapter) {
                                          changeChapter(chapter);
                                        },

                                        onChangeReadingStyle: (fontStyles) {
                                          changeFontStyle(fontStyles);
                                        },

                                        onChangeNewNote: (note) {
                                          addNewNote(note);
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
                borderRadius: BorderRadius.circular(
                    10), // Match the border radius of the container
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.7, // 70% of screen width
                  height: 20,

                  decoration: BoxDecoration(
                    gradient: globalGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Colors.blue,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

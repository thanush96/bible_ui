import 'package:flutter/material.dart';
import 'package:flutter_app/model/bible_content.dart';
import 'package:flutter_app/widgets/app_bar_icons.dart';
import 'package:flutter_app/widgets/content_section.dart';
import '../widgets/reader_header.dart';
import '../widgets/audio_player.dart';
import '../widgets/custom_selector_toolbar.dart';

final List<String> qualities = ['Low', 'Medium', 'High'];

class BibleReaderPage extends StatefulWidget {
  final CustomTextSelectionControls _customSelectionControls =
      CustomTextSelectionControls();
  BibleReaderPage({Key? key}) : super(key: key);

  @override
  State<BibleReaderPage> createState() => _BibleReaderPageState();
}

class _BibleReaderPageState extends State<BibleReaderPage> {
  bool isPlaying = false;
  bool showVerses = false;
  bool isPlayerExpanded = false;
  double audioProgress = 0.3;
  String _currentSection = 'chapters';

  void _changeSection(String section) {
    print('Changing section to $section');
    setState(() {
      _currentSection = section;
    });
  }

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
                          // Text(
                          //   '${mockChapter.chapterNumber}',
                          //   style: TextStyle(
                          //     fontSize: 120,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.grey.withOpacity(0.3),
                          //   ),
                          // ),
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
                                      // child: SelectableText.rich(
                                      //   TextSpan(text: "Hello World"),
                                      //   selectionControls:
                                      //       CustomTextSelectionControls(
                                      //           customButton: (start, end) {
                                      //     print(
                                      //       "Hello World".substring(start, end),
                                      //     );
                                      //   }),
                                      // ),

                                      child: SelectableText.rich(
                                        TextSpan(
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontFamily: 'Times',
                                              height: 1.5),
                                          children: [
                                            TextSpan(
                                              text: '${verse.verseNumber}. ',
                                              style: const TextStyle(
                                                  // fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontFamily: 'Times'),
                                            ),
                                            TextSpan(text: verse.content),
                                          ],
                                        ),
                                        selectionControls:
                                            CustomTextSelectionControls(),
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
            GestureDetector(
              onTap: () {
                setState(() {
                  isPlayerExpanded = !isPlayerExpanded;
                });
              },
              child: AudioPlayer(
                isExpanded: isPlayerExpanded,
                chapterTitle: 'Chapter ${mockChapter.chapterNumber}',
                verseExcerpt:
                    mockChapter.verses[0].content.substring(0, 30) + '...',
                progress: audioProgress,
                isPlaying: isPlaying,
                onClose: () {
                  setState(() {
                    isPlayerExpanded = false;
                  });
                },
                onPrevious: () {},
                onNext: () {},
                onPlayPause: () {
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled:
                true, // Allows for more control over height and margin
            backgroundColor:
                Colors.transparent, // Makes the modal background transparent
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.all(20), // Adds a 20px margin
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),

                //  decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(20),
                //   gradient: globalGradient,
                // ),

                // child: Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Column(
                //     mainAxisSize: MainAxisSize.min,
                //     children: qualities.map((quality) {
                //       return ListTile(
                //         title: Text(quality),
                //         onTap: () {
                //           // print('Selected quality: $quality');
                //           // Navigator.of(context).pop();
                //         },
                //       );
                //     }).toList(),
                //   ),
                // ),

                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Ensures Column takes minimum height
                    children: [
                      AppBarIcons(
                        onSectionChange: (String section) {
                          print('Previous section: $_currentSection');
                          print('New section: $section');

                          setState(() {
                            _currentSection = section;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Flexible(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height *
                                0.3, // Limit height
                          ),
                          child:
                              ContentSection(currentSection: _currentSection),
                        ),
                      ),
                    ],
                  ),
                ),
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

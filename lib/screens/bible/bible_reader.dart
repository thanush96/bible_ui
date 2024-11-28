import 'package:flutter/material.dart';
import 'package:flutter_app/screens/chapter_verse_view/chapter_verse_view.dart';
import 'package:flutter_app/screens/share_screen_view/share_screen_view.dart';
import 'package:flutter_app/values/app-font.dart';
import 'package:flutter_app/values/values.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
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
    selectedIndices = [];
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

  void changeChapterNext() {
    setState(() {
      currentChapterIndex = (currentChapterIndex + 1) % mockChapters.length;
    });
  }

  void changeChapterPrev() {
    setState(() {
      currentChapterIndex = (currentChapterIndex - 1) % mockChapters.length;
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
  bool createNewGroup = false;
  bool isPlayerExpanded = false;
  double audioProgress = 0.3;
  String _currentSection = 'chapters';
  bool _isContainerVisible = true;
  bool isBottomSheetOpen = false;
  bool isBottomSheetOpenFriendGroup = false;
  bool isBottomSheetOpenCreateNewGroup = false;
  final List<bool> _selectedProfiles = List.filled(items.length, false);
  late List<Map<String, String>> selectedIndices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
                    constraints: const BoxConstraints(
                        maxWidth: 200), // Set the max width
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: globalGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChapterVerseView(
                                  initialIndex: 1,
                                ),
                              ),
                            );

                            setState(() {
                              showVerses = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            decoration: BoxDecoration(
                              color: !showVerses
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Chapters',
                              style: TextStyle(
                                fontFamily: 'Times',
                                color: !showVerses
                                    ? AppColors.greyTitle
                                    : AppColors.white,
                                fontWeight: AppFont.fw400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 1,
                          height: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChapterVerseView(
                                  initialIndex: 2,
                                ),
                              ),
                            );
                            setState(() {
                              showVerses = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            decoration: BoxDecoration(
                              color: showVerses
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Verse',
                              style: TextStyle(
                                fontFamily: 'Times',
                                color: showVerses
                                    ? AppColors.greyTitle
                                    : AppColors.white,
                                fontWeight: AppFont.fw400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (createNewGroup && selectedIndices.isNotEmpty) ...[
                  //Create New Group View
                  AppSpaces.verticalSpace10,
                  const HeaderDivider(
                    headerCount: "52",
                    headerText: "Participants",
                  ),
                  AppSpaces.verticalSpace20,
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedIndices.length,
                        itemBuilder: (context, index) {
                          final isSelected = selectedIndices[index];
                          final item = items[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // Toggle the selection state
                                _selectedProfiles[index] =
                                    !_selectedProfiles[index];
                              });
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        child:
                                            SvgPicture.asset(item['imageUrl']!),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 8,
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: AppColors.greyTitle,
                                          child: const Icon(
                                            Icons.add,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['name']!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
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
                                onPressed: () {
                                  changeChapterPrev();
                                },
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
                                onPressed: () {
                                  changeChapterNext();
                                },
                              ),
                            ],
                          ),
                        ),

                        const Divider(
                          thickness: 1, // Line thickness
                          color: Colors.grey, // Line color
                          indent: 40, // Optional: add space from the left side
                          endIndent:
                              40, // Optional: add space from the right side
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
                                                  fontFamily: fontStyle[
                                                      "_selectedFont"],
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    verse.content.substring(1),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: SelectableText.rich(
                                            buildHighlightedText(
                                                verse.verseNumber,
                                                verse.content,
                                                highlightedVerses,
                                                fontStyle),
                                            selectionControls:
                                                CustomTextSelectionControls(
                                              onAddToFavorite: (id, title) {
                                                addToFavorites(id,
                                                    title); // Add to favorites
                                              },
                                              onHighlight: (verseNumber) {
                                                toggleHighlight(verseNumber);
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    }),
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
                      setState(() {
                        _isContainerVisible = !_isContainerVisible;
                        isBottomSheetOpen = !_isContainerVisible;
                      });

                      showModalBottomSheet(
                        barrierColor: Colors.transparent,
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context,
                                StateSetter setModalState) {
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
                                      Divider(
                                        thickness: 4,
                                        color: AppColors.white,
                                        indent: 40,
                                        endIndent: 40,
                                      ),
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
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
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
                                            onSelectedHighlighter:
                                                (Color color) {
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
                      ).whenComplete(() {
                        setState(() {
                          _isContainerVisible = !_isContainerVisible;
                          isBottomSheetOpen = !_isContainerVisible;
                        });
                      });
                    },
                    borderRadius: BorderRadius.circular(
                        10), // Match the border radius of the container
                    child: Visibility(
                      visible: _isContainerVisible,
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            0.7, // 70% of screen width
                        height: 20,
                        decoration: BoxDecoration(
                          gradient: globalGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Divider(
                          thickness: 2,
                          color: AppColors.white,
                          indent: 40,
                          endIndent: 40,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: isBottomSheetOpen
                  ? MediaQuery.of(context).size.height * 0.5
                  : isBottomSheetOpenFriendGroup
                      ? MediaQuery.of(context).size.height * 0.4
                      : isBottomSheetOpenCreateNewGroup
                          ? MediaQuery.of(context).size.height * 0.29
                          : 40,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _isContainerVisible = !_isContainerVisible;
                    isBottomSheetOpenFriendGroup = !_isContainerVisible;
                  });
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.transparent,
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
                              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Friend Group",
                                          style: TextStyle(
                                            fontSize: AppFont.textSize16,
                                            color: AppColors.white,
                                            fontWeight: AppFont.fw400,
                                          ),
                                        ),
                                        //create new group
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            setState(() {
                                              createNewGroup = !createNewGroup;
                                              _isContainerVisible =
                                                  !_isContainerVisible;
                                              isBottomSheetOpen == false;
                                              isBottomSheetOpenCreateNewGroup =
                                                  true;
                                              // isBottomSheetOpenFriendGroup =
                                              //     true;
                                            });

                                            showModalBottomSheet(
                                              barrierColor: Colors.transparent,
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              builder: (BuildContext context) {
                                                return StatefulBuilder(
                                                  builder:
                                                      (BuildContext context,
                                                          StateSetter
                                                              setModalState) {
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              20),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        gradient:
                                                            globalGradient,
                                                      ),
                                                      // decoration: BoxDecoration(
                                                      //   color: const Color.fromARGB(255, 255, 0, 0),
                                                      //   borderRadius: BorderRadius.circular(20),
                                                      // ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          10),
                                                              child: Divider(
                                                                thickness: 4,
                                                                color: AppColors
                                                                    .white,
                                                                indent: 60,
                                                                endIndent: 60,
                                                              ),
                                                            ),
                                                            Flexible(
                                                              child:
                                                                  ConstrainedBox(
                                                                constraints:
                                                                    BoxConstraints(
                                                                  maxHeight: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.2,
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          _buildIconWithLabel(
                                                                              'Microphone',
                                                                              Icons.mic_off_outlined),
                                                                          _buildIconWithLabel(
                                                                              'Sound',
                                                                              Icons.volume_up_sharp),
                                                                          _buildIconWithLabel(
                                                                            'Screen Share',
                                                                            Icons.ios_share_rounded,
                                                                          ),
                                                                          _buildIconWithLabel(
                                                                            'Emoji',
                                                                            Icons.emoji_emotions_outlined,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          _buildIconWithLabel(
                                                                            'Message',
                                                                            Icons.messenger_outline_rounded,
                                                                          ),
                                                                          _buildIconWithLabel(
                                                                            'Notebook',
                                                                            Icons.note_alt_outlined,
                                                                          ),
                                                                          _buildIconWithLabel(
                                                                            'High Lighter',
                                                                            Ionicons.pencil_outline,
                                                                          ),
                                                                          _buildIconWithLabel(
                                                                            '',
                                                                            Icons.more_horiz_outlined,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
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
                                            ).whenComplete(() {
                                              setState(() {
                                                _isContainerVisible =
                                                    !_isContainerVisible;
                                                isBottomSheetOpen =
                                                    !_isContainerVisible;
                                                isBottomSheetOpenCreateNewGroup =
                                                    !_isContainerVisible;
                                                isBottomSheetOpenFriendGroup =
                                                    !_isContainerVisible;
                                                createNewGroup = false;
                                              });
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 12, right: 12),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              'Create New Group',
                                              style: TextStyle(
                                                fontSize: AppFont.textSize12,
                                                fontFamily: 'Times',
                                                color: AppColors.greyTitle,
                                                fontWeight: AppFont.fw400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2,
                                    color: AppColors.scrollbarTrackColor,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                  Flexible(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.27,
                                      ),
                                      child: GridView.builder(
                                        padding: const EdgeInsets.only(top: 10),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          // mainAxisSpacing: 25.0,
                                          crossAxisSpacing: 10.0,
                                        ),
                                        itemCount: items.length + 1,
                                        itemBuilder: (context, index) {
                                          if (index == items.length) {
                                            return GestureDetector(
                                              onTap: () {
                                                print("toutapped add new");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ShareScreenView(),
                                                  ),
                                                );
                                              },
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 2),
                                                        ),
                                                        child: const Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                          size: 24,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          final isSelected =
                                              _selectedProfiles[index];
                                          final item = items[index];
                                          if (index != items.length) {
                                            return GestureDetector(
                                              onTap: () {
                                                print("touched");
                                                setState(() {
                                                  _selectedProfiles[index] =
                                                      !_selectedProfiles[index];
                                                  if (_selectedProfiles[
                                                      index]) {
                                                    selectedIndices.add(item);
                                                  } else {
                                                    selectedIndices.removeWhere(
                                                      (selectedItem) =>
                                                          selectedItem == item,
                                                    );
                                                  }
                                                  print(
                                                      selectedIndices); // Debug: Show current selections
                                                });
                                                setModalState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 25,
                                                        child: SvgPicture.asset(
                                                            item['imageUrl']!),
                                                      ),
                                                      Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        child: CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor:
                                                              isSelected
                                                                  ? AppColors
                                                                      .greyTitle
                                                                  : AppColors
                                                                      .greyTitle,
                                                          child: Icon(
                                                            isSelected
                                                                ? Icons.check
                                                                : Icons.add,
                                                            size: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    item['name']!,
                                                    style: TextStyle(
                                                        color: AppColors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          return null;
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
                  ).whenComplete(() {
                    setState(() {
                      _isContainerVisible = !_isContainerVisible;
                      isBottomSheetOpen = false;
                      isBottomSheetOpenFriendGroup = false;
                    });
                  });
                },
                elevation: 0,
                backgroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: AppColors.greyTitle, width: 1),
                ),
                child: Icon(
                  size: 26,
                  Icons.add,
                  color: AppColors.greyTitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildIconWithLabel(String name, IconData icon) {
  return Column(
    children: [
      Icon(
        icon,
        size: 26,
        color: AppColors.white,
      ),
      const SizedBox(height: 8),
      Text(
        name,
        style: TextStyle(
          color: AppColors.white,
          fontSize: AppFont.textSize10,
        ),
      ),
    ],
  );
}

final List<Map<String, String>> items = [
  {'imageUrl': 'assets/svg/user.svg', 'name': 'User 1'},
  {'imageUrl': 'assets/svg/user.svg', 'name': 'User 2'},
  {'imageUrl': 'assets/svg/user.svg', 'name': 'User 3'},
  {'imageUrl': 'assets/svg/user.svg', 'name': 'User 4'},
  {'imageUrl': 'assets/svg/user.svg', 'name': 'User 5'},
];

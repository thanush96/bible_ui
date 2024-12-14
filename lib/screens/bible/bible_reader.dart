import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bible/bible_reader_view_model.dart';
import 'package:flutter_app/screens/chapter_verse_view/chapter_verse_view.dart';
import 'package:flutter_app/screens/share_screen_view/share_screen_view.dart';
import 'package:flutter_app/values/app-font.dart';
import 'package:flutter_app/values/values.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:stacked/stacked.dart';
import '../../constants/constants.dart';
import '../../widgets/app_bar_icons.dart';
import '../../widgets/build_highlighted_text.dart';
import '../../widgets/content_section.dart';
import '../../widgets/music_player.dart';
import '../../widgets/reader_header.dart';
import '../../widgets/custom_selector_toolbar.dart';
import './../../tools/skeleton_loader.dart';

// New list to track highlighted verses
List<Map<String, dynamic>> highlightedVerses = [];

// ignore: must_be_immutable
class BibleReaderPage extends StatefulWidget {
  String bibleId;
  String chapterId;
  String bookId;
  String verseFind;
  BibleReaderPage(
      {super.key,
      required this.bibleId,
      required this.chapterId,
      required this.bookId,
      this.verseFind = ''});

  @override
  State<BibleReaderPage> createState() => _BibleReaderPageState();
}

class _BibleReaderPageState extends State<BibleReaderPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BibleReaderViewModel>.reactive(
        viewModelBuilder: () => BibleReaderViewModel(),
        onViewModelReady: (model) {
          model.setBusyForLoad();
          model.updateInitialParams(
              widget.bibleId, widget.chapterId, widget.bookId);
          model.bookDetailFetch(widget.bibleId, widget.bookId);
          model.chapterFetch(widget.bibleId, widget.chapterId, context);
          model.chapterListFetch(widget.bibleId, widget.bookId);
        },
        builder: (context, model, _) {
          return Scaffold(
            backgroundColor: const Color(0xFFECECFF),
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      ReaderHeader(
                        onBackPressed: () => Navigator.pop(context),
                        isPlaying: model.isPlaying,
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
                              maxWidth: 190), // Set the max width
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
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
                                        bibleId: widget.bibleId,
                                        bookId: widget.bookId,
                                        chapterId: widget.chapterId,
                                        title:
                                            model.bookDetailModel?.data.name ??
                                                "",
                                        subTitle: model.bookDetailModel?.data
                                                .nameLong ??
                                            "",
                                      ),
                                    ),
                                  );

                                  setState(() {
                                    model.showVerses = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12),
                                  decoration: BoxDecoration(
                                    color: !model.showVerses
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Chapters',
                                    style: TextStyle(
                                      fontFamily: 'Times',
                                      color: !model.showVerses
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
                                          bibleId: widget.bibleId,
                                          bookId: widget.bookId,
                                          chapterId: widget.chapterId,
                                          title: model
                                                  .bookDetailModel?.data.name ??
                                              "",
                                          subTitle: model.bookDetailModel?.data
                                                  .nameLong ??
                                              ""),
                                    ),
                                  );
                                  setState(() {
                                    model.showVerses = true;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12),
                                  decoration: BoxDecoration(
                                    color: model.showVerses
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Verse',
                                    style: TextStyle(
                                      fontFamily: 'Times',
                                      color: model.showVerses
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
                      //Create New Group View
                      if (model.createNewGroup &&
                          model.selectedIndices.isNotEmpty) ...[
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
                              itemCount: model.selectedIndices.length,
                              itemBuilder: (context, index) {
                                final item = model.selectedIndices[index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // Toggle the selection state
                                      model.selectedProfiles[index] =
                                          !model.selectedProfiles[index];
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            CircleAvatar(
                                              radius: 40,
                                              child: SvgPicture.asset(
                                                  item['imageUrl']!),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: 8,
                                              child: CircleAvatar(
                                                radius: 12,
                                                backgroundColor:
                                                    AppColors.greyTitle,
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

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              onPressed: () {
                                model.changeChapterPrev(context);
                              },
                            ),
                            Text(
                              'Chapters ${model.ChapterID} ',
                              style: const TextStyle(
                                  fontFamily: 'Times',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed: () {
                                model.changeChapterNext(context);
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

                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          (model.isBusy)
                                              ? const MySkeletonLoader()
                                              : SelectableText.rich(
                                                  buildHighlightedText(
                                                    null,
                                                    model
                                                        .chapterListViewModel[0]
                                                        .data
                                                        .content,
                                                    highlightedVerses,
                                                    model.fontStyle,
                                                    widget.verseFind,
                                                  ),
                                                  selectionControls:
                                                      CustomTextSelectionControls(
                                                    onAddToFavorite:
                                                        (id, title) {
                                                      model.addToFavorites(id,
                                                          title); // Add to favorites
                                                    },
                                                    onHighlight: (verseNumber) {
                                                      model.toggleHighlight(
                                                          verseNumber);
                                                    },
                                                  ),
                                                ),
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
                        child: AbsorbPointer(
                          absorbing: model.isBusy,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                model.isContainerVisible =
                                    !model.isContainerVisible;
                                model.isBottomSheetOpen =
                                    !model.isContainerVisible;
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: globalGradient,
                                        ),
                                        // decoration: BoxDecoration(
                                        //   color: const Color.fromARGB(255, 255, 0, 0),
                                        //   borderRadius: BorderRadius.circular(20),
                                        // ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Divider(
                                                thickness: 4,
                                                color: AppColors.white,
                                                indent: 60,
                                                endIndent: 60,
                                              ),
                                              AppBarIcons(
                                                onSectionChange:
                                                    (String section) {
                                                  // print('Previous section: $_currentSection');
                                                  // print('New section: $section');

                                                  // Update the parent state and modal state
                                                  setState(() {
                                                    model.currentSection =
                                                        section;
                                                  });
                                                  setModalState(
                                                      () {}); // Rebuild the modal content
                                                },
                                                currentSection:
                                                    model.currentSection,
                                              ),
                                              const Divider(
                                                thickness: 1, // Line thickness
                                                color:
                                                    Colors.grey, // Line color
                                                indent:
                                                    20, // Optional: add space from the left side
                                                endIndent:
                                                    20, // Optional: add space from the right side
                                              ),
                                              Flexible(
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                    maxHeight:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.27,
                                                  ),
                                                  child: ContentSection(
                                                    chapters: model
                                                        .chapterListDataViewModel, // Pass the chapters list
                                                    noteList: model
                                                        .noteList, // Pass the chapters list
                                                    currentSection:
                                                        model.currentSection,
                                                    highlight: model.colorsList,
                                                    highlightedList:
                                                        highlightedVerses,
                                                    onSelectedHighlighter:
                                                        (Color color) {
                                                      model
                                                          .selectedHighlighterColor(
                                                              color);
                                                    },
                                                    onChangeChapter:
                                                        (chapterId) {
                                                      model.changeChapter(
                                                          chapterId, context);
                                                    },

                                                    onChangeReadingStyle:
                                                        (fontStyles) {
                                                      model.changeFontStyle(
                                                          fontStyles);
                                                    },

                                                    onChangeNewNote: (note) {
                                                      model.addNewNote(note);
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
                                  model.isContainerVisible =
                                      !model.isContainerVisible;
                                  model.isBottomSheetOpen =
                                      !model.isContainerVisible;
                                });
                              });
                            },
                            borderRadius: BorderRadius.circular(
                                10), // Match the border radius of the container
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Visibility(
                                visible: model.isContainerVisible,
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.7, // 70% of screen width
                                  height: 20,
                                  decoration: BoxDecoration(
                                    gradient: globalGradient,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Divider(
                                    thickness: 4,
                                    color: AppColors.white,
                                    indent: 60,
                                    endIndent: 60,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: model.isBottomSheetOpen
                        ? MediaQuery.of(context).size.height * 0.5
                        : model.isBottomSheetOpenFriendGroup
                            ? MediaQuery.of(context).size.height * 0.4
                            : model.isBottomSheetOpenCreateNewGroup
                                ? MediaQuery.of(context).size.height * 0.29
                                : 40,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          model.isContainerVisible = !model.isContainerVisible;
                          model.isBottomSheetOpenFriendGroup =
                              !model.isContainerVisible;
                        });
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          barrierColor: Colors.transparent,
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
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 0),
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
                                                    model.createNewGroup =
                                                        !model.createNewGroup;
                                                    model.isContainerVisible =
                                                        !model
                                                            .isContainerVisible;
                                                    model.isBottomSheetOpen ==
                                                        false;
                                                    model.isBottomSheetOpenCreateNewGroup =
                                                        true;
                                                    // isBottomSheetOpenFriendGroup =
                                                    //     true;
                                                  });

                                                  showModalBottomSheet(
                                                    barrierColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    builder:
                                                        (BuildContext context) {
                                                      return StatefulBuilder(
                                                        builder: (BuildContext
                                                                context,
                                                            StateSetter
                                                                setModalState) {
                                                          return Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
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
                                                                      .all(
                                                                      10.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            10),
                                                                    child:
                                                                        Divider(
                                                                      thickness:
                                                                          4,
                                                                      color: AppColors
                                                                          .white,
                                                                      indent:
                                                                          60,
                                                                      endIndent:
                                                                          60,
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                        ConstrainedBox(
                                                                      constraints:
                                                                          BoxConstraints(
                                                                        maxHeight:
                                                                            MediaQuery.of(context).size.height *
                                                                                0.2,
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                20,
                                                                            right:
                                                                                20),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                _buildIconWithLabel('Microphone', Icons.mic_off_outlined),
                                                                                _buildIconWithLabel('Sound', Icons.volume_up_sharp),
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
                                                                              height: 20,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                      model.isContainerVisible =
                                                          !model
                                                              .isContainerVisible;
                                                      model.isBottomSheetOpen =
                                                          !model
                                                              .isContainerVisible;
                                                      model.isBottomSheetOpenCreateNewGroup =
                                                          !model
                                                              .isContainerVisible;
                                                      model.isBottomSheetOpenFriendGroup =
                                                          !model
                                                              .isContainerVisible;
                                                      model.createNewGroup =
                                                          false;
                                                    });
                                                  });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Text(
                                                    'Create New Group',
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppFont.textSize12,
                                                      fontFamily: 'Times',
                                                      color:
                                                          AppColors.greyTitle,
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
                                              maxHeight: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.27,
                                            ),
                                            child: GridView.builder(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
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
                                                      print(
                                                          "toutapped add new");
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
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Container(
                                                              width: 40,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                shape: BoxShape
                                                                    .circle,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .transparent,
                                                                    width: 2),
                                                              ),
                                                              child: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                                size: 24,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                                final isSelected = model
                                                    .selectedProfiles[index];
                                                final item = items[index];
                                                if (index != items.length) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      print("touched");
                                                      setState(() {
                                                        model.selectedProfiles[
                                                            index] = !model
                                                                .selectedProfiles[
                                                            index];
                                                        if (model
                                                                .selectedProfiles[
                                                            index]) {
                                                          model.selectedIndices
                                                              .add(item);
                                                        } else {
                                                          model.selectedIndices
                                                              .removeWhere(
                                                            (selectedItem) =>
                                                                selectedItem ==
                                                                item,
                                                          );
                                                        }
                                                        print(model
                                                            .selectedIndices); // Debug: Show current selections
                                                      });
                                                      setModalState(() {});
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 25,
                                                              child: SvgPicture
                                                                  .asset(item[
                                                                      'imageUrl']!),
                                                            ),
                                                            Positioned(
                                                              bottom: 0,
                                                              right: 0,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 10,
                                                                backgroundColor: isSelected
                                                                    ? AppColors
                                                                        .greyTitle
                                                                    : AppColors
                                                                        .greyTitle,
                                                                child: Icon(
                                                                  isSelected
                                                                      ? Icons
                                                                          .check
                                                                      : Icons
                                                                          .add,
                                                                  size: 12,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          item['name']!,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textAlign:
                                                              TextAlign.center,
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
                            model.isContainerVisible =
                                !model.isContainerVisible;
                            model.isBottomSheetOpen = false;
                            model.isBottomSheetOpenFriendGroup = false;
                          });
                        });
                      },
                      elevation: 0,
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.black12, width: 1),
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
        });
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

import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:flutter_app/model/bible_content.dart';
import 'package:flutter_app/model/chapter_model.dart';
import 'package:flutter_app/screens/bible/bible_reader.dart';
import 'package:flutter_app/services/chapter_service.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../model/chapter_list_model.dart';

class BibleReaderViewModel extends BaseViewModel {
  List<Map<String, String>> chapters = [];
  List<Map<String, dynamic>> noteList = [];
  // List<Map<String, String>> fontStyleData = [];
  Map<String, dynamic> fontStyle = {
    "_selectedFont": "Times New Roman",
    "_fontSize": 16
  };
  late int currentChapterIndex = 1;
  late Color highlight = Colors.red.shade200;

  final List<Color> colorsList = [
    Colors.yellow.shade200,
    Colors.blue.shade200,
    Colors.red.shade200,
  ];

  // void initState() {
  //   super.initState();
  //   selectedIndices = [];
  // }
  String _bibleID = "";
  String get BibleID => _bibleID;
  set setBibleID(String value) => _bibleID = value;

  String _bookInitialID = "";
  String get BookInitialID => _bookInitialID;
  set setBookInitialID(String value) => _bookInitialID = value;

  String _nextBookID = "";
  String get NextBookID => _nextBookID;
  set setNextBookID(String value) => _nextBookID = value;

  String _preBookID = "";
  String get PreBookID => _preBookID;
  set setPreBookID(String value) => _preBookID = value;

  String _chapterID = "";
  String get ChapterID => _chapterID;
  set setChapterID(String value) => _chapterID = value;

  String _nextChapter = "";
  String get NextChapter => _nextChapter;
  set setNextChapter(String value) => _nextChapter = value;

  String _prevChapter = "";
  String get PrevChapter => _prevChapter;
  set setPrevChapter(String value) => _prevChapter = value;

  void updateInitialParams(String bibleID, String chapterID, String bookID) {
    setBibleID = bibleID;
    setChapterID = chapterID;
    setBookInitialID = bookID;
    notifyListeners();
  }

  void setBusyForLoad() {
    setBusy(true);
  }

  //dart fetch spec chapter
  final List<ChapterViewModel> _chapterListViewModel = [];
  List<ChapterViewModel> get chapterListViewModel => _chapterListViewModel;

  late ChapterViewModel chapterViewModel;

  Future<void> chapterFetch(
      String bibleID, String chapterID, BuildContext context) async {
    try {
      if (BibleID.isEmpty && ChapterID.isEmpty) return;

      chapterViewModel = await ChapterService.chapterContentFetch(
        bibleID: bibleID,
        chapterID: chapterID,
        context: context,
      );
      setPrevChapter = chapterViewModel.data.previous?.id ?? "";
      setNextChapter = chapterViewModel.data.next?.id ?? "";
      setNextBookID = chapterViewModel.data.next?.bookId ?? "";
      setPreBookID = chapterViewModel.data.previous?.bookId ?? "";
      if (chapterViewModel.data.content != "") {
        chapterViewModel.data.content =
            formatContent(chapterViewModel.data.content);
      }
      _chapterListViewModel.add(chapterViewModel);
      notifyListeners();
    } catch (error) {
      throw Exception('Error parsing JSON : $error');
    } finally {
      setBusy(false);
    }
  }

  // Dart service to fetch chapter list data
  final List<ChapterListDataViewModel> _chapterListDataViewModel = [];
  List<ChapterListDataViewModel> get chapterListDataViewModel =>
      _chapterListDataViewModel;

  late ChapterListDataViewModel chapterListDatasViewModel;

  Future<void> chapterListFetch(String bibleID, String bookID) async {
    try {
      if (bibleID.isEmpty || bookID.isEmpty) return;
      // Fetch the chapter list data from the service
      chapterListDatasViewModel = await ChapterListService.chapterListFetch(
          bibleID: bibleID, bookID: bookID);
      _chapterListDataViewModel.add(chapterListDatasViewModel);
      notifyListeners();
    } catch (error) {
      throw Exception('Error fetching chapter list data: $error');
    } finally {}
  }

  String formatContent(String content) {
    content = content.replaceAll('\n', '');
    final regex = RegExp(r'\[(.*?)\]');
    return content.replaceAllMapped(regex, (match) {
      return '\n\n${match.group(0)}';
    });
  }

  void loadChapter(int index) {
    currentChapterIndex = index;
  }

  void changeChapter(Map<String, String> chapter, BuildContext context) {
    setChapterID = chapter['chapterId'] ?? "";
    setBusy(true);
    chapterFetch(BibleID, ChapterID, context);
    notifyListeners();
  }

  void changeChapterNext(BuildContext context) {
    setBusy(true);
    chapterFetch(BibleID, NextChapter, context);
    setChapterID = NextChapter;
    chapterListViewModel.clear();
    if (BookInitialID != NextBookID) {
      setBookInitialID = NextBookID;
      chapterListDataViewModel.clear();
      chapterListFetch(BibleID, BookInitialID);
    }
    //currentChapterIndex = (currentChapterIndex + 1) % mockChapters.length;
    notifyListeners();
  }

  void changeChapterPrev(BuildContext context) {
    setBusy(true);
    chapterFetch(BibleID, PrevChapter, context);
    setChapterID = PrevChapter;
    chapterListViewModel.clear();
    if (BookInitialID != PreBookID) {
      setBookInitialID = PreBookID;
      chapterListDataViewModel.clear();
      chapterListFetch(BibleID, BookInitialID);
    }
    // currentChapterIndex = (currentChapterIndex - 1) % mockChapters.length;
    notifyListeners();
  }

  void changeFontStyle(Map<String, dynamic> newFontStyle) {
    // print('newFontStyle $newFontStyle');
    fontStyle = newFontStyle;
    notifyListeners();
  }

  void addToFavorites(String id, String title) {
    chapters.add({
      "id": id,
      "title": title,
      'time': DateFormat('dd/MM/yyyy').format(DateTime.now())
    }); // Add new content
  }

  void addNewNote(note) {
    noteList.add({
      'id': note['id'],
      'note': note['note'],
      'time': DateFormat('dd/MM/yyyy').format(DateTime.now())
    }); // Add new content
  }

  void selectedHighlighterColor(Color color) {
    highlight = color;
    notifyListeners();
  }

  void toggleHighlight(String verse) {
    bool verseExists =
        highlightedVerses.any((highlight) => highlight['verse'] == verse);

    if (verseExists) {
      highlightedVerses.removeWhere((highlight) => highlight['verse'] == verse);
    } else {
      highlightedVerses.add({
        'chapter': '1',
        'time': DateFormat('dd/MM/yyyy').format(DateTime.now()),
        'verse': verse,
        'color': highlight,
      });
    }

    print(highlightedVerses);
    notifyListeners();
  }

  bool isPlaying = false;
  bool showVerses = false;
  bool createNewGroup = false;
  bool isPlayerExpanded = false;
  double audioProgress = 0.3;
  String currentSection = 'chapters';
  bool isContainerVisible = true;
  bool isBottomSheetOpen = false;
  bool isBottomSheetOpenFriendGroup = false;
  bool isBottomSheetOpenCreateNewGroup = false;
  final List<bool> selectedProfiles = List.filled(items.length, false);
  late List<Map<String, String>> selectedIndices;
}

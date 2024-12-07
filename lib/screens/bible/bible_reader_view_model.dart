import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/bible_content.dart';
import 'package:flutter_app/model/chapter_model.dart';
import 'package:flutter_app/screens/bible/bible_reader.dart';
import 'package:flutter_app/services/chapter_service.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class BibleReaderViewModel extends BaseViewModel {
  List<Map<String, String>> chapters = [];
  List<Map<String, dynamic>> noteList = [];
  // List<Map<String, String>> fontStyleData = [];
  Map<String, dynamic> fontStyle = {
    "_selectedFont": "Times New Roman",
    "_fontSize": 16.721590283890844
  };
  @override
  late int currentChapterIndex = 0;
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

  String _chapterID = "";
  String get ChapterID => _chapterID;
  set setChapterID(String value) => _chapterID = value;

  String _nextChapter = "";
  String get NextChapter => _nextChapter;
  set setNextChapter(String value) => _nextChapter = value;

  String _prevChapter = "";
  String get PrevChapter => _prevChapter;
  set setPrevChapter(String value) => _prevChapter = value;

  void updateInitialParams(String bibleID, String chapterID) {
    setBibleID = bibleID;
    setChapterID = chapterID;
    notifyListeners();
  }

  final List<ChapterViewModel> _chapterListViewModel = [];
  List<ChapterViewModel> get chapterListViewModel => _chapterListViewModel;

  late ChapterViewModel chapterViewModel;

  Future<void> chapterFetch(String bibleID, String chapterID) async {
    try {
      if (BibleID.isEmpty && ChapterID.isEmpty) return;

      setBusy(true);
      chapterViewModel = await ChapterService.chapterContentFetch(
          bibleID: bibleID, chapterID: chapterID);
      setPrevChapter = chapterViewModel.data.previous.id;
      setNextChapter = chapterViewModel.data.next.id;
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

  void changeChapter(chapter) {
    currentChapterIndex = int.parse(chapter['id'] ?? '0');
    notifyListeners();
  }

  void changeChapterNext() {
    chapterFetch(BibleID, NextChapter);
    chapterListViewModel.clear();
    //currentChapterIndex = (currentChapterIndex + 1) % mockChapters.length;
    notifyListeners();
  }

  void changeChapterPrev() {
    chapterFetch(BibleID, PrevChapter);
    chapterListViewModel.clear();
    // currentChapterIndex = (currentChapterIndex - 1) % mockChapters.length;
    notifyListeners();
  }

  void changeFontStyle(Map<String, dynamic> newFontStyle) {
    fontStyle = newFontStyle;
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

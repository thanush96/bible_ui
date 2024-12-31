import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/book_detail_model.dart';
import 'package:flutter_app/model/chapter_model.dart';
import 'package:flutter_app/screens/bible/bible_reader.dart';
import 'package:flutter_app/services/chapter_service.dart';
import 'package:flutter_app/services/http_service.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stacked/stacked.dart';
import '../../model/chapter_list_model.dart';
import '../../services/firestore_service.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

class BibleReaderViewModel extends BaseViewModel {
  // final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> chapters = [];
  List<Map<String, dynamic>> noteList = [];
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

  String? _nextChapter = "";
  String? get NextChapter => _nextChapter;
  set setNextChapter(String? value) => _nextChapter = value;

  String? _prevChapter = "";
  String? get PrevChapter => _prevChapter;
  set setPrevChapter(String? value) => _prevChapter = value;

  String _language = "";
  String get language => _language;
  set setLanguage(String value) => _language = value;

  String _lyrics = "";
  String get lyrics => _lyrics;
  set setLyrics(String value) => _lyrics = value;

  bool _playerLoad = false;
  bool get playerLoad => _playerLoad;
  set setPlayerLoad(bool value) => _playerLoad = value;

  bool _animate = false;
  bool get animate => _animate;
  set setAnimate(bool value) => _animate = value;

  bool _chapListLoads = false;
  bool get chapListLoads => _chapListLoads;
  set setChapListLoads(bool value) => _chapListLoads = value;

  void setPlayerLoads() {
    setPlayerLoad = true;
    notifyListeners();
  }

  void setPlayerLoadsEnd() {
    setPlayerLoad = false;
    notifyListeners();
  }

  final String _apiUrl =
      "https://multilingual-tts-979650137903.us-central1.run.app/generate-audio";
  late final AudioPlayer _audioPlayer = AudioPlayer();
  String? _audioFilePath;
  String? get audioFilePath => _audioFilePath;

  String? _extractContent;
  String? get extractContent => _extractContent;

  void getFirst10Words(String content) {
    List<String> words = content.split(RegExp(r'\s+'));
    List<String> first10Words = words.take(5).toList();
    _extractContent = first10Words.take(5).join(' ');
  }

  Future<void> generateAndSaveAudio(BuildContext context) async {
    try {
      final content = chapterViewModel.data.content.toString();
      final int length = content.length;

      // Calculate the range for the selected quarter
      final int startIndex = (length / 4).round();
      final int endIndex = (length / 4).round();

      // Get the specific quarter data
      final String quarterData = content.substring(1, endIndex);
      setLyrics = quarterData;
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "language": language,
          "text": "$quarterData.",
          // "text":
          //     "To ensure that the audio restarts from the beginning when the play button is touched after the audio finishes, you need to reset the audio player’s position to the start. You can achieve this by seeking to the start of the audio when the play button is pressed again."
        }),
        // body:
        //     '{"language": "$language", "text": "தேவன், தம்முடைய ஒரேபேறான குமாரனை."}',
      );

      if (response.statusCode == 200) {
        const directoryPath = "/data/data/com.example.flutter_app/files";
        final filePath = p.join(directoryPath, "tts_audio1.wav");

        final directory = Directory(directoryPath);
        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
        }

        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        _audioFilePath = filePath;
        setPlayerLoadsEnd();
      } else {
        throw Exception("Failed to generate audio: ${response.reasonPhrase}");
      }
    } catch (e) {
      printStatement(e);
    }
  }

  Future<void> playAudio(BuildContext context) async {
    if (_audioFilePath != null) {
      try {
        await _audioPlayer.setFilePath(_audioFilePath!);

        _audioPlayer.play();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error playing audio: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No audio file to play")),
      );
    }
  }

  void updateInitialParams(String bibleID, String chapterID, String bookID) {
    setBibleID = bibleID;
    setChapterID = chapterID;
    setBookInitialID = bookID;
    notifyListeners();
  }

  void setBusyForLoad() {
    setBusy(true);
    setChapListLoads = true;
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
        setPlayerLoads();
        generateAndSaveAudio(context);
        chapterViewModel.data.content =
            formatContent(chapterViewModel.data.content);
      }
      getFirst10Words(chapterViewModel.data.content);
      _chapterListViewModel.add(chapterViewModel);
      notifyListeners();
    } catch (error) {
      throw Exception('Error parsing JSON : $error');
    } finally {
      fetchFavorites();
      fetchHighlights();
      fetchNotes();
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
    } finally {
      setChapListLoads = false;
    }
  }

  String formatContent(String content) {
    content = content.replaceAll('\n', '');
    final regex = RegExp(r'\[(.*?)\]');
    return content.replaceAllMapped(regex, (match) {
      return '\n${match.group(0)}';
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
    chapterFetch(BibleID, NextChapter!, context);
    setChapterID = NextChapter!;
    chapterListViewModel.clear();
    if (BookInitialID != NextBookID) {
      setBookInitialID = NextBookID;
      chapterListDataViewModel.clear();
      chapterListFetch(BibleID, BookInitialID);
    }
    //currentChapterIndex = (currentChapterIndex + 1) % mockChapters.length;
    notifyListeners();
  }

  BookDetailModel? bookDetailModel;

  Future<void> bookDetailFetch(String bibleID, String bookID) async {
    try {
      if (bibleID.isEmpty || bookID.isEmpty) return;
      // Fetch the chapter list data from the service
      bookDetailModel = await ChapterService.BookDetailFetch(
          bibleID: bibleID, bookID: bookID);

      notifyListeners();
    } catch (error) {
      throw Exception('Error fetching book details data: $error');
    } finally {}
  }

  void changeChapterPrev(BuildContext context) {
    setBusy(true);
    chapterFetch(BibleID, PrevChapter!, context);
    setChapterID = PrevChapter!;
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

  void addToFavorites(String id, String title) async {
    chapters.add({
      'userID': 'userID', //put user id here
      'bibleID': BibleID,
      'bookID': BookInitialID,
      'chapterID': ChapterID,
      "id": id,
      "title": title,
      'time': DateFormat('dd/MM/yyyy').format(DateTime.now())
    }); // Add new content

    // try {
    //   setBusy(true);
    //   await _firestoreService.saveFavorite(
    //     userId: 'user-id', // Replace with actual user ID
    //     bibleId: BibleID,
    //     bookId: BookInitialID,
    //     chapterId: ChapterID,
    //     id: id,
    //     title: title,
    //   );
    // } catch (e) {
    //   print('Error adding to favorites: $e');
    // } finally {
    //   setBusy(false);
    // }
  }

  void addNewNote(note) async {
    noteList.add({
      'userID': 'userID', //put user id here
      'bibleID': BibleID,
      'bookID': BookInitialID,
      'chapterID': ChapterID,
      'id': note['id'],
      'note': note['note'],
      'time': DateFormat('dd/MM/yyyy').format(DateTime.now())
    }); // Add new content

    // try {
    //   setBusy(true);
    //   await _firestoreService.saveNote(
    //     userId: 'user-id', // Replace with actual user ID
    //     bibleId: BibleID,
    //     bookId: BookInitialID,
    //     chapterId: ChapterID,
    //     id: note['id'],
    //     note: note['note'],
    //   );
    // } catch (e) {
    //   print('Error saving note: $e');
    // } finally {
    //   setBusy(false);
    // }
  }

  void selectedHighlighterColor(Color color) {
    highlight = color;
    notifyListeners();
  }

  void toggleHighlight(String verse, {String color = 'yellow'}) async {
    bool verseExists =
        highlightedVerses.any((highlight) => highlight['verse'] == verse);

    if (verseExists) {
      highlightedVerses.removeWhere((highlight) => highlight['verse'] == verse);
    } else {
      highlightedVerses.add({
        'userID': 'userID', //put user id here
        'bibleID': BibleID,
        'bookID': BookInitialID,
        'chapterID': ChapterID,
        'time': DateFormat('dd/MM/yyyy').format(DateTime.now()),
        'verse': verse,
        'color': highlight,
      });

      //   try {
      //     setBusy(true);
      //     await _firestoreService.saveHighlight(
      //       userId: 'user-id', // Replace with actual user ID
      //       bibleId: BibleID,
      //       bookId: BookInitialID,
      //       chapterId: ChapterID,
      //       verse: verse,
      //       color: highlight,
      //     );
      //   } catch (e) {
      //     print('Error saving highlight: $e');
      //   } finally {
      //     setBusy(false);
      //   }
    }

    print(highlightedVerses);
    notifyListeners();
  }

  //=====================================================================
  //=====================================================================
  //===============================Get====================================
  //=====================================================================
  //=====================================================================
  // Fetch notes from Firestore
  Future<void> fetchNotes() async {
    try {
      // setBusy(true);
      // noteList = await _firestoreService.fetchNotes(
      //   userId: 'userId',
      //   bibleId: BibleID,
      //   bookId: BookInitialID,
      //   chapterId: ChapterID,
      // );
      notifyListeners();
    } catch (e) {
      print('Error fetching notes: $e');
    } finally {
      // setBusy(false);
    }
  }

  // Fetch favorites from Firestore
  Future<void> fetchFavorites() async {
    try {
      // setBusy(true);
      // chapters = await _firestoreService.fetchFavorites(
      //   userId: 'userId',
      //   bibleId: BibleID,
      //   bookId: BookInitialID,
      //   chapterId: ChapterID,
      // );
      notifyListeners();
    } catch (e) {
      print('Error fetching favorites: $e');
    } finally {
      // setBusy(false);
    }
  }

  // Fetch highlights from Firestore
  Future<void> fetchHighlights() async {
    try {
      setBusy(true);
      // highlightedVerses = await _firestoreService.fetchHighlights(
      //   userId: 'userId',
      //   bibleId: BibleID,
      //   bookId: BookInitialID,
      //   chapterId: ChapterID,
      // );
      notifyListeners();
    } catch (e) {
      print('Error fetching highlights: $e');
    } finally {
      setBusy(false);
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

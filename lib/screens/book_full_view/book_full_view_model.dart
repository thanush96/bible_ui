// import 'package:flutter/widgets.dart';
// import 'package:flutter_app/model/chapter_model.dart';
// import 'package:flutter_app/services/chapter_service.dart';
// import 'package:stacked/stacked.dart';

// class BookFullViewModel extends BaseViewModel {
//   String _bibleID = "";
//   String get BibleID => _bibleID;
//   set setBibleID(String value) => _bibleID = value;

//   String _chapterID = "";
//   String get ChapterID => _chapterID;
//   set setChapterID(String value) => _chapterID = value;

//   void updateInitialParams(
//     String bibleID,
//     String chapterID,
//   ) {
//     setBibleID = bibleID;
//     setChapterID = chapterID;
//     notifyListeners();
//   }

//   void setBusyForLoad() {
//     setBusy(true);
//   }

//   final List<ChapterViewModel> _chapterListViewModel = [];
//   List<ChapterViewModel> get chapterListViewModel => _chapterListViewModel;

//   late ChapterViewModel chapterViewModel;

//   Future<void> chapterFetch(
//     String bibleID,
//     String chapterID,
//     BuildContext context,
//   ) async {
//     try {
//       if (BibleID.isEmpty && ChapterID.isEmpty) return;

//       chapterViewModel = await ChapterService.chapterContentFetch(
//           bibleID: bibleID, chapterID: "$chapterID.intro", context: context);
//       _chapterListViewModel.add(chapterViewModel);
//       notifyListeners();
//     } catch (error) {
//       throw Exception('Error parsing JSON : $error');
//     } finally {
//       setBusy(false);
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/model/chapter_model.dart';
import 'package:flutter_app/services/chapter_service.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../provider/bible_id_provider.dart';

class BookFullViewModel extends BaseViewModel {
  String _bibleID = "";
  String get bibleID => _bibleID;
  set setBibleID(String value) => _bibleID = value;

  String _chapterID = "";
  String get chapterID => _chapterID;
  set setChapterID(String value) => _chapterID = value;

  void updateInitialParams(String bibleID, String chapterID) {
    setBibleID = bibleID;
    setChapterID = chapterID;
    notifyListeners();
  }

  void setBusyForLoad() {
    setBusy(true);
  }

  final List<ChapterViewModel> _chapterListViewModel = [];
  List<ChapterViewModel> get chapterListViewModel => _chapterListViewModel;

  late ChapterViewModel chapterViewModel;

  Future<void> chapterFetch(
    String bibleID,
    String chapterID,
    BuildContext context,
  ) async {
    try {
      if (bibleID.isEmpty && chapterID.isEmpty) return;

      // Fetch chapter content
      chapterViewModel = await ChapterService.chapterContentFetch(
        bibleID: bibleID,
        chapterID: "$chapterID.intro",
        context: context,
      );

      _chapterListViewModel.add(chapterViewModel);
      notifyListeners();
    } catch (error) {
      debugPrint('Error fetching chapter: $error');
      throw Exception('Failed to fetch chapter: $error');
    } finally {
      setBusy(false);
    }
  }
}

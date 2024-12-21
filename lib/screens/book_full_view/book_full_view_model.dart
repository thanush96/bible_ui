import 'package:flutter/widgets.dart';
import 'package:flutter_app/model/chapter_model.dart';
import 'package:flutter_app/services/chapter_service.dart';
import 'package:stacked/stacked.dart';

import '../../services/firestore_service.dart';

class BookFullViewModel extends BaseViewModel {
//  final FirestoreService _firestoreService = FirestoreService();

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

  void addToFavouriteBook(String abbreviation, String bibleId, String imageUrl,
      String subTitle, String summary, String title, String id) async {
    // print(BibleID);
    // print(bookId);
    // print(title);
    try {
      setBusy(true);
      // await _firestoreService.addToFavouriteBookService(
      //   // userId: 'user-id', // Replace with actual user ID
      //   // bibleId: BibleID,
      //   // bookId: bookId,
      //   // title: title,
      //   userId: 'user-id', // Replace with actual user ID
      //   abbreviation: abbreviation,
      //   bibleId: bibleId,
      //   imageUrl: imageUrl,
      //   subTitle: subTitle,
      //   summary: summary,
      //   title: title,
      //   id: id,
      // );
    } catch (e) {
      print('Error adding to favorites: $e');
    } finally {
      setBusy(false);
    }
  }
}

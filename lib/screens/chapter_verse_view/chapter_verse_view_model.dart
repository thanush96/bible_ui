import 'package:flutter_app/model/book_detail_model.dart';
import 'package:flutter_app/model/chapter_list_model.dart';
import 'package:flutter_app/model/chapter_verses_model.dart';
import 'package:flutter_app/model/verses_content_model.dart';
import 'package:flutter_app/services/chapter_service.dart';
import 'package:stacked/stacked.dart';

class ChapterVerseViewModel extends BaseViewModel {
  bool _isBookDetailBusy = false;
  bool _isChapterListBusy = false;

  bool get isBookDetailBusy => _isBookDetailBusy;
  bool get isChapterListBusy => _isChapterListBusy;

  bool _isBusyBook = false;
  bool get isBusyBook => _isBusyBook;
  set setIsBusyBook(bool value) => _isBusyBook = value;

  bool _isBusyChapterLoad = false;
  bool get isBusyChapterLoad => _isBusyChapterLoad;
  set setIsBusyChapterLoad(bool value) => _isBusyChapterLoad = value;

  bool _isBusyVerseLoad = false;
  bool get isBusyVerseLoad => _isBusyVerseLoad;
  set setIsBusyVerseLoad(bool value) => _isBusyVerseLoad = value;

  String _bibleID = "";
  String get BibleID => _bibleID;
  set setBibleID(String value) => _bibleID = value;

  String _versesFind = "";
  String get VersesFind => _versesFind;
  set setVersesFind(String value) => _versesFind = value;

  void updateInitialParams(
    String bibleID,
  ) {
    setBibleID = bibleID;
  }

  void setBusyForLoad() {
    setIsBusyBook = true;
  }

  void setBusyForLoadConcatinate() {
    setIsBusyBook = !(isBookDetailBusy && isChapterListBusy);
    notifyListeners();
  }

// Dart service to fetch chapter list data
  final List<ChapterListDataViewModel> _chapterListDataViewModel = [];
  List<ChapterListDataViewModel> get chapterListDataViewModel =>
      _chapterListDataViewModel;

  late ChapterListDataViewModel chapterListDatasViewModel;

  Future<void> chapterListFetch(String bibleID, String bookID) async {
    try {
      _isChapterListBusy = false;
      if (bibleID.isEmpty || bookID.isEmpty) return;
      // Fetch the chapter list data from the service
      chapterListDatasViewModel = await ChapterListService.chapterListFetch(
          bibleID: bibleID, bookID: bookID);
      _chapterListDataViewModel.add(chapterListDatasViewModel);
      notifyListeners();
    } catch (error) {
      throw Exception('Error fetching chapter list data: $error');
    } finally {
      _isChapterListBusy = true;
      setIsBusyChapterLoad = false;
      setBusyForLoadConcatinate();
    }
  }

  BookDetailModel? bookDetailModel;

  Future<void> bookDetailFetch(String bibleID, String bookID) async {
    try {
      _isBookDetailBusy = false;
      if (bibleID.isEmpty || bookID.isEmpty) return;
      // Fetch the chapter list data from the service
      bookDetailModel = await ChapterService.BookDetailFetch(
          bibleID: bibleID, bookID: bookID);

      notifyListeners();
    } catch (error) {
      throw Exception('Error fetching book details data: $error');
    } finally {
      _isBookDetailBusy = true;
      setBusyForLoadConcatinate();
    }
  }

  ChapterVersesModel? chapterVersesModel;
  Future<void> bookVerseFetch(String bibleID, String ChapterID) async {
    try {
      setIsBusyChapterLoad = true;
      if (bibleID.isEmpty || ChapterID.isEmpty) return;
      // Fetch the chapter list data from the service
      chapterVersesModel = await ChapterService.BookVerseFetch(
          bibleID: bibleID, chapterID: ChapterID);

      notifyListeners();
    } catch (error) {
      throw Exception('Error fetching book verse list data: $error');
    } finally {
      setIsBusyChapterLoad = false;
    }
  }

  VersesContentModal? versesContentModal;
  Future<void> versesContentFetch(String bibleID, String VersesID) async {
    try {
      setIsBusyChapterLoad = true;
      if (bibleID.isEmpty || VersesID.isEmpty) return;
      // Fetch the chapter list data from the service
      versesContentModal = await ChapterService.BookVerseContent(
          bibleID: bibleID, verseID: VersesID);
      String versesFind = versesContentModal?.data.content.trim() ?? '';
      setVersesFind = versesFind;
      notifyListeners();
    } catch (error) {
      throw Exception('Error fetching book verse list data: $error');
    } finally {
      setIsBusyChapterLoad = false;
    }
  }
}

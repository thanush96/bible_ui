import 'dart:convert';
import 'package:flutter_app/model/book_detail_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/model/chapter_list_model.dart';
import 'package:flutter_app/model/chapter_model.dart';
import 'package:flutter_app/model/chapter_verses_model.dart';
import 'package:flutter_app/model/verses_content_model.dart';
import 'package:flutter_app/provider/bible_id_provider.dart';
import 'dart:developer' as logging;
import 'package:flutter_app/services/http_service.dart';
import 'package:provider/provider.dart';

class ChapterService {
  static Future<ChapterViewModel> chapterContentFetch({
    required String bibleID,
    required String chapterID,
    required BuildContext context,
  }) async {
    String globalBibleID =
        Provider.of<BibleIDProvider>(context, listen: false).selectedBible;

    print('global $globalBibleID');

    try {
      final response = await get(
          '$globalBibleID/chapters/$chapterID?content-type=text&include-notes=false&include-titles=true&include-chapter-numbers=false&include-verse-numbers=true&include-verse-spans=false',
          token: true);
      ChapterViewModel chapterViewModel =
          ChapterViewModel.fromJson(json.decode(response));
      logging.log(jsonEncode(chapterViewModel.data));
      return chapterViewModel;
    } catch (e) {
      logging.log('Error fetching chapter content: $e');
      rethrow; // Or handle gracefully
    }
  }

  // static final BibleDatabaseHelper _dbHelper = BibleDatabaseHelper();

  // static Future<ChapterViewModel> chapterContentFetch({
  //   required String bibleID,
  //   required String chapterID,
  //   required BuildContext context,
  // }) async {
  //   // Check if chapter content exists in SQLite
  //   final localData = await _dbHelper.fetchChapter(chapterID);
  //   if (localData != null) {
  //     return ChapterViewModel.fromJson({
  //       "data": localData,
  //     });
  //   }

  //   // Fetch from API if not in SQLite
  //   final response = await get(
  //       '$bibleID/chapters/$chapterID?content-type=text&include-notes=false&include-titles=true&include-chapter-numbers=false&include-verse-numbers=true&include-verse-spans=false',
  //       token: true);

  //   final data = json.decode(response);

  //   // Save the chapter to SQLite
  //   await _dbHelper.insertChapter({
  //     "id": data["data"]["id"],
  //     "bibleId": data["data"]["bibleId"],
  //     "bookId": data["data"]["bookId"],
  //     "chapterNumber": data["data"]["number"],
  //     "content": data["data"]["content"],
  //     "reference": data["data"]["reference"],
  //   });

  //   return ChapterViewModel.fromJson(data);
  // }

  static Future<BookDetailModel> BookDetailFetch({
    required String bibleID,
    required String bookID,
  }) async {
    final response = await get('$bibleID/books/$bookID', token: true);
    BookDetailModel bookDetailModel =
        BookDetailModel.fromJson(json.decode(response));
    logging.log(jsonEncode(bookDetailModel.data));
    return bookDetailModel;
  }

  static Future<ChapterVersesModel> BookVerseFetch({
    required String bibleID,
    required String chapterID,
  }) async {
    final response =
        await get('$bibleID/chapters/$chapterID/verses', token: true);
    ChapterVersesModel chapterVersesModel =
        ChapterVersesModel.fromJson(json.decode(response));
    logging.log(jsonEncode(chapterVersesModel.data));
    return chapterVersesModel;
  }

  static Future<VersesContentModal> BookVerseContent({
    required String bibleID,
    required String verseID,
  }) async {
    final response = await get(
        '$bibleID/verses/$verseID?content-type=text&include-notes=false&include-titles=true&include-chapter-numbers=false&include-verse-numbers=true&include-verse-spans=false&use-org-id=false',
        token: true);
    VersesContentModal versesContentModal =
        VersesContentModal.fromJson(json.decode(response));
    logging.log(jsonEncode(versesContentModal.data));
    return versesContentModal;
  }
}

class ChapterListService {
  static Future<ChapterListDataViewModel> chapterListFetch({
    required String bibleID,
    required String bookID,
  }) async {
    final response = await get('$bibleID/books/$bookID/chapters', token: true);
    ChapterListDataViewModel chapterListDataViewModel =
        ChapterListDataViewModel.fromJson(json.decode(response));
    logging.log(jsonEncode(chapterListDataViewModel.data));
    // printStatement(chapterListDataViewModel.data);
    return chapterListDataViewModel;
  }
}

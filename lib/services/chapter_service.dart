import 'dart:convert';

import 'package:flutter_app/model/chapter_model.dart';
import 'dart:developer' as logging;

import 'package:flutter_app/services/http_service.dart';

class ChapterService {
  static Future<ChapterViewModel> chapterContentFetch({
    required String bibleID,
    required String chapterID,
  }) async {
    final response = await get(
        '$bibleID/chapters/$chapterID?content-type=text&include-notes=false&include-titles=true&include-chapter-numbers=false&include-verse-numbers=true&include-verse-spans=false',
        token: true);
    ChapterViewModel chapterViewModel =
        ChapterViewModel.fromJson(json.decode(response));
    logging.log(jsonEncode(chapterViewModel.data));
    printStatement(chapterViewModel.data);
    return chapterViewModel;
  }
}

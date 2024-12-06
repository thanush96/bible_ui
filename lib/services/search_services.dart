import 'dart:convert';

import 'package:flutter_app/constants/variables.dart';
import 'package:flutter_app/model/search_chparter_model.dart';
import 'package:flutter_app/services/http_service.dart';

class SearchServices {
  static Future<SearchChapterModel> searchChapter({
    required String query,
  }) async {
    final isTamil = query.runes.any((int rune) {
      final char = String.fromCharCode(rune);
      return RegExp(r'[\u0B80-\u0BFF]').hasMatch(char);
    });
    final bibleID = isTamil ? bibleIDforTamil : bibleIDforEnglish;
    final response = await get('$bibleID/search?query=$query', token: true);
    printStatement(response);
    SearchChapterModel searchChapterModel =
        SearchChapterModel.fromJson(json.decode(response));
    return searchChapterModel;
  }
}

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_app/constants/variables.dart';
import 'package:flutter_app/model/search_chparter_model.dart';
import 'package:flutter_app/services/http_service.dart';
import 'package:provider/provider.dart';

import '../provider/language_provider.dart';

class SearchServices {
  static Future<SearchChapterModel> searchChapter({
    required String query,
    required BuildContext context,
  }) async {
    // final isTamil = query.runes.any((int rune) {
    //   final char = String.fromCharCode(rune);
    //   return RegExp(r'[\u0B80-\u0BFF]').hasMatch(char);
    // });

    String language =
        Provider.of<LanguageProvider>(context, listen: false).selectedLanguage;

    final bibleID = language == "ta" ? bibleIDforTamil : bibleIDforEnglish;

    final response = await get('$bibleID/search?query=$query', token: true);
    printStatement(response);
    SearchChapterModel searchChapterModel =
        SearchChapterModel.fromJson(json.decode(response));
    return searchChapterModel;
  }
}

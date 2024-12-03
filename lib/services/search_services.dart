import 'dart:convert';

import 'package:flutter_app/model/search_chparter_model.dart';
import 'package:flutter_app/services/http_service.dart';

class SearchServices {
  static Future<SearchChapterModel> searchChapter({
    required String query,
  }) async {
    final response = await get('search?query=$query', token: true);
    printStatement(response);
    SearchChapterModel searchChapterModel =
        SearchChapterModel.fromJson(json.decode(response));
    return searchChapterModel;
  }
}

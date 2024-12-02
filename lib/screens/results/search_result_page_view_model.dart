import 'package:flutter/material.dart';
import 'package:flutter_app/model/search_chparter_model.dart';
import 'package:flutter_app/services/search_services.dart';
import 'package:stacked/stacked.dart';

class SearchViewModel extends BaseViewModel {
  String _query = '';

  List<BibleVerse> _results = [];
  List<String> recentSearches = [];

  String get query => _query;
  List<BibleVerse> get results => _results;

  final TextEditingController queryController = TextEditingController();

  void updateQuery(String query) {
    _query = query;
    notifyListeners();
  }

  void clearQuery() {
    _query = '';
    _results = [];
    notifyListeners();
  }

  late SearchChapterModel _searchChapterModel;
  SearchChapterModel get searchChapterModel => _searchChapterModel;
  Future<void> search() async {
    try {
      if (_query.isEmpty) return;
      recentSearches.add(_query);
      setBusy(true);
      _searchChapterModel = await SearchServices.searchChapter(query: query);
      notifyListeners();
    } catch (error) {
      throw Exception('Error parsing JSON : $error');
    } finally {
      setBusy(false);
    }
  }
}

class BibleVerse {
  final String text;
  final String book;
  final int chapter;
  final int verse;

  BibleVerse({
    required this.text,
    required this.book,
    required this.chapter,
    required this.verse,
  });
}
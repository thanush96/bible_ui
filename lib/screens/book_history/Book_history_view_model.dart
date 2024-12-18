import 'package:flutter_app/db/bible_database_helper.dart';
import 'package:stacked/stacked.dart';

class BookHistoryViewModel extends BaseViewModel {
  void setBusyForLoad() {
    setBusy(true);
  }

  List<Map<String, String>> _chapterData = [];
  List<Map<String, String>> get chapterData => _chapterData;

  void loadChapterIdsAndBookIds() async {
    setBusy(true);
    try {
      final dbHelper = BibleDatabaseHelper();
      _chapterData = await dbHelper.fetchAllChapterIdsAndBookIds();
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }
}

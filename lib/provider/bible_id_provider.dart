import 'package:flutter/material.dart';

class BibleIDProvider with ChangeNotifier {
  String _selectedBible = '06125adad2d5898a-01';

  String get selectedBible => _selectedBible;

  void setBibleID(String bibleID) {
    _selectedBible = bibleID;
    print('bible id $bibleID');
    notifyListeners();
  }
}

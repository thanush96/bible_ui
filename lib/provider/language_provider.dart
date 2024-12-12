import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  String _selectedLanguage = 'en'; // Default language is English

  String get selectedLanguage => _selectedLanguage;

  void setLanguage(String language) {
    _selectedLanguage = language;
    print('language $language');
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}

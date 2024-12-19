import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../services/firestore_service.dart';

class FavouriteBookViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = FirestoreService();

  void setBusyForLoad() {
    setBusy(true);
  }

  List<Map<String, dynamic>> _favouriteBooks = [];
  List<Map<String, dynamic>> get favouriteBooks => _favouriteBooks;

  Future<void> loadFavouriteBooks(String userId) async {
    try {
      setBusy(true);
      _favouriteBooks =
          await _firestoreService.fetchFavouriteBooks(userId: userId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading favorite books: $e');
    } finally {
      setBusy(false);
    }
  }
}

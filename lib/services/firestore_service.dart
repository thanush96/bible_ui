import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save a favorite verse
  Future<void> saveFavorite({
    required String userId,
    required String bibleId,
    required String bookId,
    required String chapterId,
    required String id,
    required String title,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(chapterId)
          .set({
        'bibleId': bibleId,
        'bookId': bookId,
        'chapterId': chapterId,
        'id': id,
        'title': title,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error saving favorite: $e');
    }
  }

  // Save a note
  Future<void> saveNote({
    required String userId,
    required String bibleId,
    required String bookId,
    required String chapterId,
    required String id,
    required String note,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('notes')
          .doc(chapterId)
          .set({
        'bibleId': bibleId,
        'bookId': bookId,
        'chapterId': chapterId,
        'id': id,
        'note': note,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error saving note: $e');
    }
  }

  // Save a highlighted verse
  Future<void> saveHighlight({
    required String userId,
    required String bibleId,
    required String bookId,
    required String chapterId,
    required String verse,
    required Color color, // Store the color of the highlight
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('highlights')
          .doc(chapterId)
          .set({
        'bibleId': bibleId,
        'bookId': bookId,
        'chapterId': chapterId,
        'verse': verse,
        'color': color,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error saving highlight: $e');
    }
  }
}

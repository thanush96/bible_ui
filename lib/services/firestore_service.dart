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

  //=====================================================================
  //=====================================================================
  //==============firebase fetch functions===============================
  //=====================================================================
  //=====================================================================
// Fetch notes filtered by bibleId, bookId, and chapterId
  Future<List<Map<String, dynamic>>> fetchNotes({
    required String userId,
    required String bibleId,
    required String bookId,
    required String chapterId,
  }) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('notes')
          .where('bibleId', isEqualTo: bibleId)
          .where('bookId', isEqualTo: bookId)
          .where('chapterId', isEqualTo: chapterId)
          .get();

      return snapshot.docs
          .map((doc) => {"id": doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception('Error fetching notes: $e');
    }
  }

// Fetch favorites filtered by bibleId, bookId, and chapterId
  Future<List<Map<String, dynamic>>> fetchFavorites({
    required String userId,
    required String bibleId,
    required String bookId,
    required String chapterId,
  }) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .where('bibleId', isEqualTo: bibleId)
          .where('bookId', isEqualTo: bookId)
          .where('chapterId', isEqualTo: chapterId)
          .get();

      return snapshot.docs
          .map((doc) => {"id": doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception('Error fetching favorites: $e');
    }
  }

// Fetch highlights filtered by bibleId, bookId, and chapterId
  Future<List<Map<String, dynamic>>> fetchHighlights({
    required String userId,
    required String bibleId,
    required String bookId,
    required String chapterId,
  }) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('highlights')
          .where('bibleId', isEqualTo: bibleId)
          .where('bookId', isEqualTo: bookId)
          .where('chapterId', isEqualTo: chapterId)
          .get();

      return snapshot.docs
          .map((doc) => {"id": doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception('Error fetching highlights: $e');
    }
  }

  //=====================================================================
  //=====================================================================
  //===========firebase store favourite book  functions==================
  //=====================================================================
  //=====================================================================

  Future<void> addToFavouriteBookService({
    required String userId,
    required String abbreviation,
    required String bibleId,
    required String imageUrl,
    required String subTitle,
    required String summary,
    required String title,
    required String id,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favourite_Books')
          .doc(id)
          .set({
        'abbreviation': abbreviation,
        'bibleId': bibleId,
        'imageUrl': imageUrl,
        'subTitle': subTitle,
        'summary': summary,
        'title': title,
        'id': id,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error saving favorite: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchFavouriteBooks({
    required String userId,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('favourite_Books')
          .orderBy('timestamp', descending: true)
          .get();

      // Convert the documents into a list of maps
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Error fetching favorite books: $e');
    }
  }
}

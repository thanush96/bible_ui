import 'package:flutter_app/model/chapter_model.dart';
import 'package:flutter_app/services/http_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BibleDatabaseHelper {
  static final BibleDatabaseHelper _instance = BibleDatabaseHelper._();
  static Database? _database;

  BibleDatabaseHelper._();

  factory BibleDatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'bible_content01.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE chapters (
      id TEXT PRIMARY KEY,
      bibleId TEXT,
      bookId TEXT,
      chapterNumber TEXT,
      content TEXT,
      reference TEXT,
      copyright TEXT,
      verseCount INTEGER,
      nextId TEXT,
      nextNumber TEXT,
      nextBookId TEXT,
      previousId TEXT,
      previousNumber TEXT,
      previousBookId TEXT
    )
  ''');
  }

  Future<void> insertChapter(ChapterViewModel chapter) async {
    final db = await database;

    await db.insert(
      'chapters',
      {
        "id": chapter.data.id,
        "bibleId": chapter.data.bibleId,
        "bookId": chapter.data.bookId,
        "chapterNumber": chapter.data.number,
        "content": chapter.data.content,
        "reference": chapter.data.reference,
        "copyright": chapter.data.copyright,
        "verseCount": chapter.data.verseCount,
        "nextId": chapter.data.next?.id,
        "nextNumber": chapter.data.next?.number,
        "nextBookId": chapter.data.next?.bookId,
        "previousId": chapter.data.previous?.id,
        "previousNumber": chapter.data.previous?.number,
        "previousBookId": chapter.data.previous?.bookId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<ChapterViewModel?> fetchChapter(
      String chapterID, String bibleID) async {
    final db = await database;
    final result = await db.query(
      'chapters',
      where: 'id = ? AND bibleId = ?',
      whereArgs: [chapterID, bibleID],
    );
    printStatement(result);
    if (result.isNotEmpty) {
      final row = result.first;

      return ChapterViewModel(
        data: Data(
          id: row['id'] as String,
          bibleId: row['bibleId'] as String,
          number: row['chapterNumber'] as String,
          bookId: row['bookId'] as String,
          reference: row['reference'] as String,
          copyright: row['copyright'] as String,
          verseCount: row['verseCount'] as int,
          content: row['content'] as String,
          next: row['nextId'] != null
              ? Next(
                  id: row['nextId'] as String,
                  number: row['nextNumber'] as String,
                  bookId: row['nextBookId'] as String,
                )
              : null,
          previous: row['previousId'] != null
              ? Next(
                  id: row['previousId'] as String,
                  number: row['previousNumber'] as String,
                  bookId: row['previousBookId'] as String,
                )
              : null,
        ),
      );
    }

    return null;
  }
}

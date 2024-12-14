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
    String path = join(dbPath, 'bible_content.db');
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
        reference TEXT
      )
    ''');
  }

  Future<void> insertChapter(Map<String, dynamic> chapterData) async {
    final db = await database;
    await db.insert(
      'chapters',
      chapterData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> fetchChapter(String chapterID) async {
    final db = await database;
    final result = await db.query(
      'chapters',
      where: 'id = ?',
      whereArgs: [chapterID],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}

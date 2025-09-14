import 'package:path/path.dart';
import 'package:restaurant_api_dicoding/data/model/restauran.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tableName = 'favorite';

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'restaurant_app.db');

    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating REAL
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertFavorite(Restauran restauran) async {
    final db = await database;
    await db.insert(
      _tableName,
      restauran.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Restauran>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    return result.map((e) => Restauran.fromJson(e)).toList();
  }

  Future<Restauran?> getFavoriteById(String id) async {
    final db = await database;
    final result = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return Restauran.fromJson(result.first);
    } else {
      return null;
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}

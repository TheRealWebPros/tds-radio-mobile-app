import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class Shows {
  final int? id;
  final String showname;
  final String start;
  final String end;
  final String avatarUrl;

  Shows(
      {this.id,
      required this.showname,
      required this.start,
      required this.avatarUrl,
      required this.end});
  factory Shows.fromMap(Map<String, dynamic> json) => Shows(
      id: json["id"],
      showname: json["showname"],
      start: json["start"],
      end: json["end"],
      avatarUrl: json["avatar_url"]);

  Map<String, dynamic> toMap() {
    return {
      "showname": showname,
      "start": start,
      "end": end,
      "id": id,
      "avatar_url": avatarUrl
    };
  }
}

class WhoSqliteHelper {
  WhoSqliteHelper._priveteContructor();
  static final WhoSqliteHelper instance = WhoSqliteHelper._priveteContructor();
  static Database? _database;
  static Future<Database> get databaseInstance async {
    if (_database == null) {
      await _setupAndOpenDatabase();
    }
    return _database as Database;
  }

  static Future _setupAndOpenDatabase() async {
    final dbPath = await getDatabasesPath();
    _database = await openDatabase(
      "$dbPath/hbnradioshow.db",
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );

    _database?.execute("PRAGMA foreign_keys = ON;");
  }

  static void _onCreate(Database db, int version) async {
    await db.execute(
      """CREATE TABLE shows (
      id INTEGER PRIMARY KEY, 
      avatar_url VARCHAR(2048),
      showname TEXT, 
      start TEXT,
      end TEXT)""",
    );

    if (kDebugMode) {
      print("DATABASE CREATED!");
    }
  }

  static void _onUpgrade(Database db, int oldVersion, int newVersion) async {}
}

Future<Database> getDb() async {
  return await WhoSqliteHelper.databaseInstance;
}

Future<List<Shows>> getLocalShows() async {
  final db = await getDb();
  var localShows = await db.query('shows');
  List<Shows> localShowsList = localShows.isNotEmpty
      ? localShows.map((e) => Shows.fromMap(e)).toList()
      : [];
  return localShowsList;
}

Future<void> createLocalShows(Shows shows) async {
  final db = await getDb();
  await db.insert("shows", shows.toMap());
}

Future<void> delete(int id) async {
  final db = await getDb();
  await db.delete(
    "shows",
    where: "id = ?",
    whereArgs: [id],
  );
}

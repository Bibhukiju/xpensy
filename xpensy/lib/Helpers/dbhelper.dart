import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbname = 'myexpenses.db';
  static final _dbversion = 1;
  static final _tableName = 'xpense';
  static final columnId = "id";
  static final cAmount = "Amount";
  static final cDesc = "Desc";
  static final cDate = "DOExpense";
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  _initDB() async {
    Directory directory = await getApplicationSupportDirectory();
    String path = join(directory.path, _dbname);
    return await openDatabase(path, version: _dbversion, onCreate: _onCreated);
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  FutureOr<void> _onCreated(Database db, int version) {
    db.execute('''
    CREATE TABLE $_tableName(
      $columnId INTEGER PRIMARY KEY,
      $cAmount TEXT NOT NULL,
      $cDesc TEXT ,
      $cDate TEXT NOT NULL,
    )
    ''');
  }
}

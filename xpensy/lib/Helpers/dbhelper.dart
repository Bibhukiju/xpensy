import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xpensy/models/expenseModel.dart';

class DBHelper {
  static final _dbname = 'myDb.db';
  static final _dbversion = 1;
  static final _tableName = 'myTable';
  static final columnId = "id";
  static final amount = "amount";
  static final desc = "desc";
  static final cdate = "date";
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initiateDb();
    return _database;
  }

  _initiateDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbname);
    return await openDatabase(path, version: _dbversion, onCreate: _onCreate);
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    var result = await db.query(_tableName);
    return result;
  }

  Future update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(_tableName, row, where: '$columnId=?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnId=?', whereArgs: [id]);
  }

  FutureOr<void> _onCreate(Database db, int version) {
    db.execute('''CREATE TABLE $_tableName
    ($columnId INTEGER PRIMARY KEY,
    $amount TEXT NOT NULL,
    $cdate TEXT NOT NULL,
    $desc Text NOT NULL)
    ''');
  }

  Future<List<Expenses>> getExpendedList() async {
    var expenseMapList = await queryAll();
    List<Expenses> expenseList = List<Expenses>();
    for (var i = 0; i < 2; i++) {
      expenseList.add(Expenses.fromJsonMap(expenseMapList[i]));
    }
    return expenseList;
  }
}

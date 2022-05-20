import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseService {
  Database _database;
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;
  static const String tableName = 'Coupons_table';

  Future initialise() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, _databaseName);
    _database = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const String sql = '''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY,
        couponcode TEXT NOT NULL,
        companyname TEXT NOT NULL,
        couponexpiry TEXT NOT NULL,
        dailyreminder INTEGER NOT NULL
      );
    ''';
    await db.execute(sql);
  }

  //Helper Methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert({@required Map<String, dynamic> row}) async {
    return await _database.insert(tableName, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _database.query(tableName);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(couponcode) async {
    return await _database
        .delete(tableName, where: 'couponcode = ?', whereArgs: [couponcode]);
  }
}

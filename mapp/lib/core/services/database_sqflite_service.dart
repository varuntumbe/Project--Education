import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  final _databaseName = "Cache.db";
  final _databaseVersion = 1;
  final table = 'cache_table';
  final columnId = '_id';
  final columnImagePath = 'path';
  final columnExtractedText = 'etext';
  final columnUseFrequency = 'frequency';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnImagePath TEXT NOT NULL,
            $columnExtractedText TEXT NOT NULL,
            $columnUseFrequency INTEGER DEFAULT 0
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  //Queries using columnImagePath and returns its
  Future<List<Map<String, dynamic>>> getExtractedText(String imgPath) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db
        .query(table, where: '$columnImagePath = ?', whereArgs: [imgPath]);

    return result;
  }

  //Function creates a batch and returns it
  Future<dynamic> getBatch() async {
    Database db = await instance.database;
    return db.batch();
  }

  //insert the writings to batch
  void batchInsert(Map<String, dynamic> row, dynamic batch) async {
    //Database db = await instance.database;
    batch.insert(table, row);
  }

  Future<List<dynamic>> batchCommit(dynamic batch) async {
    List<dynamic> result = await batch.commit();

    return result;
  }
}

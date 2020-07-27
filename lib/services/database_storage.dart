import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/run_data.dart';

class DatabaseStorage {
  static final String _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final String table = 'run_history_table';

  static final String columnRunId = 'runId';
  static final String columnDateTime = 'dateTime';
  static final String columnDistance = 'distance';
  static final String columnDuration = 'duration';
  static final String columnPace = 'pace';
  static final String columnCalories = 'calories';
  static final String columnPositions = 'positions';
  static final String columnTitle = 'title';
  static final String columnDescription = 'description';

  DatabaseStorage._privateConstructor();
  static final DatabaseStorage instance = DatabaseStorage._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $table ("
        "$columnRunId INTEGER PRIMARY KEY,"
        "$columnDateTime TEXT,"
        "$columnDistance REAL,"
        "$columnDuration INTEGER,"
        "$columnPace REAL,"
        "$columnCalories REAL,"
        "$columnPositions TEXT,"
        "$columnTitle TEXT,"
        "$columnDescription TEXT"
        ")");
  }

  Future<int> insert(RunData run) async {
    Database db = await instance.database;
    return await db.insert(table, run.toMap());
  }

  Future<List<RunData>> queryAllRuns() async {
    Database db = await instance.database;
    var response = await db.query(table);
    List<RunData> runDataList = response.isEmpty
        ? []
        : response.map((runData) => RunData.fromMap(runData)).toList();
    return runDataList;
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // Future<int> update(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   int id = row[columnRunId];
  //   return await db
  //       .update(table, row, where: '$columnRunId = ?', whereArgs: [id]);
  // }

  // Future<int> delete(int id) async {
  //   Database db = await instance.database;
  //   return await db
  //       .delete(table, where: '$columnRunId = ?', whereArgs: [id]);
  // }

  Future<int> clear() async {
    Database db = await instance.database;
    return await db.delete(table);
  }

  Future<List<RunData>> getPastWeekRuns(DateTime now) async {
    List<RunData> runs = [];
    Database db = await instance.database;
    int count = await queryRowCount();
    DateTime today = DateTime(now.year, now.month, now.day);

    while (count > 0) {
      var response =
          await db.query(table, where: '$columnRunId = ?', whereArgs: [count]);
      RunData temp = RunData.fromMap(response[0]);
      if (today.difference(temp.dateTime).inDays < 5) {
        runs.add(temp);
      } else {
        return runs;
      }
      count--;
    }

    return runs;
  }
}

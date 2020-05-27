import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DatabaseCreator {
  static const restaurantsTable = 'restaurants_table';
  static const id = 'id';
  static const name = 'name';
  static const address = 'address';
  static const description = 'description';
  static const rating = 'rating';
  static const latitude = 'latitude';
  static const longitude = 'longitude';
  static const votes = 'votes';
  static const phone_numbers = 'phone_numbers';
  static const thumb = 'thumb';
  static const photos_url = 'photos_url';

  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>> selectQueryResult,
      int insertAndUpdateQueryResult,
      List<dynamic> params]) {
    print(functionName);
    print(sql);
    if (params != null) {
      print(params);
    }
    if (selectQueryResult != null) {
      print(selectQueryResult);
    } else if (insertAndUpdateQueryResult != null) {
      print(insertAndUpdateQueryResult);
    }
  }

  Future<void> createTable(Database db) async {
    final todoSql = '''CREATE TABLE $restaurantsTable
    (
      $id INTEGER,
      $name TEXT,
      $phone_numbers TEXT,
      $description TEXT,
      $rating TEXT,
      $votes TEXT,
      $address TEXT,
      $latitude TEXT,
      $longitude TEXT,
      $thumb TEXT,
      $photos_url TEXT
    )''';

    await db.execute(todoSql);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('restaurants_db.db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createTable(db);
  }
}

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataConnector {
  bool kDebugMode = true;
  late Future<Database> database;
  bool connected = false;

  DataConnector._create() {}

  static Future<DataConnector> create() async {
    var connector = DataConnector._create();
    await connector._connect();
    return connector;
  }

  Future<bool> _connect() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
      join(await getDatabasesPath(), 'krempel_sqlite.db'),
      onCreate: (db, version) {
        if (kDebugMode) {
          debugPrint("No database found... creating");
        }
        db.execute('CREATE TABLE items(id String PRIMARY KEY, parent String)');
        db.execute(
            'CREATE TABLE attributes(id String, attribute String, value String');
        db.execute('CREATE TABLE groups(id String, name String');
        db.execute('CREATE TABLE itemgroups(id String, groupid String');
      },
      version: 1,
    );
    return true;
  }

  void writeSingleItem({required String id, required String parent}) async {
    Map<String, dynamic> data = {
      'id': id,
      'parent': parent,
    };

    final db = await database;
    await db.insert(
      'items',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void writeSingleAttribute(
      {required String id,
      required String attribute,
      required String value}) async {
    Map<String, dynamic> data = {
      'id': id,
      'attribute': attribute,
      'value': value,
    };

    final db = await database;
    await db.insert(
      'attributes',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String> getRoot() async {
    _connect();
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('items', where: 'parent=?', whereArgs: ["<root>"]);
    return maps[0]['id'];
  }
}

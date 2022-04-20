import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MainDatabase {
  MainDatabase._privateConstructor();

  static final MainDatabase instance = MainDatabase._privateConstructor();

  final String mainDatabaseName = 'main_database.db';

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), mainDatabaseName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDatabase,
      onUpgrade: _onUpdateDatabase,
    );
  }

  Future<void> _onCreateDatabase(Database db, int version) async {
    String ddl = '''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        email TEXT, 
        name TEXT,
        created INTEGER,
        updated INTEGER
      );
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        desc TEXT,
        status TEXT,
        start INTEGER,
        end INTEGER,
        created INTEGER,
        updated INTEGER
      );
    ''';

    await db.execute(ddl);
  }

  FutureOr<void> _onUpdateDatabase(
      Database db, int oldVersion, int newVersion) async {
    String ddl = '''
      
    ''';

    await db.execute(ddl);
  }
}
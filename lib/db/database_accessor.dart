import 'dart:developer' as dev;

import 'package:icebox/db/freezers_db.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAccessor {
  static const String _tag = 'db.database_accessor';

  DatabaseAccessor._();

  static final DatabaseAccessor db = DatabaseAccessor._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    dev.log('Initializing database...', name: _tag);

    return await openDatabase(
      'icebox.db',
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        dev.log('Creating tables...', name: _tag);
        await db.execute(FreezersDb.tableDefinition);
      },
    );
  }
}

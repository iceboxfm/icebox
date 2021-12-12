import 'package:icebox/db/freezer_items_db.dart';
import 'package:icebox/db/freezers_db.dart';
import 'package:loggy/loggy.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAccessor with UiLoggy {
  DatabaseAccessor._();

  static final DatabaseAccessor db = DatabaseAccessor._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    loggy.info('Initializing database...');

    return await openDatabase(
      'icebox.db',
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        loggy.info('Creating tables (v$version)...');
        await FreezersDb.init(db, version);
        await FreezerItemsDb.init(db, version);
      },
    );
  }
}

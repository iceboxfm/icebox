import 'package:icebox/db/freezer_items_db.dart' as freezer_items_db;
import 'package:icebox/db/freezers_db.dart' as freezers_db;
import 'package:loggy/loggy.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
    final libDir = await getApplicationSupportDirectory();

    var dbPath = join(libDir.path, 'icebox.db');
    loggy.info('Initializing database ($dbPath)...');

    return await openDatabase(
      dbPath,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        loggy.info('Creating tables (v$version)...');
        await freezers_db.init(db, version);
        await freezer_items_db.init(db, version);
      },
    );
  }
}

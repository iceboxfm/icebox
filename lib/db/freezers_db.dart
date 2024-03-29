import 'dart:convert';

import 'package:icebox/db/database_accessor.dart';
import 'package:icebox/models/freezer.dart';
import 'package:loggy/loggy.dart';
import 'package:sqflite/sqflite.dart';

const String _table = 'freezers';
const String _tableDefinition = '''CREATE TABLE freezers (
      id INTEGER PRIMARY KEY,
      description VARCHAR(50) NOT NULL,
      type VARCHAR(10) NOT NULL,
      shelves TEXT NOT NULL
    )
  ''';

Future<void> init(final Database db, final int version) async {
  logInfo('Creating $_table (v$version)...');
  return db.execute(_tableDefinition);
}

Future<List<Freezer>> retrieve() async {
  final res = await (await DatabaseAccessor.db.database).query(
    _table,
    orderBy: 'description asc',
  );

  return res.isNotEmpty ? res.map((r) => _fromMap(r)).toList() : [];
}

Future<Freezer> create(final Freezer freezer) async {
  final recordId = await (await DatabaseAccessor.db.database).insert(
    _table,
    _toMap(freezer),
  );
  return freezer.copyWith(id: recordId);
}

Future<void> update(final Freezer freezer) async {
  await (await DatabaseAccessor.db.database).update(
    _table,
    _toMap(freezer),
    where: 'id = ?',
    whereArgs: [freezer.id],
  );
}

Future<void> delete(final int freezerId) async {
  await (await DatabaseAccessor.db.database).delete(
    _table,
    where: 'id = ?',
    whereArgs: [freezerId],
  );
}

Future<void> deleteAll() async {
  await (await DatabaseAccessor.db.database).delete(_table);
}

Map<String, dynamic> _toMap(final Freezer freezer) => {
      'id': freezer.id,
      'description': freezer.description,
      'type': freezer.type.name,
      'shelves': jsonEncode(freezer.shelves),
    };

Freezer _fromMap(final Map<String, dynamic> map) {
  final List<dynamic> list = jsonDecode(map['shelves'].toString());

  return Freezer(
    id: map['id'],
    description: map['description'],
    type: FreezerTypeExt.forName(map['type']) ?? FreezerType.upright,
    shelves: list.map((e) => e.toString()).toList(),
  );
}

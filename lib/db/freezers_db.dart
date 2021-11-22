import 'dart:convert';

import 'package:icebox/db/database_accessor.dart';
import 'package:icebox/models/freezer.dart';

class FreezersDb {
  static const String _freezersTable = 'freezers';
  static const String tableDefinition = '''CREATE TABLE freezers (
      id INTEGER PRIMARY KEY,
      description VARCHAR(50) NOT NULL,
      shelves TEXT NOT NULL
    )
  ''';

  static Future<List<Freezer>> retrieve() async {
    final res = await (await DatabaseAccessor.db.database)
        .query(_freezersTable, orderBy: 'description desc');

    return res.isNotEmpty ? res.map((r) => _fromMap(r)).toList() : [];
  }

  static Map<String, dynamic> _toMap(final Freezer freezer) {
    return {
      'id': freezer.id,
      'description': freezer.description,
      'shelves': jsonEncode(freezer.shelves),
    };
  }

  static Freezer _fromMap(final Map<String, dynamic> map) {
    return Freezer(
      id: map['id'],
      description: map['description'],
      shelves: jsonDecode(map['shelves']),
    );
  }
}

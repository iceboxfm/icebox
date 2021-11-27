import 'package:icebox/db/database_accessor.dart';
import 'package:icebox/models/freezer_item.dart';
import 'package:icebox/models/item_categories.dart';
import 'dart:developer' as dev;

import 'package:sqflite/sqflite.dart';

// TODO: unit test
class FreezerItemsDb {
  static const String _tag = 'icebox.db.freezer_items_db';
  static const String _table = 'freezer_items';
  static const String _tableDefinition = '''CREATE TABLE freezer_items (
      id INTEGER PRIMARY KEY,
      description VARCHAR(50) NOT NULL,
      quantity VARCHAR(50) NOT NULL,
      frozen_on INTEGER NOT NULL,
      good_for INTEGER NOT NULL,
      category VARCHAR(50) NOT NULL,
      location VARCHAR(50), 
      freezer_id INTEGER NOT NULL,
      FOREIGN KEY(freezer_id) REFERENCES freezer(id)
    )
  ''';

  static Future<void> init(final Database db, final int version) async {
    dev.log('Creating $_table (v$version)...', name: _tag);
    return db.execute(_tableDefinition);
  }

  /// Retrieve all freezer items (from all freezers)
  static Future<List<FreezerItem>> retrieve() async {
    final res = await (await DatabaseAccessor.db.database).query(_table);
    return res.isNotEmpty ? res.map((r) => _fromMap(r)).toList() : [];
  }

  static Future<FreezerItem> create(final FreezerItem freezerItem) async {
    final recordId = await (await DatabaseAccessor.db.database).insert(
      _table,
      _toMap(freezerItem),
    );
    return freezerItem.copyWith(id: recordId);
  }

  static Future<void> update(final FreezerItem freezerItem) async {
    await (await DatabaseAccessor.db.database).update(
      _table,
      _toMap(freezerItem),
      where: 'id = ?',
      whereArgs: [freezerItem.id],
    );
  }

  static Future<void> delete(final int freezerItemId) async {
    await (await DatabaseAccessor.db.database).delete(
      _table,
      where: 'id = ?',
      whereArgs: [freezerItemId],
    );
  }

  static Map<String, dynamic> _toMap(final FreezerItem item) {
    return {
      'id': item.id,
      'description': item.description,
      'quantity': item.quantity,
      'frozen_on': item.frozenOn.millisecondsSinceEpoch,
      'good_for': item.goodFor,
      'category': item.category.label,
      'location': item.location,
      'freezer_id': item.freezerId,
    };
  }

  static FreezerItem _fromMap(final Map<String, dynamic> map) {
    return FreezerItem(
      id: map['id'],
      description: map['description'],
      quantity: map['quantity'],
      frozenOn: DateTime.fromMillisecondsSinceEpoch(map['frozen_on']),
      goodFor: map['good_for'],
      category: ItemCategories.find(map['category'] as String),
      location: map['location'],
      freezerId: map['freezer_id'],
    );
  }
}

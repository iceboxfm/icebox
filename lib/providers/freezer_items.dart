import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:icebox/db/freezer_items_db.dart';
import 'package:icebox/models/freezer_item.dart';

class FreezerItems with ChangeNotifier {
  static const _tag = 'icebox.providers.freezer_items';

  final List<FreezerItem> _freezerItems = [];

  // FIXME: sorting

  FreezerItems() {
    FreezerItemsDb.retrieve().then((fi) {
      _freezerItems.clear();
      _freezerItems.addAll(fi);
      dev.log('Loaded ${fi.length} freezer items from database.', name: _tag);

      // FIXME: sort

      notifyListeners();
    });
  }

  int count([final int? freezerId]) {
    return list(freezerId).length;
  }

  Future<void> save(final FreezerItem freezerItem) async {
    // FIXME: impl
  }

  Future<void> delete(final int freezerItemId) async {
    // FIXME: impl
  }

  /// List freezer items for all freezers (or specified freezer)
  List<FreezerItem> list([final int? freezerId]) {
    return freezerId != null
        ? _freezerItems.where((fi) => fi.freezerId == freezerId).toList()
        : _freezerItems;
  }
}

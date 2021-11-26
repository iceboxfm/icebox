import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:icebox/db/freezer_items_db.dart';
import 'package:icebox/models/freezer_item.dart';
import 'package:icebox/models/sort_by.dart';

// FIXME: try to clean up the limiting/filtering code

class FreezerItems with ChangeNotifier {
  static const _tag = 'icebox.providers.freezer_items';
  static const _defaultSort = SortBy(SortByField.timeRemaining, false);

  List<FreezerItem> _freezerItems = [];
  bool _loaded = false;
  String? _filterBy;
  SortBy _sortBy = _defaultSort;

  Future<void> load() async {
    if (!_loaded) {
      final items = await FreezerItemsDb.retrieve();

      _freezerItems.clear();
      _freezerItems.addAll(FreezerItem.sort(items, _sortBy));

      dev.log(
        'Loaded ${items.length} freezer items from database.',
        name: _tag,
      );

      _loaded = true;
    }
  }

  bool get filtering {
    return _filterBy != null;
  }

  void filteringBy(final String? query) {
    _filterBy = query;
    notifyListeners();
  }

  SortBy get sortBy {
    return _sortBy;
  }

  void sortingBy([SortBy? sortBy]) {
    _sortBy = sortBy ?? _defaultSort;
    // FIXME: should I just sort in place?
    _freezerItems = FreezerItem.sort(_freezerItems, _sortBy);
    notifyListeners();
  }

  bool get isNotEmpty => items.isNotEmpty;

  operator [](int i) => items[i];

  int count([final int? freezerId]) {
    return freezerId == null
        ? items.length
        : items.where((fi) => fi.freezerId == freezerId).length;
  }

  List<FreezerItem> get items {
    return _filter(_freezerItems);
  }

  Future<void> save(final FreezerItem freezerItem) async {
    if (freezerItem.id == null) {
      FreezerItemsDb.create(freezerItem).then((fi) {
        _freezerItems.add(fi);
        _freezerItems = FreezerItem.sort(_freezerItems, _sortBy);

        dev.log('Created: $fi', name: _tag);
        notifyListeners();
      });
    } else {
      FreezerItemsDb.update(freezerItem).then((_) {
        final existingIdx =
            _freezerItems.indexWhere((f) => freezerItem.id == f.id);
        _freezerItems[existingIdx] = freezerItem;
        _freezerItems = FreezerItem.sort(_freezerItems, _sortBy);

        dev.log('Updated: $freezerItem', name: _tag);
        notifyListeners();
      });
    }
  }

  Future<void> delete(final int freezerItemId) async {
    FreezerItemsDb.delete(freezerItemId).then((_) {
      _freezerItems.removeWhere((f) => f.id == freezerItemId);

      dev.log('Deleted: $freezerItemId', name: _tag);
      notifyListeners();
    });
  }

  List<FreezerItem> _filter(final List<FreezerItem> items) {
    var filter = _filterBy != null ? _filterBy!.toLowerCase() : '';

    return items
        .where(
          (fi) =>
              filter.isEmpty ||
              fi.description.toLowerCase().contains(filter) ||
              fi.quantity.toLowerCase().contains(filter) ||
              fi.category.label.toLowerCase().contains(filter),
        )
        .toList();
  }
}

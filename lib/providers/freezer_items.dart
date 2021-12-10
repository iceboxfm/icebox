import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:icebox/db/freezer_items_db.dart';
import 'package:icebox/models/freezer_item.dart';
import 'package:icebox/models/item_categories.dart';
import 'package:icebox/models/sort_by.dart';

class FreezerItems with ChangeNotifier {
  static const _tag = 'icebox.providers.freezer_items';
  static const _defaultSort = SortBy(SortByField.timeRemaining, false);

  List<FreezerItem> _freezerItems = [];
  bool _loaded = false;
  String? _filterBy;
  SortBy _sortBy = _defaultSort;
  ItemCategory? _category;
  int? _freezerId;

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
    _freezerItems = FreezerItem.sort(_freezerItems, _sortBy);
    notifyListeners();
  }

  ItemCategory? get category {
    return _category;
  }

  void limitCategory(final ItemCategory? category) {
    _category = category;
    notifyListeners();
  }

  int? get freezer {
    return _freezerId;
  }

  void limitFreezer(final int? freezerId) {
    _freezerId = freezerId;
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
    return _filter(_limitByCategory(_limitByFreezer(_freezerItems)));
  }

  Future<void> save(final FreezerItem freezerItem) async {
    if (freezerItem.id == null) {
      await _create(freezerItem);
    } else {
      await _update(freezerItem);
    }
    notifyListeners();
  }

  Future<FreezerItem> _create(final FreezerItem freezerItem) async {
    final item = await FreezerItemsDb.create(freezerItem);
    _freezerItems.add(item);
    _freezerItems = FreezerItem.sort(_freezerItems, _sortBy);

    dev.log('Created: $item', name: _tag);
    return item;
  }

  Future<void> _update(final FreezerItem freezerItem) async {
    await FreezerItemsDb.update(freezerItem);
    final existingIdx = _freezerItems.indexWhere((f) => freezerItem.id == f.id);
    _freezerItems[existingIdx] = freezerItem;
    _freezerItems = FreezerItem.sort(_freezerItems, _sortBy);

    dev.log('Updated: $freezerItem', name: _tag);
  }

  Future<void> delete(final int freezerItemId) async {
    FreezerItemsDb.delete(freezerItemId).then((_) {
      _freezerItems.removeWhere((f) => f.id == freezerItemId);

      dev.log('Deleted: $freezerItemId', name: _tag);
      notifyListeners();
    });
  }

  void importing(final List<FreezerItem> items) async {
    int created = 0;
    int updated = 0;

    for (var f in items) {
      if (_notExisting(f.id!)) {
        await _create(f);
        created++;
      } else {
        await _update(f);
        updated++;
      }
    }

    dev.log('Imported $created new items and $updated updated items.',
        name: _tag);
    notifyListeners();
  }

  bool _notExisting(final int itemId) {
    return _freezerItems.where((f) => f.id == itemId).isEmpty;
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

  List<FreezerItem> _limitByCategory(final List<FreezerItem> items) {
    return _category == null
        ? items
        : items.where((fi) => fi.category == _category).toList();
  }

  List<FreezerItem> _limitByFreezer(final List<FreezerItem> items) {
    return _freezerId == null
        ? items
        : items.where((fi) => fi.freezerId == _freezerId).toList();
  }
}

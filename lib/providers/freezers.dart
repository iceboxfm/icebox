import 'package:flutter/widgets.dart';
import 'package:icebox/db/freezers_db.dart';
import 'package:icebox/models/freezer.dart';
import 'package:loggy/loggy.dart';

class Freezers with ChangeNotifier, UiLoggy {
  final List<Freezer> _freezers = [];
  bool _loaded = false;

  Future<void> load() async {
    if (!_loaded) {
      final items = await FreezersDb.retrieve();

      _freezers.clear();
      _freezers.addAll(items);

      loggy.info('Loaded ${items.length} freezers from database.');
      _loaded = true;
    }
  }

  List<Freezer> get freezers {
    return _freezers;
  }

  operator [](int i) => _freezers[i];

  bool get isNotEmpty {
    return _freezers.isNotEmpty;
  }

  int get count {
    return _freezers.length;
  }

  Freezer retrieve(final int freezerId) {
    return _freezers.where((f) => f.id == freezerId).first;
  }

  Future<void> save(final Freezer freezer) async {
    if (freezer.id == null) {
      await _create(freezer);
    } else {
      await _update(freezer);
    }
    notifyListeners();
  }

  Future<Freezer> _create(final Freezer freezer) async {
    final updated = await FreezersDb.create(freezer);
    _freezers.add(updated);

    loggy.info('Created: $updated');
    return updated;
  }

  Future<void> _update(final Freezer freezer) {
    return FreezersDb.update(freezer).then((_) {
      final existingIdx = _freezers.indexWhere((f) => freezer.id == f.id);
      _freezers[existingIdx] = freezer;

      loggy.info('Updated: $freezer');
    });
  }

  Future<void> delete(final int freezerId) async {
    FreezersDb.delete(freezerId).then((_) {
      _freezers.removeWhere((f) => f.id == freezerId);

      loggy.info('Deleted: $freezerId');
      notifyListeners();
    });
  }

  Future<void> importing(final List<Freezer> items) async {
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

    loggy.info('Imported $created new freezers and $updated updated freezers.');
    notifyListeners();
  }

  bool _notExisting(final int freezerId) {
    return _freezers.where((f) => f.id == freezerId).isEmpty;
  }
}

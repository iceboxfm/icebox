import 'dart:developer' as dev;

import 'package:flutter/widgets.dart';
import 'package:icebox/db/freezers_db.dart';
import 'package:icebox/models/freezer.dart';

// FIXME: limit freezers to 2-3 (configuration)

class Freezers with ChangeNotifier {
  static const String _tag = 'icebox.providers.freezers';

  final List<Freezer> _freezers = [];

  Freezers() {
    FreezersDb.retrieve().then((fs) {
      _freezers.clear();
      _freezers.addAll(fs);
      dev.log('Loaded ${fs.length} freezers from database.', name: _tag);
      notifyListeners();
    });
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
  
  Freezer retrieve(final int freezerId){
    return _freezers.where((f) => f.id == freezerId).first;
  }

  Future<void> save(final Freezer freezer) async {
    if (freezer.id == null) {
      FreezersDb.create(freezer).then((f) {
        _freezers.add(f);

        dev.log('Created: $f', name: _tag);
        notifyListeners();
      });
    } else {
      FreezersDb.update(freezer).then((_) {
        final existingIdx = _freezers.indexWhere((f) => freezer.id == f.id);
        _freezers[existingIdx] = freezer;

        dev.log('Updated: $freezer', name: _tag);
        notifyListeners();
      });
    }
  }

  Future<void> delete(final int freezerId) async {
    FreezersDb.delete(freezerId).then((_){
      _freezers.removeWhere((f) => f.id == freezerId);

      dev.log('Deleted: $freezerId', name: _tag);
      notifyListeners();
    });
  }
}

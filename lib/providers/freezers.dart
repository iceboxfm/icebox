import 'package:flutter/widgets.dart';
import 'dart:developer' as dev;

import 'package:icebox/db/freezers_db.dart';
import 'package:icebox/models/freezer.dart';

class Freezers with ChangeNotifier {
  static const String _tag = 'icebox.providers.freezers';

  Future<List<Freezer>> get freezers async {
    return FreezersDb.retrieve();
  }

  // FIXME: create, update, delete
}
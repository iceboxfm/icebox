import 'package:flutter/cupertino.dart';
import 'package:icebox/models/item_categories.dart';
import 'package:icebox/models/sort_by.dart';

class FreezerItem {
  final int? id;
  final String description;
  final String quantity;
  final DateTime frozenOn;
  final int goodFor;
  final ItemCategory category;
  final String? location;
  final int? freezerId;

  const FreezerItem({
    this.id,
    required this.description,
    required this.quantity,
    required this.frozenOn,
    required this.goodFor,
    required this.category,
    this.location,
    this.freezerId,
  });

  Duration get timeRemaining {
    final goodForDays = goodFor * 30;
    final daysFrozen = DateTime.now().difference(frozenOn).inDays;
    return Duration(days: goodForDays - daysFrozen);
  }

  @override
  String toString() {
    return 'FreezerItem('
        'id:$id, description:"$description", location:"$location", '
        'category:"${category.label}", quantity:"$quantity", frozenOn:$frozenOn, '
        'goodFor:$goodFor, freezerId:$freezerId)';
  }

  @override
  bool operator ==(Object other) =>
      other is FreezerItem &&
      other.id == id &&
      other.description == description &&
      other.quantity == quantity &&
      other.frozenOn == frozenOn &&
      other.goodFor == goodFor &&
      other.category == category &&
      other.location == location &&
      other.freezerId == freezerId;

  @override
  int get hashCode => hashValues(
        id,
        description,
        quantity,
        frozenOn,
        goodFor,
        category,
        location,
        freezerId,
      );

  FreezerItem copyWith({
    int? id,
    String? description,
    String? quantity,
    DateTime? frozenOn,
    int? goodFor,
    ItemCategory? category,
    String? location,
    int? freezerId,
  }) =>
      FreezerItem(
        id: id ?? this.id,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        frozenOn: frozenOn ?? this.frozenOn,
        goodFor: goodFor ?? this.goodFor,
        category: category ?? this.category,
        location: location ?? this.location,
        freezerId: freezerId ?? this.freezerId,
      );

  static List<FreezerItem> sort(
    final List<FreezerItem> items,
    final SortBy by,
  ) {
    var workingItems = [...items];

    workingItems.sort((a, b) {
      switch (by.field) {
        case SortByField.timeRemaining:
          return a.timeRemaining.compareTo(b.timeRemaining);
        case SortByField.description:
          return a.description.compareTo(b.description);
        case SortByField.frozenOn:
          return a.frozenOn.compareTo(b.frozenOn);
        case SortByField.category:
          return a.category.compareTo(b.category);
        default:
          return 0;
      }
    });

    return by.reversed ? workingItems.reversed.toList() : workingItems;
  }
}

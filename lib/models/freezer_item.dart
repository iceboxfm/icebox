import 'package:icebox/models/item_categories.dart';

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
        'id:"$id", description:"$description", location:"$location", '
        'category:"$category", quantity:"$quantity", frozenOn:$frozenOn, '
        'goodFor:$goodFor, freezerId:$freezerId)';
  }

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
}

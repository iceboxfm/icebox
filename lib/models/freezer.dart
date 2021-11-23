import 'package:flutter/material.dart';

enum FreezerType {
  chest,
  upright,
  drawer,
}

extension FreezerTypeExt on FreezerType {

  String get name {
    switch(this){
      case FreezerType.upright:
        return 'upright';
      case FreezerType.chest:
        return 'chest';
      case FreezerType.drawer:
        return 'drawer';
    }
  }

  Image? get image {
    // TOOD: move this out and just provide the path?
    return Image(image: AssetImage('assets/images/${name}_freezer.png'), width: 40);
  }

  static FreezerType? forName(final String name){
    if( name == 'upright'){
      return FreezerType.upright;
    } else if( name == 'chest'){
      return FreezerType.chest;
    } else if( name == 'drawer'){
      return FreezerType.drawer;
    } else {
      return null;
    }
  }
}

class Freezer {
  final int? id;
  final String description;
  final List<String> shelves;
  final FreezerType type;

  Freezer({
    this.id,
    required this.description,
    required this.shelves,
    required this.type,
  });

  Freezer copyWith({
    int? id,
    String? description,
    List<String>? shelves,
    FreezerType? type,
  }) =>
      Freezer(
        id: id ?? this.id,
        description: description ?? this.description,
        shelves: shelves ?? this.shelves,
        type: type ?? this.type,
      );

  @override
  String toString() =>
      'Freezer{id:$id, description:"$description", type:${type.name}, shelves:$shelves}';
}

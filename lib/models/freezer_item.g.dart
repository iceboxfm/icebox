// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freezer_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreezerItem _$FreezerItemFromJson(Map<String, dynamic> json) => FreezerItem(
      id: json['id'] as int?,
      description: json['description'] as String,
      quantity: json['quantity'] as String,
      frozenOn: DateTime.parse(json['frozenOn'] as String),
      goodFor: json['goodFor'] as int,
      category: ItemCategories.find(json['category'] as String?),
      location: json['location'] as String?,
      freezerId: json['freezerId'] as int?,
    );

Map<String, dynamic> _$FreezerItemToJson(FreezerItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'quantity': instance.quantity,
      'frozenOn': instance.frozenOn.toIso8601String(),
      'goodFor': instance.goodFor,
      'category': extractCategoryLabel(instance.category),
      'location': instance.location,
      'freezerId': instance.freezerId,
    };

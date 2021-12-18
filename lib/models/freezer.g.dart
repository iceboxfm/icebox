// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freezer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Freezer _$FreezerFromJson(Map<String, dynamic> json) => Freezer(
      id: json['id'] as int?,
      description: json['description'] as String,
      shelves:
          (json['shelves'] as List<dynamic>).map((e) => e as String).toList(),
      type: $enumDecode(_$FreezerTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$FreezerToJson(Freezer instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'shelves': instance.shelves,
      'type': _$FreezerTypeEnumMap[instance.type],
    };

const _$FreezerTypeEnumMap = {
  FreezerType.chest: 'chest',
  FreezerType.upright: 'upright',
  FreezerType.drawer: 'drawer',
};

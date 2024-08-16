// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmsDbGeometryModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DbGeometryModel _$DbGeometryModelFromJson(Map<String, dynamic> json) {
  return DbGeometryModel(
    coordinateSystemId: json['coordinateSystemId'] as int,
    wellKnownText: json['wellKnownText'] as String,
  );
}

Map<String, dynamic> _$DbGeometryModelToJson(DbGeometryModel instance) =>
    <String, dynamic>{
      'coordinateSystemId': instance.coordinateSystemId,
      'wellKnownText': instance.wellKnownText,
    };

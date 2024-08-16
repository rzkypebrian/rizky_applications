// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GoogleGeometryModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleGeometryModel _$GoogleGeometryModelFromJson(Map<String, dynamic> json) {
  return GoogleGeometryModel()
    ..location = json['location'] == null
        ? null
        : GooglePosition.fromJson(json['location'] as Map<String, dynamic>)
    ..viewport = json['viewport'] == null
        ? null
        : GoogleBoundsModel.fromJson(json['viewport'] as Map<String, dynamic>)
    ..icon = json['icon'] as String
    ..internationalhoneNumber = json['international_phone_number'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$GoogleGeometryModelToJson(
        GoogleGeometryModel instance) =>
    <String, dynamic>{
      'location': instance.location?.toJson(),
      'viewport': instance.viewport?.toJson(),
      'icon': instance.icon,
      'international_phone_number': instance.internationalhoneNumber,
      'name': instance.name,
    };

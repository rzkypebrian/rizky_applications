// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GooglePosition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GooglePosition _$GooglePositionFromJson(Map<String, dynamic> json) {
  return GooglePosition(
    lat: (json['lat'] as num)?.toDouble(),
    lon: (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$GooglePositionToJson(GooglePosition instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lon,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GoogleGeocoderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleGeocoderModel _$GoogleGeocoderModelFromJson(Map<String, dynamic> json) {
  return GoogleGeocoderModel(
    geocodedWaypoints: (json['geocoded_waypoints'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
    routes: (json['routes'] as List)
        ?.map((e) => e == null
            ? null
            : GoogleRouteModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GoogleGeocoderModelToJson(
        GoogleGeocoderModel instance) =>
    <String, dynamic>{
      'geocoded_waypoints': instance.geocodedWaypoints,
      'routes': instance.routes?.map((e) => e?.toJson())?.toList(),
    };

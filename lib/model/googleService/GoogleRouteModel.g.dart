// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GoogleRouteModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleRouteModel _$GoogleRouteModelFromJson(Map<String, dynamic> json) {
  return GoogleRouteModel()
    ..bounds = json['bounds'] == null
        ? null
        : GoogleBoundsModel.fromJson(json['bounds'] as Map<String, dynamic>)
    ..legs = (json['legs'] as List)
        ?.map((e) => e == null
            ? null
            : GoogleLegsModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..overViewPolyLineObject = json['overview_polyline']
    ..summary = json['summary'] as String;
}

Map<String, dynamic> _$GoogleRouteModelToJson(GoogleRouteModel instance) =>
    <String, dynamic>{
      'bounds': instance.bounds?.toJson(),
      'legs': instance.legs?.map((e) => e?.toJson())?.toList(),
      'overview_polyline': instance.overViewPolyLineObject,
      'summary': instance.summary,
    };

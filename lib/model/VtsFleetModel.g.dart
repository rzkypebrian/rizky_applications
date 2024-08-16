// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VtsFleetModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VtsFleetModel _$VtsFleetModelFromJson(Map<String, dynamic> json) {
  return VtsFleetModel(
    fleetId: json['fleet_id'] as int,
    fleetName: json['fleet_name'] as String,
    vehicles: (json['vehicles'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$VtsFleetModelToJson(VtsFleetModel instance) =>
    <String, dynamic>{
      'fleet_id': instance.fleetId,
      'fleet_name': instance.fleetName,
      'vehicles': instance.vehicles,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboardModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) {
  return DashboardModel(
    totalVehicles: json['totalVehicles'] as int,
    vehiclesInPool: json['vehiclesInPool'] as int,
    movingVehicles: json['movingVehicles'] as int,
    vehiclesNeedMaintenance: json['vehiclesNeedMaintenance'] as int,
  );
}

Map<String, dynamic> _$DashboardModelToJson(DashboardModel instance) =>
    <String, dynamic>{
      'totalVehicles': instance.totalVehicles,
      'vehiclesInPool': instance.vehiclesInPool,
      'movingVehicles': instance.movingVehicles,
      'vehiclesNeedMaintenance': instance.vehiclesNeedMaintenance,
    };

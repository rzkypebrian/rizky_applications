// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TmsDriverScoreModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmsDriverScoreModel _$TmsDriverScoreModelFromJson(Map<String, dynamic> json) {
  return TmsDriverScoreModel(
    driverId: json['driverId'] as int,
    driverName: json['driverName'] as String,
    driverScore: (json['driverScore'] as num)?.toDouble(),
    cancelShipment: json['cancelShipment'] as int,
    finishShipment: json['finishShipment'] as int,
    overSpeed: json['overSpeed'] as int,
    averageSpeed: (json['averageSpeed'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TmsDriverScoreModelToJson(
        TmsDriverScoreModel instance) =>
    <String, dynamic>{
      'driverId': instance.driverId,
      'driverName': instance.driverName,
      'driverScore': instance.driverScore,
      'cancelShipment': instance.cancelShipment,
      'finishShipment': instance.finishShipment,
      'overSpeed': instance.overSpeed,
      'averageSpeed': instance.averageSpeed,
    };

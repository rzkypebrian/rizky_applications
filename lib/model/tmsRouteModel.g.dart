// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmsRouteModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmsRouteModel _$TmsRouteModelFromJson(Map<String, dynamic> json) {
  return TmsRouteModel(
    routeId: json['routeId'] as int,
    memberId: json['memberId'] as int,
    routeName: json['routeName'] as String,
    routeCode: json['routeCode'] as String,
    fromGeofenceId: json['fromGeofenceId'] as int,
    toGeofenceId: json['toGeofenceId'] as int,
    twoWay: json['twoWay'] as bool,
    xmin: (json['xmin'] as num)?.toDouble(),
    ymin: (json['ymin'] as num)?.toDouble(),
    xmax: (json['xmax'] as num)?.toDouble(),
    ymax: (json['ymax'] as num)?.toDouble(),
    geom: json['geom'] == null ? null : DbGeometryModel.fromJson(json['geom']),
    buffer: json['buffer'] == null
        ? null
        : DbGeometryModel.fromJson(json['buffer']),
    bufferDistance: json['bufferDistance'] as int,
    waypoints: json['waypoints'] == null
        ? null
        : DbGeometryModel.fromJson(json['waypoints']),
    deleted: json['deleted'] as bool,
    insertedBy: json['insertedBy'] as String,
    insertedDate: json['insertedDate'] == null
        ? null
        : DateTime.parse(json['insertedDate'] as String),
    modifiedBy: json['modifiedBy'] as String,
    modifiedDate: json['modifiedDate'] == null
        ? null
        : DateTime.parse(json['modifiedDate'] as String),
  );
}

Map<String, dynamic> _$TmsRouteModelToJson(TmsRouteModel instance) =>
    <String, dynamic>{
      'routeId': instance.routeId,
      'memberId': instance.memberId,
      'routeName': instance.routeName,
      'routeCode': instance.routeCode,
      'fromGeofenceId': instance.fromGeofenceId,
      'toGeofenceId': instance.toGeofenceId,
      'twoWay': instance.twoWay,
      'xmin': instance.xmin,
      'ymin': instance.ymin,
      'xmax': instance.xmax,
      'ymax': instance.ymax,
      'geom': instance.geom?.toJson(),
      'buffer': instance.buffer?.toJson(),
      'bufferDistance': instance.bufferDistance,
      'waypoints': instance.waypoints?.toJson(),
      'deleted': instance.deleted,
      'insertedBy': instance.insertedBy,
      'insertedDate': instance.insertedDate?.toIso8601String(),
      'modifiedBy': instance.modifiedBy,
      'modifiedDate': instance.modifiedDate?.toIso8601String(),
    };
